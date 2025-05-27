variable "cloud_id" {
  description = "Nebius Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Nebius Folder ID"
  type        = string
}

variable "zone" {
  description = "Availability zone"
  type        = string
  default     = "eu-north1-c"
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "nebius-ml-demo-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.28"
}

# GPU Fabric Configuration - CRITICAL REQUIREMENT
variable "gpu_fabric" {
  description = "GPU cluster fabric number (must be 2, 4, or 6)"
  type        = number
  default     = 2
  
  validation {
    condition     = contains([2, 4, 6], var.gpu_fabric)
    error_message = "GPU fabric must be 2, 4, or 6 only!"
  }
}

# Node Group Configurations
variable "training_node_config" {
  description = "Configuration for training node group"
  type = object({
    name          = string
    gpu_count     = number
    node_count    = number
    preemptible   = bool
  })
  default = {
    name          = "gpu-training-h100"
    gpu_count     = 8
    node_count    = 2
    preemptible   = false
  }
  
  validation {
    condition     = var.training_node_config.gpu_count * var.training_node_config.node_count <= 16
    error_message = "Training node group cannot exceed 16 H100 GPUs!"
  }
}

variable "inference_node_config" {
  description = "Configuration for inference node group"
  type = object({
    name          = string
    gpu_count     = number
    node_count    = number
    preemptible   = bool
  })
  default = {
    name          = "gpu-inference-h100"
    gpu_count     = 2
    node_count    = 2
    preemptible   = false
  }
  
  validation {
    condition     = var.inference_node_config.gpu_count * var.inference_node_config.node_count <= 4
    error_message = "Inference node group cannot exceed 4 H100 GPUs!"
  }
}

variable "network_cidr" {
  default = "10.100.0.0/16"
}

variable "cluster_ipv4_range" {
  default = "10.112.0.0/16"
}

variable "service_ipv4_range" {
  default = "10.96.0.0/16"
}

variable "labels" {
  description = "Labels to apply to all resources"
  type        = map(string)
  default = {
    environment = "demo"
    project     = "nebius-ai-interview"
    managed_by  = "terraform"
  }
}

variable "ssh_public_key" {
  description = "SSH public key for node access"
  type        = string
  default     = ""
}
