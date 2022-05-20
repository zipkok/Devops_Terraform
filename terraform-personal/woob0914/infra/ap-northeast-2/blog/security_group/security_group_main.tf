# =================================================================================
# Security Group - Use Module =====================================================
# =================================================================================
module "alb_security_group" {
  source                = "../../../../../modules/aws/v2/aws_security_group"
  vpc_id                = var.vpc_id
  security_group_config = var.alb_security_group_config
  security_group_tags   = var.common_security_group_tags
}

module "ec2_security_group" {
  source                = "../../../../../modules/aws/v2/aws_security_group"
  vpc_id                = var.vpc_id
  security_group_config = var.ec2_security_group_config
  security_group_tags   = var.common_security_group_tags
}
