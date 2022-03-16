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
  default     = ["neo", "trinity", "morpheus"]
}

output "iam_arn" {
  value       = aws_iam_user.example
  description = "The ARN for user Neo"
}


