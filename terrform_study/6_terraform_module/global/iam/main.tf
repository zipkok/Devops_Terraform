provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_iam_user" "example" {
  count = 3
  name  = "neo.${count.index}"
}

