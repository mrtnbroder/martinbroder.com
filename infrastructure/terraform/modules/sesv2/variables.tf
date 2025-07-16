variable "root_domain_name" {
  description = "The root domain name for SES configuration."
  type        = string
}

variable "signing_key_length" {
  description = "The length of the signing key for SES."
  type        = string
  default     = "RSA_2048_BIT"

  validation {
    condition     = var.signing_key_length == "RSA_2048_BIT" || var.signing_key_length == "RSA_1024_BIT"
    error_message = "signing_key_length must be either 'RSA_2048_BIT' or 'RSA_1024_BIT'."
  }
}

variable "default_tags" {
  description = "Default tags to apply to all resources in this module."
  type        = map(string)
  default     = {}
}
