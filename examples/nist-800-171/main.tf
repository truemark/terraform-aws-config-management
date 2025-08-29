module "nist_800_171_conformance_pack" {
  source = "../../"

  # Deploy the NIST 800-171 conformance pack
  conformance_packs = ["nist-800-171"]

  # Optional: Override default parameters for the conformance pack
  conformance_pack_parameters = {
    "nist-800-171" = {
      # Override IAM password policy parameters
      IamPasswordPolicyParamMinimumPasswordLength = "16"
      IamPasswordPolicyParamMaxPasswordAge        = "60"
      
      # Override GuardDuty finding parameters
      GuarddutyNonArchivedFindingsParamDaysHighSev   = "1"
      GuarddutyNonArchivedFindingsParamDaysMediumSev = "3"
      GuarddutyNonArchivedFindingsParamDaysLowSev    = "15"
      
      # Override S3 public access block parameters
      S3AccountLevelPublicAccessBlocksPeriodicParamBlockPublicAcls     = "true"
      S3AccountLevelPublicAccessBlocksPeriodicParamBlockPublicPolicy   = "true"
      S3AccountLevelPublicAccessBlocksPeriodicParamIgnorePublicAcls    = "true"
      S3AccountLevelPublicAccessBlocksPeriodicParamRestrictPublicBuckets = "true"
    }
  }

  # Required: S3 bucket for Config delivery channel
  delivery_s3_bucket     = "my-config-bucket"
  delivery_s3_key_prefix = "config"

  # Optional: Prefix for conformance pack names
  pack_name_prefix = "my-org-"

  # Account mode configuration (set to false for organization mode)
  organization_managed = false

  # Config recorder settings (account mode only)
  create_config_recorder   = true
  config_recorder_name     = "default"
  config_recorder_role_arn = "arn:aws:iam::123456789012:role/aws-config-role"

  # Delivery channel settings (account mode only)
  create_delivery_channel = true
  delivery_channel_name   = "default"
}
