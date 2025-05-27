text
# Nebius AI Demo – Terraform Infrastructure

## Overview

This repository contains complete Terraform code for deploying a Kubernetes cluster with GPU node groups on the Nebius AI platform. The setup is designed to showcase advanced GPU fabric configuration, enforce resource capacity limits, and leverage existing VPC resources to comply with organizational constraints.

## Key Features

- ✅ **GPU Fabric Configuration** (fabric-2)
- ✅ **Capacity Limits Enforcement** (16 H100s for training, 4 H100s for inference)
- ✅ **Service Accounts and IAM Configuration**
- ✅ **Uses Existing VPC Resources** (due to folder restrictions)

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.5
- [Nebius CLI](https://cloud.nebius.ai/docs/cli/quickstart) installed and authenticated
- Nebius Terraform provider configured
- Access to an existing VPC and required resource IDs

## File Structure

| File                        | Purpose                                               |
|-----------------------------|-------------------------------------------------------|
| `versions.tf`               | Provider requirements                                 |
| `variables.tf`              | Variable definitions with validation                  |
| `network.tf`                | Network configuration                                 |
| `iam.tf`                    | Service accounts and IAM configuration                |
| `kubernetes.tf`             | Kubernetes cluster definition                         |
| `node-groups.tf`            | GPU node groups with fabric settings                  |
| `outputs.tf`                | Output values with compliance checks                  |
| `terraform.tfvars.example`  | Example variables file for user configuration         |

> **Note:** Sensitive files (like `sa-key.json` and `.tfstate`) have been removed from version control. Please generate or configure your own credentials and manage state securely.

## Usage

1. **Copy the example variables file:**
cp terraform.tfvars.example terraform.tfvars

text
2. **Edit `terraform.tfvars`**  
Fill in your `cloud_id`, `folder_id`, and any other required variables.

3. **Initialize and apply Terraform:**
terraform init
terraform plan
terraform apply

text

## State Management

By default, Terraform state is managed locally. For team or production use, configure [remote state storage](https://developer.hashicorp.com/terraform/language/state/remote) as appropriate.

## Troubleshooting

- **Organization-Level Restrictions:**  
If you encounter errors related to permissions (e.g., `PermissionDenied desc = Permission to [resource-manager.folder ...] denied`), ensure your user/service accounts have the necessary roles. This demo uses existing VPC resources due to folder-level restrictions encountered during development.

- **Kubernetes API/CLI:**  
The `yc managed-kubernetes cluster create` command referenced in troubleshooting is from a previous Nebius platform version; always use the latest recommended APIs and Terraform provider resources.

## Support

If you run into issues or have questions, feel free to open an issue or contact the repo maintainer.

---

**Developed as part of a Nebius AI demo.**  
For further context or to discuss specific permission errors, please refer to the Slack discussion with Idan Belisha or reach out directly.
