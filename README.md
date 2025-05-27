# Nebius AI Demo - Terraform Infrastructure

## Overview
Complete Terraform infrastructure code for deploying Kubernetes cluster with GPU node groups on Nebius AI platform.

## Key Features
- GPU Fabric Configuration (fabric-2)
- Capacity Limits Enforcement (16 H100s training, 4 H100s inference)
- Service Accounts and IAM Configuration
- Uses existing VPC resources (due to folder restrictions)

## Files
- `versions.tf` - Provider requirements
- `variables.tf` - Variable definitions with validation
- `network.tf` - Network configuration  
- `iam.tf` - Service accounts and IAM
- `kubernetes.tf` - Kubernetes cluster
- `node-groups.tf` - GPU node groups with fabric settings
- `outputs.tf` - Output values with compliance checks

## Usage
1. Copy `terraform.tfvars.example` to `terraform.tfvars`
2. Fill in your cloud_id and folder_id
3. Run:
   ```bash
   terraform init
   terraform plan
   terraform apply
Note
Developed using yc CLI. Encountered organization-level restrictions on K8s cluster creation via Terraform.
