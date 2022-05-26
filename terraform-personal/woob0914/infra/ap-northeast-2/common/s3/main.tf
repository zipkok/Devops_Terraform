resource "aws_s3_bucket" "rsc_static_bucket_woob_com" {
  bucket = "static-bucket.woob.com"
  tags = {
    Name    = "static-bucket.woob.com"
    Creator = "Woobeom"
  }
}
