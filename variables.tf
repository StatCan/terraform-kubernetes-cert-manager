variable "helm_namespace" {
  default = "cert-manager-system"
}

variable "helm_repository" {
  default = "https://charts.jetstack.io"
}

variable "helm_repository_username" {
  default = ""
  type    = string
}

variable "helm_repository_password" {
  default = ""
}

variable "chart_version" {
  default = "1.6.2"
}

variable "chart_name" {
  default = "cert-manager"
}

variable "values" {
  default = ""
  type    = string
}

# Configuration
variable "letsencrypt_email" {}
variable "azure_subscription_id" {}
variable "azure_resource_group_name" {}
variable "azure_zone_name" {}
