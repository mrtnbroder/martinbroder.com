variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "us-east-1" # N. Virginia is required for certain resources like ACM with CloudFront
}

variable "domain_name" {
  description = "The custom domain name for the website."
  type        = string
  default     = "martinbroder.com"
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
