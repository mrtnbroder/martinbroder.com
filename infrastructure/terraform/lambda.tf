module "ses_lambda_forwarder" {
  source  = "cloudposse/ses-lambda-forwarder/aws"
  version = "0.13.0" # Pinning to a specific version is a best practice

  namespace = "my-website"
  stage     = "prod"
  name      = "email-forwarder"

  # The module requires the us-east-1 provider for SES
  providers = {
    aws = aws.us-east-1
  }

  domain         = var.domain_name
  forward_emails = {
    "contact@${var.domain_name}" = [var.personal_email_address]
    "hello@${var.domain_name}"   = [var.personal_email_address]
  }

  # The module will output the required DNS records for SES domain verification.
  # These must be created in your Route 53 zone.
}
