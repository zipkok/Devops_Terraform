resource "aws_instance" "my-app1" {
    ami                         = "ami-0cbec04a61be382d9"
    availability_zone           = "ap-northeast-2a"
    ebs_optimized               = false
    instance_type               = "t2.micro"
    monitoring                  = false
    key_name                    = "woob0914"
    subnet_id                   = "subnet-095041c85bc79d384"
    vpc_security_group_ids      = ["sg-0979156848f949963"]
    associate_public_ip_address = true
    source_dest_check           = true

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 8
        delete_on_termination = true
    }

    tags {
        "Name" = "my-app"
    }
}

resource "aws_instance" "my-app2" {
    ami                         = "ami-0cbec04a61be382d9"
    availability_zone           = "ap-northeast-2c"
    ebs_optimized               = false
    instance_type               = "t2.micro"
    monitoring                  = false
    key_name                    = "woob0914"
    subnet_id                   = "subnet-095041c85bc79d384"
    vpc_security_group_ids      = ["sg-0979156848f949963"]
    associate_public_ip_address = true

    root_block_device {
        volume_type           = "gp2"
        volume_size           = 8
        delete_on_termination = true
    }

    tags {
        "Name" = "my-app"
    }
}


resource "aws_alb" "external-web-lb" {
    idle_timeout    = 60
    internal        = false
    name            = "external-web-lb"
    security_groups = ["sg-0c2fcc58ef7165fd5"]
    subnets         = ["subnet-05a0afbf6beb61357", "subnet-095041c85bc79d384", "subnet-0bb6b78a4fb764f01", "subnet-0e13b6cc838741021"]      

    enable_deletion_protection = false

    tags {
        "ELB" = "external"
        "Name" = "external-web-lb"
    }
}

resource "aws_alb" "internals-web-lb" {
    idle_timeout    = 60
    internal        = true
    name            = "internals-web-lb"
    security_groups = ["sg-0c2fcc58ef7165fd5"]
    subnets         = ["subnet-05a0afbf6beb61357", "subnet-095041c85bc79d384", "subnet-0bb6b78a4fb764f01", "subnet-0e13b6cc838741021"]      

    enable_deletion_protection = false

    tags {
        "ELB" = "Internal"
        "Name" = "internals-web-lb"
    }
}

