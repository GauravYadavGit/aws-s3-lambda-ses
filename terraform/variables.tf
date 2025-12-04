variable "aws_region" {
  type        = string
  default     = "ap-south-1"
  description = "AWS region to deploy resources"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name to store uploaded files"
}

variable "sender_email" {
  type        = string
  description = "SES verified sender email"
}

variable "recipient_email" {
  type        = string
  description = "Email address to receive notifications"
}
