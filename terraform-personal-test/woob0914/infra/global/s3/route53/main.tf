data "woodoo-com-ids" {
  zone_id = data.aws_route53_zone.woodoo-com-public.zone_id

}

resource "aws_route53_zone" "woodoo-com-public" {
  name    = "woodoo.com"
  comment = "woodoo.com"

  tags {
  }
}

resource "aws_route53_record" "woodoo-com-NS" {
  zone_id = "Z01600326NB4NKLT8GZ4"
  name    = "woodoo.com"
  type    = "NS"
  records = ["ns-787.awsdns-34.net.", "ns-504.awsdns-63.com.", "ns-1947.awsdns-51.co.uk.", "ns-1209.awsdns-23.org."]
  ttl     = "172800"

}

resource "aws_route53_record" "woodoo-com-SOA" {
  zone_id = "Z01600326NB4NKLT8GZ4"
  name    = "woodoo.com"
  type    = "SOA"
  records = ["ns-787.awsdns-34.net. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
  ttl     = "900"

}

resource "aws_route53_record" "geo1-woodoo-com-A" {
  zone_id = "Z01600326NB4NKLT8GZ4"
  name    = "geo1.woodoo.com"
  type    = "A"
  records = ["33.33.3.3"]
  ttl     = "300"

  geolocation_routing_policy {
    continent = "AF"
  }
  set_identifier = "geo-af"

}

resource "aws_route53_record" "geo2-woodoo-com-A" {
  zone_id = "Z01600326NB4NKLT8GZ4"
  name    = "geo2.woodoo.com"
  type    = "A"
  records = ["33.54.4.44"]
  ttl     = "300"

  geolocation_routing_policy {
    continent = "AS"
  }
  set_identifier = "geo-asia"

}

resource "aws_route53_record" "latency-kr-woodoo-com-CNAME" {
  zone_id = "Z01600326NB4NKLT8GZ4"
  name    = "latency-kr.woodoo.com"
  type    = "CNAME"
  records = ["woobeom-latency.com"]
  ttl     = "300"
  latency_routing_policy {
    region = "us-west-2"
  }
  set_identifier = "latency-kr"

}

resource "aws_route53_record" "latency-va-woodoo-com-A" {
  zone_id = "Z01600326NB4NKLT8GZ4"
  name    = "latency-va.woodoo.com"
  type    = "A"
  records = ["22.22.22.22"]
  ttl     = "300"
  latency_routing_policy {
    region = "ap-northeast-3"
  }
  set_identifier = "latency-seoul"

}

resource "aws_route53_record" "test-woodoo-com-A" {
  zone_id = "Z01600326NB4NKLT8GZ4"
  name    = "test.woodoo.com"
  type    = "A"
  records = ["6.6.6.6"]
  ttl     = "300"

}

resource "aws_route53_record" "weight1-woodoo-com-A" {
  zone_id = "Z01600326NB4NKLT8GZ4"
  name    = "weight1.woodoo.com"
  type    = "A"
  records = ["2.2.22.2"]
  ttl     = "300"
  weighted_routing_policy {
    weight = 30
  }
  set_identifier = "weight-10"

}

resource "aws_route53_record" "weight2-woodoo-com-CNAME" {
  zone_id = "Z01600326NB4NKLT8GZ4"
  name    = "weight2.woodoo.com"
  type    = "CNAME"
  records = ["woobeom.com"]
  ttl     = "300"
  weighted_routing_policy {
    weight = 40
  }
  set_identifier = "weight-20"

}
