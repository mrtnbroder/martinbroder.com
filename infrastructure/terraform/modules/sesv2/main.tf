# Get Route53 Hosted Zone for the domain
data "aws_route53_zone" "main" {
  name = var.domain_name
}

# --- Amazon SESv2 Configuration ---

# SESv2 Email Identity with Easy DKIM (RSA_2048_BIT)
resource "aws_sesv2_email_identity" "main" {
  email_identity = var.domain_name

  # No default configuration set as requested
  configuration_set_name = null

  dkim_signing_attributes {
    next_signing_key_length = var.signing_key_length
  }

  tags = var.default_tags
}

# Route53 DKIM records
resource "aws_route53_record" "dkim" {
  count   = 3
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${aws_sesv2_email_identity.main.dkim_signing_attributes[0].tokens[count.index]}._domainkey.${var.domain_name}"
  type    = "CNAME"
  ttl     = 600
  records = ["${aws_sesv2_email_identity.main.dkim_signing_attributes[0].tokens[count.index]}.dkim.amazonses.com"]
}

# Custom MAIL FROM domain configuration using SESv2
resource "aws_sesv2_email_identity_mail_from_attributes" "main" {
  email_identity = aws_sesv2_email_identity.main.email_identity

  mail_from_domain = "mail.${var.domain_name}"

  # Use default MAIL FROM domain on MX failure
  behavior_on_mx_failure = "USE_DEFAULT_VALUE"
}

# Route53 MX record for custom MAIL FROM domain
resource "aws_route53_record" "mail_from_mx" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = aws_sesv2_email_identity_mail_from_attributes.main.mail_from_domain
  type    = "MX"
  ttl     = 600
  records = ["10 feedback-smtp.${provider.aws.region}.amazonses.com"]
}

# Route53 TXT record for custom MAIL FROM domain SPF
resource "aws_route53_record" "mail_from_txt" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = aws_sesv2_email_identity_mail_from_attributes.main.mail_from_domain
  type    = "TXT"
  ttl     = 600
  records = ["v=spf1 include:amazonses.com ~all"]
}
