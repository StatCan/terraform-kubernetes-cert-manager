# Part of a hack for module-to-module dependencies.
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
# and
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-473091030
# Make sure to add this null_resource.dependency_getter to the `depends_on`
# attribute to all resource(s) that will be constructed first within this
# module:
resource "null_resource" "dependency_getter" {
  triggers = {
    my_dependencies = "${join(",", var.dependencies)}"
  }
}

resource "null_resource" "wait-dependencies" {
  provisioner "local-exec" {
    command = "helm ls --tiller-namespace ${var.helm_namespace}"
  }

  depends_on = [
    "null_resource.dependency_getter",
  ]
}


resource "null_resource" "apply_crds" {
  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/v${var.chart_version}/deploy/manifests/00-crds.yaml"
  }

  depends_on = [
    "null_resource.dependency_getter",
  ]
}


resource "helm_release" "cert_manager" {
  depends_on = ["null_resource.wait-dependencies", "null_resource.dependency_getter", "null_resource.apply_crds"]
  name = "cert-manager"
  repository = "${var.helm_repository}"
  chart = "cert-manager"
  version = "v${var.chart_version}"
  namespace = "${var.helm_namespace}"

  values = [
    "${var.values}",
  ]
}

# Part of a hack for module-to-module dependencies.
# https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
resource "null_resource" "dependency_setter" {
  # Part of a hack for module-to-module dependencies.
  # https://github.com/hashicorp/terraform/issues/1178#issuecomment-449158607
  # List resource(s) that will be constructed last within the module.
  depends_on = [
    "helm_release.cert_manager"
  ]
}
