output "aws_instance_id" {
  value = [for hostname in module.blog_webapp.oup_aws_instance[0] : hostname.id]
}



/* output "aws_instance_id2" {
  value = module.blog_webapp.oup_aws_instance[0]["woobeom13"].id
}  */


// terraform_remote_state로 오픈.
/* data "terraform_remote_state" "instance_id" {
  backend = "s3"

  config = {
    bucket = "woobeom-terraform-bucket"
    key    = "infra/aws/ap-northeast-2/blog/ec2_instance_webapp/terraform.tfstate"
    region = "ap-northeast-2"
  }
} 

output "instance_id" {
  value       = data.terraform_remote_state.instance_id.outputs.aws_instance_id
  description = "The domain name of the load balancer"
}
output "instance_id_1" {
  value       = data.terraform_remote_state.instance_id.outputs.aws_instance_id[1]
  description = "The domain name of the load balancer"
}  */