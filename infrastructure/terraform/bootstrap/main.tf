terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.2"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# AWS Certificate Manager (ACM) requires a provider in the us-east-1 region
# for certificates used with CloudFront.
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

# --- S3 Bucket for Static Website Hosting ---

resource "aws_s3_bucket" "website" {
  bucket = var.domain_name_bucket

  tags = {
    Environment = "staging"
    Project     = "Personal Website"
    ManagedBy   = "Terraform"
  }
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

# --- CloudFront Origin Access Control (OAC) ---

# New resource to create an OAC for CloudFront
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = var.domain_name_oac
  description                       = "Origin Access Control for S3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"

}

# Define a bucket policy that allows access ONLY from our CloudFront OAC
resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
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
  name         = var.root_domain_name # Use the root domain to find the hosted zone
  private_zone = false
}

# ADDED: Data source to find your existing ACM certificate.
# This tells Terraform to look for a certificate that is already issued
# for your root domain. This works if it's a wildcard certificate.
data "aws_acm_certificate" "root_cert" {
  provider   = aws.us_east_1
  domain     = var.root_domain_name
  statuses   = ["ISSUED"]
  most_recent = true
}

# --- CloudFront Distribution ---

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id   = "S3-${var.domain_name}"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  http_version = "http2and3"
  comment = "CloudFront distribution for ${var.domain_name}"

  aliases = [var.domain_name] # alias for staging.martinbroder.com

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.domain_name}"
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6" # Managed-CachingOptimized
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = data.aws_acm_certificate.root_cert.arn
    ssl_support_method  = "sni-only"
  }

   # ADDED: Staging tags
  tags = {
    Environment = "staging"
    Project     = "Personal Website"
    ManagedBy   = "Terraform"
  }
}

# --- Route 53 Alias Record ---

resource "aws_route53_record" "website_alias" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = var.domain_name # Creates record for staging.martinbroder.com
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
