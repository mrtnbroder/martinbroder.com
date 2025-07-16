terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.2"
    }
  }
}

locals {
  common_tags = {
    ManagedBy    = var.tag_managed_by
    Project      = var.tag_project
    Environment  = var.environment
    Owner        = var.tag_owner
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}
