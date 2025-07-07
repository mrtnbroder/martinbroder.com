output "cf_oac_id" {
  description = "The ID of the CloudFront Origin Access Control."
  value       = aws_cloudfront_origin_access_control.oac.id
}
