# eks-zero-to-prod-secure
Opinionated EKS platform with security guardrails. This repo is **scaffold only**—fill it in as you learn.

## Milestones
- [ ] Create cluster via Terraform (EKS + managed node groups)
- [ ] Enable **IRSA** and move any AWS access to pod roles
- [ ] Install **Kyverno** and add baseline policies
- [ ] Add **Cilium** (or Calico) network policies for pod-to-pod limits
- [ ] Admission to **verify cosign-signed images**
- [ ] Runtime alerts with **Falco** → SNS/Slack

## Folders
- `terraform/` —  cluster creation (start here)
- `helm/` — charts and values for addons (kyverno, cilium, metrics-server, etc.)
- `docs/diagrams.mmd` — Mermaid diagrams for cluster architecture