variable "helm_namespace" {
  type        = string
  description = "the namespace where cert-manager resources should be deployed"
  default     = "cert-manager-system"
}

variable "helm_repository" {
  type        = string
  description = "the helm chart repository to use as the source for cert-manager"
  default     = "https://charts.jetstack.io"
}

variable "helm_repository_username" {
  type        = string
  nullable    = false
  description = "the helm repository username to use (IFF authentication is required by the repository)"
  sensitive   = true
  default     = ""
}

variable "helm_repository_password" {
  type        = string
  nullable    = false
  description = "the helm repository password to use (IFF authentication is required by the repository)"
  sensitive   = true
  default     = ""
}

variable "chart_version" {
  type        = string
  description = "the version of the cert-manager chart to use. do not include 'v' prefix in this value"
  default     = "1.11.0"

  validation {
    condition     = !startswith(var.chart_version, "v")
    error_message = "chart_version MUST NOT include a version prefix (ie: 'v')"
  }
}

variable "chart_name" {
  type        = string
  description = "the name of the cert-manager chart to use"
  default     = "cert-manager"
}

variable "values" {
  type        = string
  description = "any additional helm chart values to pass to the helm_release resource. will be merged with existing values"
  default     = ""
}

variable "enable_prometheusrules" {
  type        = bool
  description = "Adds PrometheusRules for cert-manager alerts"
  default     = true
}

variable "letsencrypt_email" {
  type        = string
  nullable    = false
  description = "the email to associated with letsencrypt ACME account for generating/signing of certificates"
  sensitive   = true
}

variable "azure_subscription_id" {
  type        = string
  description = "the azure subscription ID for the subscription containing the AzureDNS for ACME DNS challenge"
}

variable "azure_resource_group_name" {
  type        = string
  description = "the azure resource group containing the required AzureDNS resources"
}

variable "azure_zone_name" {
  type        = string
  description = "the name of the azureDNS zone to use for ACME configuration"
}

variable "deploy_cluster_issuers" {
  type        = bool
  description = "a boolean which determines if the cluster issuers for Let's Encrypt should be deployed"
  default     = true
  nullable    = false
}
