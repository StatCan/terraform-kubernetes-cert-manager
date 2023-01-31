locals {
  # The curent version of the release.
  version = "v5.4.1"
  # The name of this module.
  app_name = "terraform-kubernetes-cert-manager"

  common_labels = {
    "app.kubernetes.io/managed-by" = "terraform"
    "app.kubernetes.io/version"    = local.version
    "app.kubernetes.io/part-of"    = "cert-manager"
    "app.kubernetes.io/name"       = local.app_name
  }
  runbook_base_url = "https://cloudnative.pages.cloud.statcan.ca/en/documentation/monitoring-surveillance/prometheus"
}
