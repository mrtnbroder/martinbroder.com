# AWS Certificate Manager (ACM) requires a provider in the us-east-1 region
# for certificates used with CloudFront.
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

locals {
  # Use the subdomain if provided, otherwise use the root domain
  domain_name = var.subdomain == "" ? var.domain_name : "${var.subdomain}.${var.domain_name}"
}

# --- S3 Bucket for Static Website Hosting ---

resource "aws_s3_bucket" "website" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html" # You can create this file later
  }
}

# Define a bucket policy that allows access ONLY from our CloudFront OAC
resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    sid       = "AllowCloudFrontServicePrincipalReadOnly"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.website.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
    }
  }
}


# --- DNS and SSL Certificate ---

data "aws_route53_zone" "primary" {
  name         = var.domain_name # Use the root domain to find the hosted zone
  private_zone = false
}

# This tells Terraform to look for a certificate that is already issued
# for your root domain. This works if it's a wildcard certificate.
data "aws_acm_certificate" "root_cert" {
  provider    = aws.us_east_1
  domain      = var.domain_name
  statuses    = ["ISSUED"]
  most_recent = true
}


# --- CloudFront Distribution ---

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id                = var.s3_bucket_name
    origin_access_control_id = var.cf_oac_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  http_version        = "http2and3"
  comment             = "CloudFront distribution for ${local.domain_name}"

  aliases = [local.domain_name] # Use the provided domain aliases

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.s3_bucket_name
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = var.cf_cache_policy_id # Use the provided cache policy ID

  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.root_cert.arn
    minimum_protocol_version = "TLSv1.2_2021" # Use a secure minimum protocol version
    ssl_support_method       = "sni-only"
  }



  # Use common tags and merge a resource-specific "Name" tag
  # tags = merge(var.common_tags, {
  #   Name = "${replace(local.full_domain_name, ".", "-")}-cf-distribution"
  # })
}


# --- Route 53 Alias Record ---

resource "aws_route53_record" "website_alias" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = local.domain_name # Creates record for *.martinbroder.com
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
