provider "aws" {
  region = "eu-central-1"

  default_tags {
    tags = local.common_tags
  }
}

locals {
  environment = "staging"
  project     = "martinbroder.com"

  common_tags = {
    Environment  = local.environment
    Project      = local.project
    ManagedBy    = "Terraform"
    Owner        = "Martin Broder"
    CreationDate = formatdate("YYYY-MM-DD", plantimestamp())
  }
}

module "static-website" {
  source = "../../modules/static-website" # Relative path to the module

  # Pass in the variables specific to this environment
  root_domain_name = "martinbroder.com"
  subdomain        = local.environment
  s3_bucket_name   = "martinbroder-com-s3-${local.environment}-website-assets"
  cf_oac_name      = "martinbroder-com-cf-${local.environment}-oac"

  common_tags = local.common_tags
}
