locals {
  common_labels = {
    "app.kubernetes.io/managed-by" = "terraform"
    "app.kubernetes.io/version"    = "v5.3.0"
    "app.kubernetes.io/part-of"    = "cert-manager"
  }
  runbook_base_url = "https://cloudnative.pages.cloud.statcan.ca/en/documentation/monitoring-surveillance/prometheus"
}
