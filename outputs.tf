output "helm_namespace" {
  description = "the namespace containing the cert-manager helm release artifacts"
  value       = var.helm_namespace
}

output "release_name" {
  description = "the name of the cert-manager helm release"
  value       = helm_release.cert_manager.name
}
