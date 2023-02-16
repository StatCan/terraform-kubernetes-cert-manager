resource "kubernetes_manifest" "clusterissuer_letsencrypt" {
  count = var.deploy_cluster_issuers ? 1 : 0

  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name"   = "letsencrypt"
      "labels" = local.common_labels
    }
    "spec" = {
      "acme" = {
        "email"          = var.letsencrypt_email
        "preferredChain" = ""
        "privateKeySecretRef" = {
          "name" = "letsencrypt"
        }
        "server" = "https://acme-v02.api.letsencrypt.org/directory"
        "solvers" = [
          {
            "dns01" = {
              "cnameStrategy" = "Follow"
              "azureDNS" = {
                "hostedZoneName"    = var.azure_zone_name
                "resourceGroupName" = var.azure_resource_group_name
                "subscriptionID"    = var.azure_subscription_id
              }
            }
            "selector" = {
              "matchLabels" = {
                "use-azuredns-solver" = "true"
              }
            }
          },
        ]
      }
    }
  }
}
