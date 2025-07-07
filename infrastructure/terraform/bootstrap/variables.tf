variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "eu-central-1"
}

variable "cf_oac_name" {
  description = "The name for the CloudFront Origin Access Control."
  type        = string
  default     = "martinbroder-com-cf-oac-s3"
}
