# Example: Deploy HIPAA Compliance Pack with automatic Config discovery

module "hipaa_compliance" {
  source = "../../"

  # Deploy HIPAA conformance pack - template automatically fetched from AWS
  conformance_packs = ["hipaa"]

  # Use latest templates (default behavior)
  template_version = "latest"

  # AWS Config setup is automatically discovered from existing Config
  # No need to provide delivery_s3_bucket or config_recorder_role_arn
  # if AWS Config is already set up in your account

  # Override specific parameters for stricter compliance
  conformance_pack_parameters = {
    "hipaa" = {
      # Stricter password requirements
      IamPasswordPolicyParamMinimumPasswordLength = "16"
      IamPasswordPolicyParamMaxPasswordAge        = "60"
      IamPasswordPolicyParamPasswordReusePrevention = "24"

      # Faster incident response for GuardDuty findings
      GuarddutyNonArchivedFindingsParamDaysHighSev   = "1"
      GuarddutyNonArchivedFindingsParamDaysMediumSev = "3"
      GuarddutyNonArchivedFindingsParamDaysLowSev    = "7"

      # Stricter access key rotation
      IamUserUnusedCredentialsCheckParamMaxCredentialUsageAge = "60"
    }
  }

  # Optional: Override auto-discovered settings if needed
  # delivery_s3_bucket     = "my-custom-config-bucket"
  # config_recorder_role_arn = "arn:aws:iam::123456789012:role/custom-config-role"

  # Naming prefix for conformance packs
  pack_name_prefix = "healthcare-"
}

# Example with minimal configuration - just specify the conformance pack
module "simple_hipaa" {
  source = "../../"

  conformance_packs = ["hipaa"]

  # Everything else is automatically discovered or uses defaults
}
