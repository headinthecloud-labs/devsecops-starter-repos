# opa-policy-pack
Rego policies to block risky changes for Terraform and Kubernetes.

## Terraform (Conftest)
- `terraform/deny_public_s3.rego` — blocks public S3 buckets
- Run: `conftest test terraform_example_plan.json`

## Kubernetes (Gatekeeper/Kyverno-style constraints as OPA examples)
- `kubernetes/no_privileged.rego` — blocks privileged pods