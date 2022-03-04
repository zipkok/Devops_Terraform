// terraform {
//   required_version = ">= 0.12, < 0.13"
// }

provider "aws" {
  region = "ap-northeast-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}