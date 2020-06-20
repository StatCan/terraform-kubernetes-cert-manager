terraform {
  required_providers {
    helm = {
      version = ">= 1.0.0"
    }

    kubernetes = {
      version = ">= 1.10.0"
    }
  }
}