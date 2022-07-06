vpc_id = "vpc-0546f3f1c47f1f95e"
subnet_ids = [
  "subnet-0bb6b78a4fb764f01",
  "subnet-0e13b6cc838741021",
  "subnet-05a0afbf6beb61357",
  "subnet-095041c85bc79d384"
]


alb_info = {
  alb_name             = "alb-woobeom"
  load_balancer_type   = "application"
  user_to_alb_port     = 80
  user_to_alb_protocol = "HTTP"
  redirect_host        = "plaync.com"
  redirect_port        = "443"
  redirect_protocol    = "HTTPS"
  redirect_status_code = "HTTP_302"
}
