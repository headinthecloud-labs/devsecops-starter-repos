variable "region" {
  type        = string
  description = "AWS region to deploy into"
  default     = "us-east-1"
}
variable "log_bucket_name" {
  type        = string
  description = "S3 bucket for CloudTrail/Config logs"
  default     = "REPLACE-ME-unique-org-logs-bucket"
}