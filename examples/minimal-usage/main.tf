# Minimal usage example - AWS Config auto-discovery
# This example demonstrates the simplest possible usage where AWS Config

provider "aws" {
  region = var.aws_region
}

# Deploy multiple compliance frameworks with minimal configuration
module "compliance_minimal" {
  source = "../../"

  # Just specify the conformance packs you want to deploy
  # Templates are automatically fetched from AWS's official repository
  conformance_packs = ["hipaa", "pci-dss", "nist-800-171"]

  # Optional: Add a prefix to conformance pack names
  pack_name_prefix = "test-"

  # Required: S3 bucket for conformance pack results (replace with your existing Config bucket name)
  delivery_s3_bucket = "<bucket_name>"

  # Assume AWS Config is already set up - don't create new Config resources
  create_config_recorder   = false
  create_delivery_channel  = false
}
#
# Deploy a single conformance pack (even simpler)
module "single_pack" {
  source = "../../"

  conformance_packs = ["pci-dss"]

  # Required: S3 bucket for conformance pack results (replace with your existing Config bucket name)
  delivery_s3_bucket = "<bucket_name>"

  # Assume AWS Config is already set up - don't create new Config resources
  create_config_recorder   = false
  create_delivery_channel  = false
}

# Deploy with parameter customization
module "customized_compliance" {
  source = "../../"

  conformance_packs = ["nist-800-171"]

  # Override specific parameters for stricter compliance
  conformance_pack_parameters = {
    "nist-800-171" = {
      # Stricter password requirements
      IamPasswordPolicyParamMinimumPasswordLength = "16"
      IamPasswordPolicyParamMaxPasswordAge        = "60"
      
      # Faster GuardDuty response times
      GuarddutyNonArchivedFindingsParamDaysHighSev = "1"
    }
  }

  pack_name_prefix = "strict-"
  
  # Required: S3 bucket for conformance pack results (replace with your existing Config bucket name)
  delivery_s3_bucket = "<bucket_name>"
  
  # Assume AWS Config is already set up - don't create new Config resources
  create_config_recorder   = false
  create_delivery_channel  = false
}
