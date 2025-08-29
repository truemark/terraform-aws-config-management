resource "aws_config_conformance_pack" "pack" {
  for_each = var.conformance_packs

  name                    = "${var.pack_name_prefix}${each.key}"
  template_body          = each.value.template_body
  delivery_s3_bucket     = var.delivery_s3_bucket
  delivery_s3_key_prefix = var.delivery_s3_key_prefix

  dynamic "input_parameter" {
    for_each = try(each.value.input_parameters, {})
    content {
      parameter_name  = input_parameter.key
      parameter_value = tostring(input_parameter.value)
    }
  }

  depends_on = [aws_config_configuration_recorder.recorder]
}

# Configuration recorder is required for conformance packs
resource "aws_config_configuration_recorder" "recorder" {
  count    = var.create_config_recorder ? 1 : 0
  name     = var.config_recorder_name
  role_arn = var.config_recorder_role_arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

# Delivery channel is required for conformance packs
resource "aws_config_delivery_channel" "channel" {
  count           = var.create_delivery_channel ? 1 : 0
  name            = var.delivery_channel_name
  s3_bucket_name  = var.delivery_s3_bucket
  s3_key_prefix   = var.delivery_s3_key_prefix
}
