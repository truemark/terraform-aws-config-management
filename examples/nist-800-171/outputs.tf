output "conformance_pack_arns" {
  description = "ARNs of the deployed conformance packs"
  value       = module.nist_800_171_conformance_pack.conformance_pack_arns
}

output "conformance_pack_names" {
  description = "Names of the deployed conformance packs"
  value       = module.nist_800_171_conformance_pack.conformance_pack_names
}

output "deployed_conformance_packs" {
  description = "List of conformance packs that were deployed"
  value       = module.nist_800_171_conformance_pack.deployed_conformance_packs
}

output "config_recorder_name" {
  description = "Name of the AWS Config configuration recorder"
  value       = module.nist_800_171_conformance_pack.config_recorder_name
}

output "delivery_channel_name" {
  description = "Name of the AWS Config delivery channel"
  value       = module.nist_800_171_conformance_pack.delivery_channel_name
}
