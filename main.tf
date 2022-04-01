resource "helm_release" "cert_manager" {
  name                = "cert-manager"
  repository          = var.helm_repository
  repository_username = var.helm_repository_username
  repository_password = var.helm_repository_password
  chart               = "cert-manager"
  version             = "v${var.chart_version}"
  namespace           = var.helm_namespace

  set {
    name  = "installCRDs"
    value = "true"
  }

  values = [
    var.values,
  ]
}

resource "local_file" "issuer_letsencrypt_staging" {
  content = templatefile("${path.module}/config/issuer-letsencrypt-staging.yaml", {
    letsencrypt_email         = var.letsencrypt_email
    azure_subscription_id     = var.azure_subscription_id
    azure_resource_group_name = var.azure_resource_group_name
    azure_zone_name           = var.azure_zone_name
  })

  filename = "${path.module}/issuer-letsencrypt-staging.yaml"
}


resource "null_resource" "issuer_letsencrypt_staging" {
  triggers = {
    hash = sha256(local_file.issuer_letsencrypt_staging.content)
  }

  provisioner "local-exec" {
    command = "kubectl apply -f ${local_file.issuer_letsencrypt_staging.filename}"
  }
}

resource "local_file" "issuer_letsencrypt" {
  content = templatefile("${path.module}/config/issuer-letsencrypt.yaml", {
    letsencrypt_email         = var.letsencrypt_email
    azure_subscription_id     = var.azure_subscription_id
    azure_resource_group_name = var.azure_resource_group_name
    azure_zone_name           = var.azure_zone_name
  })

  filename = "${path.module}/issuer-letsencrypt.yaml"
}


resource "null_resource" "issuer_letsencrypt" {
  triggers = {
    hash = sha256(local_file.issuer_letsencrypt.content)
  }

  provisioner "local-exec" {
    command = "kubectl apply -f ${local_file.issuer_letsencrypt.filename}"
  }
}
