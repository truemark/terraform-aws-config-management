output "conformance_pack_arns" {
  description = "ARNs of the created conformance packs"
  value = var.organization_managed ? (
    length(module.organization) > 0 ? module.organization[0].conformance_pack_arns : {}
  ) : (
    length(module.account) > 0 ? module.account[0].conformance_pack_arns : {}
  )
}

output "conformance_pack_names" {
  description = "Names of the created conformance packs"
  value = var.organization_managed ? (
    length(module.organization) > 0 ? module.organization[0].conformance_pack_names : {}
  ) : (
    length(module.account) > 0 ? module.account[0].conformance_pack_names : {}
  )
}

output "config_recorder_name" {
  description = "Name of the AWS Config configuration recorder (account mode only)"
  value       = var.organization_managed ? null : (length(module.account) > 0 ? module.account[0].config_recorder_name : null)
}

output "delivery_channel_name" {
  description = "Name of the AWS Config delivery channel (account mode only)"
  value       = var.organization_managed ? null : (length(module.account) > 0 ? module.account[0].delivery_channel_name : null)
}

output "deployed_conformance_packs" {
  description = "List of conformance packs that were deployed"
  value       = keys(local.final_conformance_packs)
}
