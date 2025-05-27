# Training Node Group - Up to 16 H100s
resource "yandex_kubernetes_node_group" "gpu_training_group" {
  cluster_id = yandex_kubernetes_cluster.ml_cluster.id
  name       = var.training_node_config.name
  version    = var.cluster_version

  labels = merge(var.labels, {
    node_type = "gpu-training"
    gpu_type  = "h100"
    workload  = "training"
  })

  node_labels = {
    "node.kubernetes.io/gpu"      = "h100"
    "nebius.ai/node-type"        = "gpu-training"
    "nebius.ai/gpu-fabric"       = tostring(var.gpu_fabric)
    "workload-type"              = "training"
  }

  instance_template {
    platform_id = "gpu-standard-v3"

    resources {
      memory = 960
      cores  = 160
      gpus   = var.training_node_config.gpu_count
    }

    boot_disk {
      type = "network-ssd"
      size = 500
    }

    network_interface {
      subnet_ids         = ["e9bojadgs2bq45374f1g"]
      nat                = true
      security_group_ids = ["enpcq1hanif0c6ne64ru"]
    }

    metadata = {
      ssh-keys = var.ssh_public_key != "" ? "ubuntu:${var.ssh_public_key}" : null
      "gpu-cluster" = "fabric-${var.gpu_fabric}"
    }

    scheduling_policy {
      preemptible = var.training_node_config.preemptible
    }

    gpu_settings {
      gpu_cluster_id = "gpu-cluster-fabric-${var.gpu_fabric}"
      gpu_environment = "runc_drivers_cuda"
    }
  }

  scale_policy {
    fixed_scale {
      size = var.training_node_config.node_count
    }
  }

  allocation_policy {
    location {
      zone = var.zone
    }
  }

  maintenance_policy {
    auto_upgrade = false
    auto_repair  = true

    maintenance_window {
      start_time = "03:00"
      duration   = "3h"
    }
  }

  depends_on = [
    yandex_kubernetes_cluster.ml_cluster
  ]
}

# Inference Node Group - Up to 4 H100s
resource "yandex_kubernetes_node_group" "gpu_inference_group" {
  cluster_id = yandex_kubernetes_cluster.ml_cluster.id
  name       = var.inference_node_config.name
  version    = var.cluster_version

  labels = merge(var.labels, {
    node_type = "gpu-inference"
    gpu_type  = "h100"
    workload  = "inference"
  })

  node_labels = {
    "node.kubernetes.io/gpu"      = "h100"
    "nebius.ai/node-type"        = "gpu-inference"
    "nebius.ai/gpu-fabric"       = tostring(var.gpu_fabric)
    "workload-type"              = "inference"
  }

  instance_template {
    platform_id = "gpu-standard-v3"

    resources {
      memory = 240
      cores  = 40
      gpus   = var.inference_node_config.gpu_count
    }

    boot_disk {
      type = "network-ssd"
      size = 200
    }

    network_interface {
      subnet_ids         = ["e9bojadgs2bq45374f1g"]
      nat                = true
      security_group_ids = ["enpcq1hanif0c6ne64ru"]
    }

    metadata = {
      ssh-keys = var.ssh_public_key != "" ? "ubuntu:${var.ssh_public_key}" : null
      "gpu-cluster" = "fabric-${var.gpu_fabric}"
    }

    scheduling_policy {
      preemptible = var.inference_node_config.preemptible
    }

    gpu_settings {
      gpu_cluster_id = "gpu-cluster-fabric-${var.gpu_fabric}"
      gpu_environment = "runc_drivers_cuda"
    }
  }

  scale_policy {
    fixed_scale {
      size = var.inference_node_config.node_count
    }
  }

  allocation_policy {
    location {
      zone = var.zone
    }
  }

  maintenance_policy {
    auto_upgrade = false
    auto_repair  = true

    maintenance_window {
      start_time = "03:00"
      duration   = "3h"
    }
  }

  depends_on = [
    yandex_kubernetes_cluster.ml_cluster
  ]
}
