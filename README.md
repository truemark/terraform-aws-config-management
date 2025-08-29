# Terraform AWS Config Management

This Terraform module deploys AWS Config Conformance Packs to help ensure compliance with various security frameworks and best practices.

## Features

- **Conformance Pack Deployment**: Deploy complete AWS Config Conformance Packs instead of individual rules
- **Multiple Frameworks**: Support for NIST 800-171 and other compliance frameworks
- **Flexible Deployment**: Support for both account-level and organization-level deployment
- **Parameter Customization**: Override default conformance pack parameters
- **Automated Config Setup**: Automatically creates Config recorder and delivery channel when needed

## Available Conformance Packs

The module now supports **50+ compliance frameworks** with automatic template fetching from AWS's official repository. No manual template files required!

**Major Frameworks:**
- **NIST**: 800-171, 800-53 (rev4/rev5), 800-172, 800-181, 1800-25, CSF, Privacy Framework
- **HIPAA**: Security requirements
- **PCI DSS**: Payment card industry standards
- **SOX**: Sarbanes-Oxley compliance
- **FedRAMP**: Low, Moderate, High levels
- **CIS**: Benchmarks, Critical Security Controls (v8 IG1/IG2/IG3), Top 20
- **CMMC**: Levels 1-5, CMMC 2.0 Levels 1-2
- **Financial**: FFIEC, Gramm-Leach-Bliley, NYDFS, APRA CPG-234
- **International**: ENISA, NCSC CAF, ACSC Essential 8/ISM, Germany C5, K-ISMS
- **Regional**: MAS TRMG/Notice 655, RBI, SWIFT CSP, BNM RMiT, NBC TRMG
- **Industry**: CJIS, IRS 1075, FDA 21CFR Part 11, GxP EU Annex 11, NERC CIP
- **Government**: CISA Cyber Essentials, AWS Control Tower

**Complete list available in `locals.tf` - just specify the pack name!**

## Usage

### Basic Example - Account Level (Auto-Discovery)

```hcl
module "compliance" {
  source = "path/to/terraform-aws-config-management"

  # Deploy any conformance pack - templates automatically fetched!
  conformance_packs = ["hipaa", "pci-dss", "nist-800-171"]

  # AWS Config setup is automatically discovered from existing Config
  # No need to provide delivery_s3_bucket or config_recorder_role_arn
  # if AWS Config is already set up in your account (99% of cases)
}
```

### Manual Config Setup (if needed)

```hcl
module "compliance" {
  source = "path/to/terraform-aws-config-management"

  conformance_packs = ["hipaa", "pci-dss", "nist-800-171"]

  # Only required if AWS Config is not already set up
  delivery_s3_bucket = "my-config-bucket"
  config_recorder_role_arn = "arn:aws:iam::123456789012:role/aws-config-role"
}
```

### Template Version Control

```hcl
module "compliance" {
  source = "path/to/terraform-aws-config-management"

  conformance_packs = ["hipaa"]
  
  # Control template versions
  template_version = "latest"        # Always use latest (default)
  # template_version = "abc123def"   # Pin to specific commit
  # template_version = "v2.1.0"     # Pin to specific tag

  delivery_s3_bucket = "my-config-bucket"
  config_recorder_role_arn = "arn:aws:iam::123456789012:role/aws-config-role"
}
```

### Advanced Example - With Parameter Overrides

```hcl
module "nist_compliance" {
  source = "path/to/terraform-aws-config-management"

  # Deploy NIST 800-171 conformance pack
  conformance_packs = ["nist-800-171"]

  # Override conformance pack parameters
  conformance_pack_parameters = {
    "nist-800-171" = {
      # Stricter password policy
      IamPasswordPolicyParamMinimumPasswordLength = "16"
      IamPasswordPolicyParamMaxPasswordAge        = "60"
      
      # Faster GuardDuty response times
      GuarddutyNonArchivedFindingsParamDaysHighSev   = "1"
      GuarddutyNonArchivedFindingsParamDaysMediumSev = "3"
      GuarddutyNonArchivedFindingsParamDaysLowSev    = "15"
    }
  }

  # S3 configuration
  delivery_s3_bucket     = "my-config-bucket"
  delivery_s3_key_prefix = "config"

  # Naming
  pack_name_prefix = "my-org-"

  # Config recorder settings
  config_recorder_role_arn = "arn:aws:iam::123456789012:role/aws-config-role"
}
```

