# Terraform Kubernetes Cert Manager

## Introduction

This module deploys and configures Cert Manager inside a Kubernetes Cluster.

## Security Controls

The following security controls can be met through configuration of this template:

* TBD

## Dependancies

* None

## Usage

```terraform
module "helm_cert_manager" {
  source = "github.com/canada-ca-terraform-modules/terraform-kubernetes-cert-manager?ref=20190725.1"

  chart_version = "0.8.1"
  dependencies = [
    "${module.namespace_cert_manager.depended_on}",
  ]

  helm_service_account = "tiller"
  helm_namespace = "${kubernetes_namespace.cert_manager.metadata.0.name}"
  helm_repository = "jetstack"

  letsencrypt_email = "${var.cert_manager_letsencrypt_email}"
  azure_service_principal_id = "${var.cert_manager_azure_service_principal_id}"
  azure_client_secret = "${var.cert_manager_azure_client_secret}"
  azure_subscription_id = "${var.cert_manager_azure_subscription_id}"
  azure_tenant_id = "${var.cert_manager_azure_tenant_id}"
  azure_resource_group_name = "${var.cert_manager_azure_resource_group_name}"
  azure_zone_name = "${var.cert_manager_azure_zone_name}"

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

| Name                 | Type   | Required | Value                                               |
| -------------------- | ------ | -------- | --------------------------------------------------- |
| chart_version        | string | yes      | Version of the Helm Chart                           |
| dependencies         | string | yes      | Dependency name refering to namespace module        |
| helm_service_account | string | yes      | The service account for Helm to use                 |
| helm_namespace       | string | yes      | The namespace Helm will install the chart under     |
| helm_repository      | string | yes      | The repository where the Helm chart is stored       |
| values               | list   | no       | Values to be passed to the Helm Chart               |

## History

| Date     | Release    | Change      |
| -------- | ---------- | ----------- |
| 20190909 | 20190909.1 | 1st release |
