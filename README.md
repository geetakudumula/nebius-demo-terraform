text
# Nebius AI Demo – Terraform Infrastructure

## Overview

This repository contains complete Terraform code for deploying a Kubernetes cluster with GPU node groups on the Nebius AI platform. The setup is designed to showcase advanced GPU fabric configuration, enforce resource capacity limits, and leverage existing VPC resources to comply with organizational constraints.

## Key Features

-  **GPU Fabric Configuration** (fabric-2)
-  **Capacity Limits Enforcement** (16 H100s for training, 4 H100s for inference)
-  **Service Accounts and IAM Configuration**
- **Uses Existing VPC Resources** (due to folder restrictions)

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.5
- [Nebius/Yandex Cloud CLI (yc) installed](https://cloud.nebius.ai/docs/cli/quickstart) installed and authenticated
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

