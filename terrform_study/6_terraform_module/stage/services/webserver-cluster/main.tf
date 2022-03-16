module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  # Common
  cluster_name = "webservers-stage"

  db_remote_state_bucket = "woobeom-up-and-running-state"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  # AutoScale Variables
  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2

  custom_tags = {
    Owner      = "team-foo"
    DeployedBy = "terraform"
  }
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id
  from_port         = 12345
  to_port           = 12345
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}