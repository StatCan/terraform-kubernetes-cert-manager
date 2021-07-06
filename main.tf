resource "helm_release" "cert_manager" {
  name                = "cert-manager"
  repository          = var.helm_repository
  repository_username = var.helm_repository_username
  repository_password = var.helm_repository_password
  chart               = var.chart_name
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
