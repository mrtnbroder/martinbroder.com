resource "aws_acm_certificate" "default" {
  # This resource must be created in us-east-1
  provider = aws.us-east-1

  domain_name       = var.domain_name
  subject_alternative_names = ["www.${var.domain_name}"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "default" {
  # This resource must also use the us-east-1 provider
  provider = aws.us-east-1

  certificate_arn         = aws_acm_certificate.default.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
