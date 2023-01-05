# Terraform Kubernetes Cert Manager

## Introduction

This module deploys and configures Cert Manager inside a Kubernetes Cluster.

## Security Controls

The following security controls can be met through configuration of this template:

* TBD

## Dependencies

* None

## Optional (depending on options configured):

* None

## Usage

```terraform
module "helm_cert_manager" {
  source = "github.com/canada-ca-terraform-modules/terraform-kubernetes-cert-manager?ref=v4.0.0"

  chart_version = "0.8.1"
  depends_on  = [
    module.namespace_cert_manager,
  ]

  helm_namespace  = module.namespace_cert_manager.name
  helm_repository = "jetstack"

  letsencrypt_email            = var.cert_manager_letsencrypt_email
  azure_subscription_id        = var.cert_manager_azure_subscription_id
  azure_resource_group_name    = var.cert_manager_azure_resource_group_name
  azure_zone_name              = var.cert_manager_azure_zone_name

  values = <<EOF
podDnsConfig:
  nameservers:
    - 1.1.1.1
    - 1.0.0.1
    - 8.8.8.8
EOF
}
```

## Variables Values

| Name                     | Type   | Required | Value                                              |
|--------------------------|--------|----------|----------------------------------------------------|
| chart_name               | string | no       | Name of the Helm Chart                             |
| chart_version            | string | no       | Version of the Helm Chart                          |
| enable_prometheusrules   | string | no       | Adds PrometheusRules for cert-manager alerts       |
| helm_namespace           | string | no       | The namespace Helm will install the chart under    |
| helm_repository          | string | no       | The repository where the Helm chart is stored      |
| helm_repository_username | string | no       | Username to access the Helm repository             |
| helm_repository_password | string | no       | Password to access the Helm repository             |
| values                   | string | no       | Values to be passed to the Helm Chart              |

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
