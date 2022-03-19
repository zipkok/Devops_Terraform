provider "aws" {
  region = "ap-northeast-2"
}


# ===============================
# count + index
// resource "aws_iam_user" "example" {
//   count = 3
//   name  = "neo.${count.index}"
// }



# ===============================
# count + index + variable
resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["neo", "trinity", "morpheus"]
}

output "iam_arn" {
  value       = aws_iam_user.example[0].arn
  description = "The ARN for user Neo"
}

output "iam_arn" {
  value       = aws_iam_user.example[*].arn
  description = "The ARN for users"
}