### Organization Level Deployment

```hcl
module "org_nist_compliance" {
  source = "path/to/terraform-aws-config-management"

  # Deploy NIST 800-171 conformance pack organization-wide
  conformance_packs    = ["nist-800-171"]
  organization_managed = true

  # Exclude specific accounts
  excluded_accounts = ["123456789012", "123456789013"]

  # S3 configuration
  delivery_s3_bucket = "my-org-config-bucket"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| conformance_packs | A list of conformance packs to deploy | `list(string)` | `[]` | no |
| conformance_pack_parameters | Parameters to override for specific conformance packs | `map(map(string))` | `{}` | no |
| conformance_packs_to_exclude | A list of conformance packs to exclude from deployment | `list(string)` | `[]` | no |
| template_version | Template version to use (commit hash, tag, or 'latest') | `string` | `"latest"` | no |
| delivery_s3_bucket | S3 bucket for AWS Config delivery channel (auto-discovered if not provided) | `string` | `null` | no |
| delivery_s3_key_prefix | S3 key prefix for AWS Config delivery channel | `string` | `"config"` | no |
| organization_managed | Whether the conformance packs should be organization managed | `bool` | `false` | no |
| excluded_accounts | AWS accounts to exclude from the conformance packs (organization mode only) | `list(string)` | `[]` | no |
| pack_name_prefix | Conformance pack names created should start with the specified string | `string` | `""` | no |
| create_config_recorder | Whether to create AWS Config configuration recorder (account mode only) | `bool` | `true` | no |
| config_recorder_name | Name for the AWS Config configuration recorder (account mode only) | `string` | `"default"` | no |
| config_recorder_role_arn | IAM role ARN for AWS Config configuration recorder (auto-discovered if not provided, account mode only) | `string` | `null` | no |
| create_delivery_channel | Whether to create AWS Config delivery channel (account mode only) | `bool` | `true` | no |
| delivery_channel_name | Name for the AWS Config delivery channel (account mode only) | `string` | `"default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| conformance_pack_arns | ARNs of the created conformance packs |
| conformance_pack_names | Names of the created conformance packs |
| deployed_conformance_packs | List of conformance packs that were deployed |
| config_recorder_name | Name of the AWS Config configuration recorder (account mode only) |
| delivery_channel_name | Name of the AWS Config delivery channel (account mode only) |

## Prerequisites

### Account Mode Prerequisites

1. **IAM Role for Config**: Create an IAM role for AWS Config with the `AWS_ConfigRole` policy
2. **S3 Bucket**: Create an S3 bucket for Config delivery with appropriate bucket policy
3. **Config Service**: Ensure AWS Config service is available in your region

### Organization Mode Prerequisites

1. **AWS Organizations**: Must be deployed in an AWS Organizations management account
2. **Config Service**: AWS Config must be enabled organization-wide
3. **S3 Bucket**: Organization-wide S3 bucket for Config delivery
4. **Permissions**: Appropriate permissions to deploy organization conformance packs

## NIST 800-171 Conformance Pack

The NIST 800-171 conformance pack includes 108+ AWS Config rules that help verify compliance with NIST 800-171 requirements. Key areas covered include:

- **Access Control**: IAM policies, MFA requirements, password policies
- **Audit and Accountability**: CloudTrail logging, Config recording
- **Configuration Management**: Security group rules, encryption settings
- **Identification and Authentication**: User management, credential policies
- **System and Communications Protection**: Encryption in transit and at rest
- **System and Information Integrity**: Monitoring and alerting

### Customizable Parameters

The NIST 800-171 conformance pack supports numerous parameters for customization:

- **IAM Password Policy**: Password length, complexity, rotation requirements
- **GuardDuty Settings**: Finding retention periods by severity
- **S3 Security**: Public access block settings
- **Network Security**: Authorized ports and protocols
- **Encryption**: KMS key requirements

## Examples

See the `examples/` directory for complete working examples:

- `examples/nist-800-171/`: Basic NIST 800-171 deployment with parameter overrides

## License

This module is licensed under the MIT License. See LICENSE file for details.

## Contributing

Contributions are welcome! Please read the contributing guidelines and submit pull requests to the main branch.
