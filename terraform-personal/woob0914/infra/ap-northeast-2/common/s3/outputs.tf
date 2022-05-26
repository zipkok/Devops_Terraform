output "static-bucket-name" {
  value = aws_s3_bucket.rsc_static_bucket_woob_com.id
}

output "static-bucket-arn" {
  value = aws_s3_bucket.rsc_static_bucket_woob_com.arn
}

output "static-bucket-domain-name" {
  value = aws_s3_bucket.rsc_static_bucket_woob_com.bucket_domain_name
}
