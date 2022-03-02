resource "aws_instance" "example" {
    ami = "ami-0815f1607de769fae"
    instance_type = "t2.micro"

    tags = {
        Name = "terraform-example"
    }
}