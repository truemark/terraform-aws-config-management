# output "compliance_minimal_pack_arns" {
#   description = "ARNs of the conformance packs deployed by the minimal compliance module"
#   value       = module.compliance_minimal.conformance_pack_arns
# }
#
# output "compliance_minimal_pack_names" {
#   description = "Names of the conformance packs deployed by the minimal compliance module"
#   value       = module.compliance_minimal.conformance_pack_names
# }
#
# output "single_pack_arns" {
#   description = "ARNs of the conformance packs deployed by the single pack module"
#   value       = module.single_pack.conformance_pack_arns
# }

output "customized_compliance_pack_arns" {
  description = "ARNs of the conformance packs deployed by the customized compliance module"
  value       = module.customized_compliance.conformance_pack_arns
}

# output "all_deployed_packs" {
#   description = "Summary of all deployed conformance packs"
#   value = {
#     minimal_compliance = module.compliance_minimal.deployed_conformance_packs
#     single_pack       = module.single_pack.deployed_conformance_packs
#     customized        = module.customized_compliance.deployed_conformance_packs
#   }
# }
