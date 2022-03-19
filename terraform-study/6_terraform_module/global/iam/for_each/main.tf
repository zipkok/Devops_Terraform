provider "aws" {
  region = "ap-northeast-2"
}


# ===============================
resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)
  name     = each.value
}

variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  //   default     = ["neo", "trinity", "morpheus"]
  default = ["neo", "morpheus"]
}

# map 형식으로 반환됨.
output "iam_arn" {
  value       = aws_iam_user.example
  description = "The ARN for user Neo"
}

# map에서 값만 반환하는 내장함수 values
# list를 반환값으로 가짐
output "all_arns" {
  value = values(aws_iam_user.example)[*].arn
}


