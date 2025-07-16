data "terraform_remote_state" "bootstrap" {
  backend = "s3"
  config = {
    bucket = "${replace(var.root_domain_name, ".", "-")}-s3-terraform-state" # Ensure the bucket name is valid
    key    = "${replace(var.root_domain_name, ".", "-")}/bootstrap.tfstate"
    region = var.aws_region # The region where your bucket is located
  }
}

module "static-website" {
  source = "../../modules/static-website" # Relative path to the module

  root_domain_name = var.root_domain_name
  subdomain        = var.subdomain
  s3_bucket_name   = "${replace(var.root_domain_name, ".", "-")}-s3-${var.environment}-website-assets"
  cf_oac_id        = data.terraform_remote_state.bootstrap.outputs.cf_oac_id
  cf_cache_policy_id = var.cf_cache_policy_id
}
