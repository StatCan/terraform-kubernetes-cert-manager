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
  source = "github.com/canada-ca-terraform-modules/terraform-kubernetes-cert-manager?ref=v3.0.0"

  chart_version = "0.8.1"
  depends_on  = [
    module.namespace_cert_manager,
  ]

  helm_namespace  = module.namespace_cert_manager.name
  helm_repository = "jetstack"

  letsencrypt_email            = var.cert_manager_letsencrypt_email
  azure_service_principal_id   = var.cert_manager_azure_service_principal_id
  azure_client_secret          = var.cert_manager_azure_client_secret
  azure_subscription_id        = var.cert_manager_azure_subscription_id
  azure_tenant_id              = var.cert_manager_azure_tenant_id
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

| Name                       | Type   | Required | Value                                                |
| -------------------------- | ------ | -------- | ---------------------------------------------------- |
| chart_version              | string | yes      | Version of the Helm Chart                            |
| helm_namespace             | string | yes      | The namespace Helm will install the chart under      |
| helm_repository            | string | yes      | The repository where the Helm chart is stored        |
| values                     | string | no       | Values to be passed to the Helm Chart                |
| letsencrypt_email          | string | yes      | Email for letsencrypt                                |
| azure_service_principal_id | string | yes      | ClientID of the principal to use for azuredns solver |
| azure_client_secret        | string | yes      | The client secret for the principal used             |
| azure_subscription_id      | string | yes      | The Azure Subsription ID of the azuredns             |
| azure_tenant_id            | string | yes      | The Azure Tenant ID of the azuredns                  |
| azure_resource_group_name  | string | yes      | The Resource Group of the azuredns                   |
| azure_zone_name            | string | yes      | The Zone Name in which the azuredns resides          |

## History

| Date     | Release    | Change                                       |
| -------- | ---------- | -------------------------------------------- |
| 20190729 | 20190729.1 | Improvements to documentation and formatting |
| 20190909 | 20190909.1 | 1st release                                  |
| 20200620 | v2.0.0     | Module now modified for Helm 3               |
| 20200622 | v2.0.1     | Added dependencies to kubernetes_secret      |
| 20201105 | v2.0.2     | Add registry username/password support       |
| 20210114 | v2.0.3     | Removed interpolation syntax                 |
| 20210826 | v3.0.0     | Updated module for Terraform v0.13           |
