locals {
  common_labels = {
    "app.kubernetes.io/managed-by" = "terraform"
    "app.kubernetes.io/version"    = "v5.2.0"
    "app.kubernetes.io/part-of"    = "cert-manager"
  }
}
