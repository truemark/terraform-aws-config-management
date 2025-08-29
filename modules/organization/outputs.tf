output "conformance_pack_arns" {
  description = "ARNs of the created organization conformance packs"
  value       = { for k, v in aws_config_organization_conformance_pack.pack : k => v.arn }
}

output "conformance_pack_names" {
  description = "Names of the created organization conformance packs"
  value       = { for k, v in aws_config_organization_conformance_pack.pack : k => v.name }
}
