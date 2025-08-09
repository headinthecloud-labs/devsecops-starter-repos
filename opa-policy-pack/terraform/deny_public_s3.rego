package terraform.s3

deny[msg] {
  input.resource_changes[_].type == "aws_s3_bucket"
  some i
  input.resource_changes[i].change.after.acl == "public-read"
  msg := "Public S3 buckets are not allowed"
}