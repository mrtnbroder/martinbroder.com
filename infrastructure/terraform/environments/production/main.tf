provider "aws" {
  region = local.aws_region

  default_tags {
    tags = local.common_tags
  }
}

locals {
  environment      = "production"
  project          = "martinbroder.com"
  aws_region       = "eu-central-1"
  root_domain_name = "martinbroder.com"

  common_tags = {
    Environment = local.environment
    Project     = local.project
    ManagedBy   = "Terraform"
    Owner       = "Martin Broder"
  }
}

module "static-website" {
  source = "../../modules/static-website" # Relative path to the module

  # Pass in the variables specific to this environment
  root_domain_name = local.root_domain_name
  subdomain        = "www" # For production, we use the www subdomain
  s3_bucket_name   = "martinbroder-com-s3-${local.environment}-website-assets"
  cf_oac_id        = "E399COV3H6OQWP"
  # "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # Managed-CachingDisabled
  # "658327ea-f89d-4fab-a63d-7e88639e58f6" # Managed-CachingOptimized
  cf_cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6" # Managed-CachingOptimized

  common_tags = local.common_tags
}
