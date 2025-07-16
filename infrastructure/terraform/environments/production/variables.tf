# --------------------------------------------------
# Shared Terraform Variables
# --------------------------------------------------

variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "eu-central-1"
}

variable "tf_remote_state_bucket" {
  description = "The S3 bucket for Terraform remote state."
  type        = string
  default     = "martinbroder-com-s3-terraform-state"
}

variable "domain_name" {
  description = "The root domain name for the application."
  type        = string
  default     = "martinbroder.com"
}

variable "subdomain" {
  description = "The subdomain for the application."
  type        = string
  default     = "www"
}

variable "environment" {
  description = "The environment for the application."
  type        = string
  default     = "production"
}

variable "tag_managed_by" {
  description = "The managed by tag for all resources."
  type        = string
  default     = "Terraform"
}

variable "tag_project" {
  description = "The project tag for all resources."
  type        = string
  default     = "martinbroder.com"
}

variable "tag_owner" {
  description = "The owner tag for all resources."
  type        = string
  default     = "Martin Broder"
}

# --------------------------------------------------
# AWS CloudFront
# --------------------------------------------------

variable "cf_cache_policy_id" {
  description = "The cache policy ID for CloudFront."
  type        = string
  default     = "658327ea-f89d-4fab-a63d-7e88639e58f6" # Managed-CachingOptimized
  # default     = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # Managed-CachingDisabled
}

variable "cf_oac_name" {
  description = "The name for the CloudFront Origin Access Control."
  type        = string
  default     = "martinbroder-com-cf-oac-s3"
}

