# cloud-detection-and-response
Minimal patterns to *see* bad behavior and auto-remediate.

## Contents
- `athena/queries.sql` — starter CloudTrail queries
- `lambda/disable_key/index.py` — disables an access key on signal
- `terraform/` — EventBridge rule + Lambda wire-up

## Demo
1) Apply terraform.
2) Manually create an access key for a test IAM user (then delete it after).
3) Trigger the function (or wire an EventBridge pattern) to disable that key automatically.