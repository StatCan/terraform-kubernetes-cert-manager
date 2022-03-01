variable "helm_namespace" {
  default = "cert-manager-system"
}

variable "helm_repository" {
  default = "https://charts.jetstack.io"
}

variable "helm_repository_username" {
  default = ""
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
