output "ecr_repository_url" {
  description = "URL of the ECR repository for Docker images"
  value       = aws_ecr_repository.app_repository.repository_url
}

output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = aws_ecr_repository.app_repository.name
}

output "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  value       = aws_ecr_repository.app_repository.arn
}

output "ecr_registry_id" {
  description = "Registry ID (AWS Account ID)"
  value       = aws_ecr_repository.app_repository.registry_id
}

output "ecr_push_role_arn" {
  description = "ARN of the IAM role for ECR push operations"
  value       = aws_iam_role.ecr_push.arn
}

output "ecr_push_role_name" {
  description = "Name of the IAM role for ECR push operations"
  value       = aws_iam_role.ecr_push.name
}

output "aws_account_id" {
  description = "AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "ecr_registry_url" {
  description = "Full ECR registry URL (for use in GitHub Actions)"
  value       = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
}

output "helm_repository_url" {
  description = "URL of the ECR repository for Helm charts"
  value       = aws_ecr_repository.helm_repository.repository_url
}

output "helm_repository_name" {
  description = "Name of the Helm chart repository"
  value       = aws_ecr_repository.helm_repository.name
}

output "helm_repository_arn" {
  description = "ARN of the Helm chart repository"
  value       = aws_ecr_repository.helm_repository.arn
}
