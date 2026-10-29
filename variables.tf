variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  type        = string
  description = "Must be globally unique"
  default     = "sidu-awslab-static-website-2026"
}