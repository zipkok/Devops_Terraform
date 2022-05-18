# =================================================================================
# Security Group - Use Module =====================================================
# =================================================================================
module "mdu2_security_group" {
  source                = "../../../../../modules/infra/v2/aws_security_group"
  vpc_id                = var.vpc_id
  security_group_config = var.security_group_config
  security_group_tags   = var.common_security_group_tags
}
