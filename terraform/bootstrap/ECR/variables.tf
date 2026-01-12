variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Project name for tagging resources"
  type        = string
  default     = "basic-application-pipeline"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository for Docker images and Helm charts"
  type        = string
  default     = "hello-flask-app"
}

variable "ecr_push_role_name" {
  description = "Name of the IAM role to create for ECR push operations"
  type        = string
  default     = "GitHubActionsECRPushRole"
}

variable "github_org" {
  description = "GitHub organization or username"
  type        = string
  default     = "Qday12"
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
  default     = "basic_application_pipeline"
}
