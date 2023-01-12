# Terraform Kubernetes Cert Manager

## Introduction

This module deploys and configures Cert Manager inside a Kubernetes Cluster.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.10.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_resource_group_name"></a> [azure\_resource\_group\_name](#input\_azure\_resource\_group\_name) | the azure resource group containing the required AzureDNS resources | `string` | n/a | yes |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | the azure subscription ID for the subscription containing the AzureDNS for ACME DNS challenge | `string` | n/a | yes |
| <a name="input_azure_zone_name"></a> [azure\_zone\_name](#input\_azure\_zone\_name) | the name of the azureDNS zone to use for ACME configuration | `string` | n/a | yes |
| <a name="input_letsencrypt_email"></a> [letsencrypt\_email](#input\_letsencrypt\_email) | the email to associated with letsencrypt ACME account for generating/signing of certificates | `string` | n/a | yes |
| <a name="input_chart_name"></a> [chart\_name](#input\_chart\_name) | the name of the cert-manager chart to use | `string` | `"cert-manager"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | the version of the cert-manager chart to use. do not include 'v' prefix in this value | `string` | `"1.11.0"` | no |
| <a name="input_enable_prometheusrules"></a> [enable\_prometheusrules](#input\_enable\_prometheusrules) | Adds PrometheusRules for cert-manager alerts | `bool` | `true` | no |
| <a name="input_helm_namespace"></a> [helm\_namespace](#input\_helm\_namespace) | the namespace where cert-manager resources should be deployed | `string` | `"cert-manager-system"` | no |
| <a name="input_helm_repository"></a> [helm\_repository](#input\_helm\_repository) | the helm chart repository to use as the source for cert-manager | `string` | `"https://charts.jetstack.io"` | no |
| <a name="input_helm_repository_password"></a> [helm\_repository\_password](#input\_helm\_repository\_password) | the helm repository password to use (IFF authentication is required by the repository) | `string` | `""` | no |
| <a name="input_helm_repository_username"></a> [helm\_repository\_username](#input\_helm\_repository\_username) | the helm repository username to use (IFF authentication is required by the repository) | `string` | `""` | no |
| <a name="input_values"></a> [values](#input\_values) | any additional helm chart values to pass to the helm\_release resource. will be merged with existing values | `string` | `""` | no |

## Usage

```terraform
module "helm_cert_manager" {
  source         = "github.com/canada-ca-terraform-modules/terraform-kubernetes-cert-manager?ref=v5.4.0"
  helm_namespace = module.namespace_cert_manager.name

  letsencrypt_email         = var.cert_manager_letsencrypt_email
  azure_subscription_id     = var.cert_manager_azure_subscription_id
  azure_resource_group_name = var.cert_manager_azure_resource_group_name
  azure_zone_name           = var.cert_manager_azure_zone_name

  values = <<EOF
podDnsConfig:
  nameservers:
    - 1.1.1.1
    - 1.0.0.1
    - 8.8.8.8
EOF

  depends_on = [
    module.namespace_cert_manager,
  ]
}
```

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_helm_namespace"></a> [helm\_namespace](#output\_helm\_namespace) | the namespace containing the cert-manager helm release artifacts |
| <a name="output_release_name"></a> [release\_name](#output\_release\_name) | the name of the cert-manager helm release |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## History

| Date     | Release    | Change                                                     |
|----------| -----------| -----------------------------------------------------------|
| 20190729 | 20190729.1 | Improvements to documentation and formatting               |
| 20190909 | 20190909.1 | 1st release                                                |
| 20200620 | v2.0.0     | Module now modified for Helm 3                             |
| 20200622 | v2.0.1     | Added dependencies to kubernetes_secret                    |
| 20201105 | v2.0.2     | Add registry username/password support                     |
| 20210114 | v2.0.3     | Removed interpolation syntax                               |
| 20210826 | v3.0.0     | Updated module for Terraform v0.13                         |
| 20220401 | v4.0.0     | Updated module to allow use of MSI                         |
| 20220401 | v4.0.1     | Updated module to cert-manager.io/v1                       |
| 20220411 | v5.0.0     | Convert module to k8s manifest resource                    |
| 20220721 | v5.1.0     | Set the cnameStrategy to "Follow" for the DNS01 solver.    |
| 20230105 | v5.2.0     | Added cert manager rules from kube-prometheus-stack        |
| 20230109 | v5.3.0     | Add runbook links to Prometheus rules                      |
| 20230111 | v5.4.0     | Upgraded default chart-version to use latest cert-manager available                      |
