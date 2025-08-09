# devsecops-pipeline-template
A copy-paste GitHub Actions pipeline that runs security gates and deploys to AWS **without** long-lived keys (OIDC only).

## Why this matters
Security that can't **block** isn't security—it's a suggestion. This template fails PRs on secrets, vulnerable dependencies, or risky IaC.

## What it does
- GitHub OIDC → AWS: no stored AWS keys.
- Scans:
  - **Gitleaks** (secrets)
  - **Checkov** (Terraform)
  - **Trivy** (container image)
  - **Bandit** (Python SAST)
- Generates **SBOM** with **Syft** and signs image with **cosign** (optional to start).

## Setup (once)
1) Create an IAM role in AWS that trusts GitHub OIDC (see `aws-iam/github-oidc-trust-policy.json`).
2) Give it least-priv permissions for what you're deploying.
3) In this repo, set `AWS_ROLE_TO_ASSUME` and `AWS_REGION` as Action `env` or use `with: role-to-assume` as shown.

## Run it
Push a commit. Watch the pipeline run under **Actions**.