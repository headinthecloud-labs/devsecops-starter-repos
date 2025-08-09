terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# S3 bucket for CloudTrail/Config logs
resource "aws_s3_bucket" "logs" {
  bucket = var.log_bucket_name
  force_destroy = false
}

resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id
  versioning_configuration { status = "Enabled" }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id
  rule { apply_server_side_encryption_by_default { sse_algorithm = "AES256" } }
}

resource "aws_s3_bucket_lifecycle_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id
  rule {
    id     = "expire-logs"
    status = "Enabled"
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    expiration { days = 365 }
  }
}

# CloudTrail
resource "aws_cloudtrail" "org_trail" {
  name                          = "org-trail-starter"
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  s3_bucket_name                = aws_s3_bucket.logs.bucket
  event_selector {
    read_write_type           = "All"
    include_management_events = true
  }
}

# AWS Config
resource "aws_iam_role" "config" {
  name = "config-recorder-role-starter"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "config.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "config_attach" {
  role       = aws_iam_role.config.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}

resource "aws_config_configuration_recorder" "rec" {
  name     = "default"
  role_arn = aws_iam_role.config.arn
  recording_group {
    all_supported = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "dc" {
  name           = "default"
  s3_bucket_name = aws_s3_bucket.logs.bucket
  depends_on     = [aws_config_configuration_recorder.rec]
}

resource "aws_config_configuration_recorder_status" "status" {
  name       = aws_config_configuration_recorder.rec.name
  is_enabled = true
  depends_on = [aws_config_delivery_channel.dc]
}

# GuardDuty + Security Hub
resource "aws_guardduty_detector" "this" { enable = true }

resource "aws_securityhub_account" "this" {
  depends_on = [aws_guardduty_detector.this]
}

resource "aws_securityhub_standards_subscription" "cis" {
  standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.4.0"
  depends_on    = [aws_securityhub_account.this]
}