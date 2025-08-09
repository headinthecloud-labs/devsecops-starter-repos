# serverless-secure-starter
Small but real API on API Gateway + Lambda (Python), with least-priv IAM and room for WAF and auth later.

## Why this matters
Serverless lets you ship value without babysitting servers. This repo proves you can do it safely.

## Structure
- `src/app/handler.py` — Lambda entrypoint
- `terraform/` — API + Lambda infra
- `tests/` — tiny unit test

## Deploy (sandbox)
```bash
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt -r requirements-dev.txt
pytest -q

zip -r lambda.zip src
terraform -chdir=terraform init
terraform -chdir=terraform apply -auto-approve
```

## TODOs
- [ ] Add WAFv2 WebACL and associate with API Gateway
- [ ] Move secrets to Secrets Manager (example provided)
- [ ] Add authN (Cognito) and rate limiting