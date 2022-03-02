resource "aws_instance" "example" {
    ami = "ami-0c8ae8fa378ecb8e6"
    instance_type = "t2.micro"

    tags = {
        Name = "terraform-example"
    }
}