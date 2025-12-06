# DevOps Realtime Project - Expanded

This expanded skeleton contains:
- Jenkinsfile (with credential usage and refined stages)
- SonarQube config
- Node (npm) app
- Dockerfile + Trivy scan script
- Kubernetes manifests (Deployment, Service)
- ArgoCD Application manifests for app and grafana
- Grafana deployment & dashboard config
- Terraform: VPC, ECR, EKS via community modules
- Example terraform.tfvars

**Placeholders you must replace**:
- AWS_ACCOUNT_ID, AWS_REGION, Jenkins credential IDs, repo URLs in ArgoCD, and `REPLACE_WITH_IMAGE` in k8s manifests.

## Quick "ready-to-run" steps (example):

1. Clone this repo into your git provider and update `k8s/argo-app.yaml` `repoURL` to point to the repo.
2. In Jenkins add credentials:
   - secret text `aws-account-id` (your AWS account id)
   - secret text `aws-region` (e.g., us-east-1)
   - secret text `sonar-token`
   - username/password or access keys for AWS as `aws-access-key-id` and `aws-secret-access-key`
3. From local dev machine: build & push image to ECR (example):
   - `docker build -t Mutiverse:latest .`
   - `aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com`
   - `docker tag Mutiverse:latest <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/Mutiverse:latest`
   - `docker push <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/Mutiverse:latest`
4. Terraform:
   - `cd terraform`
   - `terraform init`
   - `terraform apply -var-file=terraform.tfvars` (or create `terraform.tfvars` from the example)
   - After apply, update `k8s/deployment.yaml` image to the ECR URL from terraform output and commit.
5. ArgoCD:
   - Install ArgoCD on your cluster (if not installed)
   - Create an Application for `k8s/argo-app.yaml` or let ArgoCD pick it up from the repo.
6. Grafana:
   - Apply `grafana/configmap.yaml` and `grafana/deployment.yaml` or use ArgoCD to deploy.

If you'd like, I can now:
- Replace placeholders with real values if you provide them (AWS Account ID, AWS region, Git repo URL, preferred cluster name).
- Produce a single ready-to-run bundle with those values filled in and sample secrets masked.
