module "account" {
  count  = var.organization_managed ? 0 : 1
  source = "./modules/account"

  conformance_packs        = local.final_conformance_packs
  pack_name_prefix         = var.pack_name_prefix
  delivery_s3_bucket       = local.delivery_s3_bucket_final
  delivery_s3_key_prefix   = local.delivery_s3_key_prefix_final
  create_config_recorder   = local.should_create_config_recorder
  config_recorder_name     = local.config_recorder_name_final
  config_recorder_role_arn = local.config_recorder_role_arn_final
  create_delivery_channel  = local.should_create_delivery_channel
  delivery_channel_name    = local.delivery_channel_name_final
}

module "organization" {
  count  = var.organization_managed ? 1 : 0
  source = "./modules/organization"

  conformance_packs      = local.final_conformance_packs
  pack_name_prefix       = var.pack_name_prefix
  delivery_s3_bucket     = local.delivery_s3_bucket_final
  delivery_s3_key_prefix = local.delivery_s3_key_prefix_final
  excluded_accounts      = var.excluded_accounts
}
