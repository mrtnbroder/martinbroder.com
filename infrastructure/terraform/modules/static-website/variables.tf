variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "eu-central-1"
}

variable "root_domain_name" {
  description = "The root domain name for the Route 53 hosted zone"
  type        = string
}

variable "subdomain" {
  description = "The subdomain for the static website."
  type        = string
}

variable "common_tags" {
  description = "A map of common tags to apply to the resources."
  type        = map(string)
  default     = {}
}

variable "s3_bucket_name" {
  description = "The S3 bucket name for the website."
  type        = string
}

variable "cf_oac_name" {
  description = "The CloudFront Origin Access Control name."
  type        = string
}
