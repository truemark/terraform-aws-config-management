resource "aws_config_organization_conformance_pack" "pack" {
  for_each = var.conformance_packs

  name                    = "${var.pack_name_prefix}${each.key}"
  template_body          = each.value.template_body
  delivery_s3_bucket     = var.delivery_s3_bucket
  delivery_s3_key_prefix = var.delivery_s3_key_prefix
  excluded_accounts      = var.excluded_accounts

  dynamic "input_parameter" {
    for_each = try(each.value.input_parameters, {})
    content {
      parameter_name  = input_parameter.key
      parameter_value = tostring(input_parameter.value)
    }
  }
}
