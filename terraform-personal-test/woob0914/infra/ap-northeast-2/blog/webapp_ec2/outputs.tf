// output "aws_instance_id" {
//     description = "Instance ID"
//     value = module.blog-webapp.oup_aws_instance[0]
// }

output "aws_instance_id" {
  value = [for hostname in module.blog-webapp.oup_aws_instance[0] : hostname.id]
}

// terraform_remote_state로 오픈.
data "terraform_remote_state" "instance_id" {
  backend = "s3"

  config = {
    bucket = "woobeom-terraform-bucket"
    key    = "woob0914/infra/ap-northeast-2/blog/webapp/terraform.tfstate"
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
}