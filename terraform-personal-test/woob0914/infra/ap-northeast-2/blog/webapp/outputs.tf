// output "aws_instance_id" {
//     description = "Instance ID"
//     value = module.blog-webapp.oup_aws_instance[0]
// }

output "aws_instance_id" {
  value = [for hostname in module.blog-webapp.oup_aws_instance[0] : hostname.id]
}

data "aws_instance" "aws_instance_id" {
  instance_tags = {
    Name   = "woobt-tfinf001"
  }
  // filter {
  //   name   = "tag:Service"
  //   values = ["media"]
  // }
}

output "test" {
  value = data.aws_instance.aws_instance_id
}