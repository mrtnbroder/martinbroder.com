# SESv2 Outputs
output "sesv2_email_identity_arn" {
  description = "The ARN of the SESv2 email identity."
  value       = aws_sesv2_email_identity.main.arn
}

output "sesv2_email_identity_type" {
  description = "The type of the SESv2 email identity (DOMAIN or EMAIL_ADDRESS)."
  value       = aws_sesv2_email_identity.main.identity_type
}

output "sesv2_dkim_tokens" {
  description = "The DKIM tokens for the SESv2 domain."
  value       = aws_sesv2_email_identity.main.dkim_signing_attributes[0].tokens
}

output "sesv2_dkim_status" {
  description = "The DKIM verification status."
  value       = aws_sesv2_email_identity.main.dkim_signing_attributes[0].status
}

output "sesv2_verification_status" {
  description = "The verification status of the SESv2 email identity."
  value       = aws_sesv2_email_identity.main.verified_for_sending_status
}

output "sesv2_mail_from_domain" {
  description = "The custom MAIL FROM domain."
  value       = aws_sesv2_email_identity_mail_from_attributes.main.mail_from_domain
}

output "sesv2_mail_from_mx_failure_behavior" {
  description = "The behavior on MX failure for MAIL FROM domain."
  value       = aws_sesv2_email_identity_mail_from_attributes.main.behavior_on_mx_failure
}

output "ses_domain_name" {
  description = "The domain name configured for SES."
  value       = var.domain_name
}

output "ses_region" {
  description = "The AWS region where SES is configured."
  value       = var.ses_region
}

output "route53_zone_id" {
  description = "The Route53 hosted zone ID for the domain."
  value       = data.aws_route53_zone.main.zone_id
}
