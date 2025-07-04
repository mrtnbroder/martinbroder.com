variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "eu-central-1" # Note: N. Virginia (us-east-1) is required for certain resources like ACM with CloudFront
}

# NOTE: The root domain is inferred from the staging domain for Route 53.
variable "root_domain_name" {
  description = "The root domain name for the Route 53 hosted zone."
  type        = string
  default     = "martinbroder.com"
}

variable "domain_name" {
  description = "The custom domain name for the website."
  type        = string
  default     = "staging.martinbroder.com"
}

variable "domain_name_bucket" {
  description = "The S3 bucket name for the website."
  type        = string
  default     = "staging-martinbroder-com-bucket"
}

variable "domain_name_oac" {
  description = "The CloudFront Origin Access Control name."
  type        = string
  default     = "staging-martinbroder-com-oac"
}

variable "forwarding_email" {
  description = "The email address to forward from."
  type        = string
  default     = "hi@martinbroder.com"
}

variable "destination_email" {
  description = "The personal email address to forward to."
  type        = string
  default     = "mrtnbroder@gmail.com"
}
