resource "aws_s3_bucket" "c" {
  bucket = "woobeom-mybuckets"

  tags = {
    Name = "woobeom My bucket"
  }
}

resource "aws_s3_bucket" "d" {
  bucket = "woobeom-mylogs-mybuckets"

  tags = {
    Name = "woobeom mylogsss My bucket"
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.example.json
}

data "aws_iam_policy_document" "example" {
  statement =
  [
    {
      principals {
        type        = "*"
        identifiers = ["*"]
      }
      sid       = "UniqueSidOne"
      actions   = ["s3:ListBucket"]
      resources = ["arn:aws:s3:::woobeom-mybuckets/*", "arn:aws:s3:::woobeom-mybuckets"]
      effect    = "Allow"
    },
    {
      principals = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E3HGPRS0XYSUR5"
      sid        = "UniqueSidOne"
      actions    = ["s3:GetObject"]
      resources  = ["arn:aws:s3:::woobeom-mybuckets/*"]
      effect     = "Allow"
    }
  ]
}


resource "aws_s3_bucket_acl" "b_acl" {
  bucket = aws_s3_bucket.c.id
  acl    = "private"
}

locals {
  s3_origin_id = "woobeom-mybuckets"
}

resource "aws_cloudfront_origin_access_identity" "example" {
  comment = "Some comment"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.c.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/${aws_cloudfront_origin_access_identity.example.id}"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = "woobeom-mylogs-mybuckets.s3.amazonaws.com"
    prefix          = "mylogsss/"
  }

  // aliases = ["mysite.woobeom.com"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
    compress    = true
    // viewer_protocol_policy = "redirect-to-https"
    viewer_protocol_policy = "allow-all"
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      // locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Environment = "production"
  }


  viewer_certificate {
    cloudfront_default_certificate = true
  }
}