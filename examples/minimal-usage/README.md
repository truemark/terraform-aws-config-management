# Minimal Usage Example

This example demonstrates the simplest possible usage of the Terraform AWS Config Management module, leveraging automatic AWS Config discovery for the 99% use case where AWS Config is already set up in your account.

## What This Example Does

This example deploys multiple conformance packs with minimal configuration:

1. **Multiple Compliance Frameworks**: Deploys HIPAA, PCI DSS, and NIST 800-171 conformance packs
2. **Single Pack Deployment**: Shows how to deploy just one conformance pack
3. **Parameter Customization**: Demonstrates overriding default parameters for stricter compliance

## Prerequisites

1. **AWS Config Already Set Up**: This example assumes AWS Config is already configured in your account with:
   - Configuration recorder enabled and running
   - Delivery channel configured with S3 bucket
   - Appropriate IAM roles and permissions
   
   **Important**: This example sets `create_config_recorder = false` and `create_delivery_channel = false`, assuming AWS Config is already operational in your account.

2. **AWS Credentials**: Configure your AWS credentials using one of these methods:
   ```bash
   # Option 1: AWS CLI
   aws configure
   
   # Option 2: Environment variables
   export AWS_ACCESS_KEY_ID="your-access-key"
   export AWS_SECRET_ACCESS_KEY="your-secret-key"
   export AWS_DEFAULT_REGION="us-east-1"
   
   # Option 3: IAM role (if running on EC2/ECS/Lambda)
   # No additional configuration needed
   ```

3. **Terraform**: Install Terraform >= 1.0

## Usage

1. **Clone and Navigate**:
   ```bash
   cd examples/minimal-usage
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Review the Plan**:
   ```bash
   terraform plan
   ```

4. **Apply the Configuration**:
   ```bash
   terraform apply
   ```

5. **View Outputs**:
   ```bash
   terraform output
   ```

## Configuration Options

### Before Running - Update S3 Bucket Name
1. **Find your existing Config S3 bucket**:
   ```bash
   # Using AWS CLI
   aws configservice describe-delivery-channels --region us-east-2
   # Look for the "s3BucketName" field in the output
   ```

2. **Edit `main.tf`** and replace `"your-existing-config-bucket-name"` with your actual bucket name in all three module blocks.

### Basic Usage (Default Region)
```bash
terraform apply
```
This uses the default region `us-east-2`.

### Custom Region
```bash
terraform apply -var="aws_region=us-west-2"
```

### Terraform Variables File
Create a `terraform.tfvars` file:
```hcl
aws_region = "us-east-2"
```

Then run:
```bash
terraform apply
```

## What Gets Deployed

This example creates three separate module instances:

1. **compliance_minimal**: Deploys HIPAA, PCI DSS, and NIST 800-171 with "test-" prefix
2. **single_pack**: Deploys just HIPAA conformance pack
3. **customized_compliance**: Deploys NIST 800-171 with custom parameters and "strict-" prefix

## Expected Outputs

After successful deployment, you'll see outputs showing:
- ARNs of all deployed conformance packs
- Names of all deployed conformance packs
- Summary of deployed packs by module

## Cleanup

To remove all deployed resources:
```bash
terraform destroy
```

## Troubleshooting

### AWS Config Not Set Up
If you get errors about AWS Config not being set up, you have two options:

1. **Set up AWS Config first** (recommended):
   - Enable AWS Config in your account via AWS Console or CLI
   - Configure delivery channel with S3 bucket
   - Set up appropriate IAM roles
   - Ensure the configuration recorder is running

2. **Create Config resources with the module**:
   ```hcl
   module "compliance_minimal" {
     source = "../../"
     
     conformance_packs = ["hipaa"]
     
     # Enable Config resource creation
     create_config_recorder   = true
     create_delivery_channel  = true
     
     # Required Config parameters
     delivery_s3_bucket       = "your-config-bucket"
     config_recorder_role_arn = "arn:aws:iam::123456789012:role/aws-config-role"
   }
   ```

### Permission Issues
Ensure your AWS credentials have permissions for:
- AWS Config operations
- S3 access (for Config delivery)
- IAM role assumptions (if using roles)

### Region Availability
Some conformance packs may not be available in all regions. Use regions like `us-east-1`, `us-west-2`, or `eu-west-1` for best compatibility.

## Next Steps

- Explore the `examples/hipaa-example/` for more advanced usage
- Check the main module README for all available conformance packs
- Customize parameters for your specific compliance requirements
