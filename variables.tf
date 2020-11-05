variable "helm_namespace" {}
variable "helm_repository" {}
variable "helm_repository_username" {}
variable "helm_repository_password" {}
variable "chart_version" {}
variable "values" {
  default = ""
  type    = "string"
}

variable "letsencrypt_email" {}
variable "azure_service_principal_id" {}
variable "azure_client_secret" {}
variable "azure_subscription_id" {}
variable "azure_tenant_id" {}
variable "azure_resource_group_name" {}
variable "azure_zone_name" {}

variable "dependencies" {
  type = "list"
}
