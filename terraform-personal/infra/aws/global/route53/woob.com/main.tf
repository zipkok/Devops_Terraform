resource "aws_route53_zone" "woob-com-public" {
  name    = "woob.com"
  comment = "woob.com"

  tags = {
    Environment = "dev"
  }
}

data "aws_route53_zone" "woob-com" {
  name = "woob.com"
}

output "woob-com-zone-id" {
  value = aws_route53_zone.woob-com-public.zone_id
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.woob-com.zone_id
  name    = "www.${data.aws_route53_zone.woob-com.name}"
  type    = "A"
  ttl     = "300"
  records = ["10.0.0.1"]
}

resource "aws_route53_record" "www2" {
  zone_id = data.aws_route53_zone.woob-com.zone_id
  name    = "www2.${data.aws_route53_zone.woob-com.name}"
  type    = "A"
  ttl     = "300"
  records = ["10.0.0.1"]
}

resource "aws_route53_record" "www3" {
  zone_id = data.aws_route53_zone.woob-com.zone_id
  name    = "www3.woob.com"
  type    = "A"
  ttl     = "300"
  records = ["1.1.1.1"]
}

// terraform import aws_route53_record.www4 Z032121267F2ZKB9FR0Q_www4.woob.com_A
resource "aws_route53_record" "www4" {
  zone_id = data.aws_route53_zone.woob-com.zone_id
  name    = "www4.woob.com"
  type    = "A"
  ttl     = "300"
  records = ["1.1.1.1"]
}

// terraform import aws_route53_record.geo1 Z032121267F2ZKB9FR0Q_geo1.woob.com_A_geo1
resource "aws_route53_record" "geo1" {
  zone_id = data.aws_route53_zone.woob-com.zone_id
  name    = "geo1.woob.com"
  type    = "A"
  records = ["1.1.1.1"]
  ttl     = "300"
  weighted_routing_policy {
    weight = 20
  }
  /* geolocation_routing_policy {
    continent = "AF"
  } */
  set_identifier = "geo1"
}

/*
resource "aws_route53_record" "geo2-woob-com-A" {
  zone_id = data.aws_route53_zone.woob-com.zone_id
  name    = "geo2.${data.aws_route53_zone.woob-com.name}"
  type    = "A"
  records = ["33.54.4.44"]
  ttl     = "300"

  geolocation_routing_policy {
    continent = "AS"
  }
  set_identifier = "geo-asia"

}

resource "aws_route53_record" "latency-kr-woob-com-CNAME" {
  zone_id = data.aws_route53_zone.woob-com.zone_id
  name    = "latency-kr.${data.aws_route53_zone.woob-com.name}"
  type    = "CNAME"
  records = ["woobeom-latency.com"]
  ttl     = "300"
  latency_routing_policy {
    region = "us-west-2"
  }
  set_identifier = "latency-kr"

}

resource "aws_route53_record" "latency-va-woob-com-A" {
  zone_id = data.aws_route53_zone.woob-com.zone_id
  name    = "latency-va.${data.aws_route53_zone.woob-com.name}"
  type    = "A"
  records = ["22.22.22.22"]
  ttl     = "300"
  latency_routing_policy {
    region = "ap-northeast-3"
  }
  set_identifier = "latency-seoul"

}

resource "aws_route53_record" "test-woob-com-A" {
  zone_id = data.aws_route53_zone.woob-com.zone_id
  name    = "test.${data.aws_route53_zone.woob-com.name}"
  type    = "A"
  records = ["6.6.6.6"]
  ttl     = "300"
}

resource "aws_route53_record" "weight1-woob-com-A" {
  zone_id = data.aws_route53_zone.woob-com.zone_id
  name    = "weight1.${data.aws_route53_zone.woob-com.name}"
  type    = "A"
  records = ["2.2.22.2"]
  ttl     = "300"
  weighted_routing_policy {
    weight = 30
  }
  set_identifier = "weight-10"
}

resource "aws_route53_record" "weight2-woob-com-CNAME" {
  zone_id = data.aws_route53_zone.woob-com.zone_id
  name    = "weight2.${data.aws_route53_zone.woob-com.name}"
  type    = "CNAME"
  records = ["woobeom.com"]
  ttl     = "300"
  weighted_routing_policy {
    weight = 40
  }
  set_identifier = "weight-20"

} */
