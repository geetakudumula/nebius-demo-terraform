output "cluster_id" {
  description = "Kubernetes cluster ID"
  value       = yandex_kubernetes_cluster.ml_cluster.id
}

output "cluster_name" {
  description = "Kubernetes cluster name"  
  value       = yandex_kubernetes_cluster.ml_cluster.name
}

output "cluster_endpoint" {
  description = "Kubernetes cluster endpoint"
  value       = yandex_kubernetes_cluster.ml_cluster.master[0].external_v4_endpoint
}

output "gpu_fabric_info" {
  description = "GPU fabric configuration details"
  value = {
    fabric_number = var.gpu_fabric
    fabric_name   = "fabric-${var.gpu_fabric}"
    compliance    = "Meets requirement: fabric must be 2, 4, or 6"
  }
}

output "capacity_compliance" {
  description = "Capacity limits compliance check"
  value = {
    training_gpus_limit   = "16 H100s maximum"
    training_gpus_actual  = "${var.training_node_config.gpu_count * var.training_node_config.node_count} H100s"
    training_compliance   = var.training_node_config.gpu_count * var.training_node_config.node_count <= 16 ? "✅ COMPLIANT" : "❌ EXCEEDS LIMIT"
    
    inference_gpus_limit  = "4 H100s maximum"
    inference_gpus_actual = "${var.inference_node_config.gpu_count * var.inference_node_config.node_count} H100s"
    inference_compliance  = var.inference_node_config.gpu_count * var.inference_node_config.node_count <= 4 ? "✅ COMPLIANT" : "❌ EXCEEDS LIMIT"
  }
}

output "kubeconfig_command" {
  description = "Command to get kubeconfig"
  value       = "yc managed-kubernetes cluster get-credentials ${yandex_kubernetes_cluster.ml_cluster.name} --external"
}

output "network_info" {
  description = "Using existing network resources"
  value = {
    network_id = data.yandex_vpc_network.existing_network.id
    subnet_id  = data.yandex_vpc_subnet.existing_subnet.id
    security_group_id = data.yandex_vpc_security_group.existing_sg.id
  }
}
