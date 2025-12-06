# DevOps Realtime Project Skeleton

This repository contains a skeleton DevOps project covering:
- Jenkinsfile CI pipeline
- SonarQube config
- Node (npm) app
- Trivy scanning script
- Dockerfile
- Kubernetes manifests (pod, deployment, service)
- ArgoCD application manifest
- Grafana dashboard provisioning
- Terraform for ECR + EKS (module)

Replace placeholders (AWS_ACCOUNT_ID, REGION, REPLACE_WITH_IMAGE, repo URLs) with your values.

Quick start:
1. Populate AWS and Sonar secrets in Jenkins.
2. Build & test: `npm ci && npm test`
3. Build image: `docker build -t Mutiverse:latest .`
4. Scan: `./trivy_scan.sh Mutiverse:latest`
5. Push to ECR: update Jenkinsfile env and run pipeline.
6. Deploy: use ArgoCD to sync the `k8s` directory.
