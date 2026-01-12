# Terraform Bootstrap for ECR and IAM

This Terraform configuration sets up the necessary AWS infrastructure for the CI/CD pipeline:
- ECR repository for Docker images and Helm charts
- References to existing IAM role for GitHub Actions

## Prerequisites

1. AWS CLI configured with appropriate credentials
2. Terraform >= 1.0 installed
3. Existing IAM role for GitHub Actions ECR push (or use the optional code to create one)

## Finding the Existing ECR Push Role

Before running Terraform, you need to find the existing IAM role ARN for ECR push operations:

```bash
# Search for roles with 'ECR' in the name
aws iam list-roles --query 'Roles[?contains(RoleName, `ECR`)].[RoleName, Arn]' --output table

# Search for roles with 'GitHub' in the name
aws iam list-roles --query 'Roles[?contains(RoleName, `GitHub`)].[RoleName, Arn]' --output table

# Or list all roles (this may be a lot)
aws iam list-roles --query 'Roles[].[RoleName, Arn]' --output table
```

Once you find the role, update the `ecr_push_role_name` variable in `variables.tf` or pass it as a parameter.

## Configuration

### Option 1: Update variables.tf

Edit `variables.tf` and update the default values:

```hcl
variable "ecr_push_role_name" {
  default = "YOUR_ACTUAL_ROLE_NAME"  # Update this
}

variable "aws_region" {
  default = "us-east-1"  # Change if needed
}
```

### Option 2: Use terraform.tfvars

Create a `terraform.tfvars` file:

```hcl
aws_region          = "us-east-1"
project_name        = "basic-application-pipeline"
environment         = "dev"
ecr_repository_name = "hello-flask-app"
ecr_push_role_name  = "YOUR_ACTUAL_ROLE_NAME"
```

### Option 3: Pass variables on command line

```bash
terraform apply -var="ecr_push_role_name=YOUR_ACTUAL_ROLE_NAME"
```

## Usage

1. **Initialize Terraform:**
   ```bash
   cd terraform/bootstrap
   terraform init
   ```

2. **Review the plan:**
   ```bash
   terraform plan
   ```

3. **Apply the configuration:**
   ```bash
   terraform apply
   ```

4. **View outputs:**
   ```bash
   terraform output
   ```

## Outputs

After applying, Terraform will output:

- `ecr_repository_url` - Full URL of the ECR repository
- `ecr_repository_name` - Name of the ECR repository
- `ecr_repository_arn` - ARN of the ECR repository
- `ecr_push_role_arn` - ARN of the IAM role for GitHub Actions
- `aws_account_id` - Your AWS account ID
- `ecr_registry_url` - Full ECR registry URL for GitHub Actions

## Setting Up GitHub Secrets

After running Terraform, set up these GitHub repository secrets:

1. Go to your GitHub repository settings
2. Navigate to Settings → Secrets and variables → Actions
3. Add the following secrets:
   - `AWS_ACCOUNT_ID`: Get from `terraform output aws_account_id`
   - `AWS_ROLE_ARN_ECR_PUSH`: Get from `terraform output ecr_push_role_arn`

## Creating a New IAM Role (If Needed)

If you don't have an existing IAM role, uncomment the role creation code in `main.tf`:

1. Uncomment the `aws_iam_role.ecr_push` resource
2. Uncomment the `aws_iam_role_policy.ecr_push_policy` resource
3. Uncomment and update the GitHub variables in `variables.tf`
4. Update the data source to reference the new resource instead

## Cleaning Up

To destroy all resources created by this Terraform configuration:

```bash
terraform destroy
```

**Note:** This will delete the ECR repository and all images in it. Make sure this is what you want!

## Troubleshooting

### Error: Role not found

If you get an error that the IAM role doesn't exist:
1. Verify the role name is correct using the AWS CLI commands above
2. Ensure your AWS credentials have permissions to list IAM roles
3. Consider creating the role using the commented-out code in `main.tf`

### Error: AWS credentials not configured

Configure AWS credentials:
```bash
aws configure
```

Or use environment variables:
```bash
export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"
export AWS_DEFAULT_REGION="us-east-1"
```

## Architecture

This bootstrap creates:

```
AWS Account
├── ECR Repository (hello-flask-app)
│   ├── Image scanning enabled
│   ├── Lifecycle policy (keep last 10 images)
│   └── AES256 encryption
│
└── IAM Role Reference (existing)
    └── Used by GitHub Actions for ECR push
```

## Next Steps

1. Update the GitHub Actions workflow with the ECR registry URL
2. Update the Helm values.yaml with the ECR repository URL
3. Configure the EKS cluster name in the workflow
4. Push code to trigger the CI/CD pipeline
