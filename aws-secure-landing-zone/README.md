# aws-secure-landing-zone
Minimal, single-account *starter* for landing-zone concepts. Goal: central logging, baseline detective controls, and example guardrails.

## What you get (today)
- Org-ready **patterns**, implemented in a single-account sandbox:
  - CloudTrail (all regions) → S3 log bucket with lifecycle + SSE
  - AWS Config recorder + delivery channel
  - Security Hub + GuardDuty enabled
  - Example **SCP** JSONs (you'll apply these later when you have multiple accounts)
- **Mermaid** diagram in `diagrams/landing-zone.mmd` that renders on GitHub.
- CI that runs `terraform fmt/validate`, **Checkov**, and **Gitleaks**.

## Why this matters
This is the "security cameras + seatbelts" baseline. Every serious AWS shop has this from day 1.

## Quickstart
1) Install: terraform, git, awscli, pre-commit.
2) Create an S3 bucket for state (optional for now) and set AWS creds for a sandbox account/role.
3) Review `terraform/variables.tf` defaults.
4) Plan/apply:
   ```bash
   cd terraform
   terraform init
   terraform plan -out tf.plan
   terraform apply tf.plan
   ```
5) Commit and push; see CI run checks.

## TODO (open issues to track)
- [ ] Convert to multi-account with AWS Organizations & delegated admins
- [ ] Migrate state to remote S3 + DynamoDB lock table
- [ ] Add CloudTrail Lake + Athena queries
- [ ] Add Macie + Inspector opt-in
- [ ] Wire Security Hub standards + controls as code

## Diagram
See `diagrams/landing-zone.mmd` (renders natively on GitHub). Export locally with Mermaid CLI if you want PNGs.