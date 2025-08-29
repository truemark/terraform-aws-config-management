output "conformance_pack_arns" {
  description = "ARNs of the created conformance packs"
  value       = { for k, v in aws_config_conformance_pack.pack : k => v.arn }
}

output "conformance_pack_names" {
  description = "Names of the created conformance packs"
  value       = { for k, v in aws_config_conformance_pack.pack : k => v.name }
}

output "config_recorder_name" {
  description = "Name of the AWS Config configuration recorder"
  value       = var.create_config_recorder ? aws_config_configuration_recorder.recorder[0].name : null
}

output "delivery_channel_name" {
  description = "Name of the AWS Config delivery channel"
  value       = var.create_delivery_channel ? aws_config_delivery_channel.channel[0].name : null
}
