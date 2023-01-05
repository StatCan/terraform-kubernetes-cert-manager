resource "kubernetes_manifest" "prometheusrule_cert_manager_alerts" {
  count = var.enable_prometheusrules ? 1 : 0
  manifest = {
    "apiVersion" = "monitoring.coreos.com/v1"
    "kind"       = "PrometheusRule"
    "metadata" = {
      "name"      = "cert-manager-alerts"
      "namespace" = var.helm_namespace
      "labels"    = merge(local.common_labels, { "app.kubernetes.io/name" = "cert-manager-alerts" })
      "annotations" = {
        "rules-definition" = "https://gitlab.k8s.cloud.statcan.ca/cloudnative/terraform/modules/terraform-kubernetes-cert-manager/-/tree/master/prometheus_rules/cert_manager_rules.yaml"
      }
    }
    "spec" = yamldecode(file("${path.module}/prometheus_rules/cert_manager_rules.yaml"))
  }
}
