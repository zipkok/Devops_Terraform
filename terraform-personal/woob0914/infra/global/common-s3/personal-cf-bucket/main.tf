resource "aws_s3_bucket" "rsc_personal_cf_bucket" {
  bucket = "personal-cf-bucket"
  tags = {
    Name    = "personal-cf-bucket"
    Creator = "Woobeom"
  }
}
