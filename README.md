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
  source = "github.com/canada-ca-terraform-modules/terraform-kubernetes-cert-manager?ref=v2.0.0"

  chart_version = "0.8.1"
  dependencies  = [
    module.namespace_cert_manager.depended_on,
  ]

  helm_namespace  = kubernetes_namespace.cert_manager.metadata.0.name
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

| Name                     | Type   | Required | Value                                           |
|--------------------------|--------|----------|-------------------------------------------------|
| chart_version            | string | no       | Version of the Helm Chart                       |
| chart_name               | string | no       | Name of the Helm Chart                          |
| helm_namespace           | string | no       | The namespace Helm will install the chart under |
| helm_repository          | string | no       | The repository where the Helm chart is stored   |
| helm_repository_username | string | no       | Username to access the Helm repository          |
| helm_repository_password | string | no       | Password to access the Helm repository          |
| values                   | string | no       | Values to be passed to the Helm Chart           |

## History

| Date     | Release    | Change                                       |
| -------- | ---------- | -------------------------------------------- |
| 20190729 | 20190729.1 | Improvements to documentation and formatting |
| 20190909 | 20190909.1 | 1st release                                  |
| 20200620 | v2.0.0     | Module now modified for Helm 3               |
| 20200622 | v2.0.1     | Added dependencies to kubernetes_secret      |
| 20201105 | v2.0.2     | Add registry username/password support       |
| 20210114 | v2.0.3     | Removed interpolation syntax                 |
