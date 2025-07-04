output "website_url" {
  description = "The URL of the deployed website."
  value       = "https://${var.domain_name}"
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket hosting the website files."
  value       = aws_s3_bucket.website.id
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution."
  value       = aws_cloudfront_distribution.s3_distribution.id
}
