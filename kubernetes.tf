resource "yandex_kubernetes_cluster" "ml_cluster" {
  name        = var.cluster_name
  description = "Managed Kubernetes cluster for ML demo"

  network_id = data.yandex_vpc_network.existing_network.id

  master {
    version = var.cluster_version
    zonal {
      zone      = var.zone
      subnet_id = data.yandex_vpc_subnet.existing_subnet.id
    }

    public_ip = true

    security_group_ids = [data.yandex_vpc_security_group.existing_sg.id]

    maintenance_policy {
      auto_upgrade = false

      maintenance_window {
        start_time = "03:00"
        duration   = "3h"
      }
    }
  }

  cluster_ipv4_range = var.cluster_ipv4_range
  service_ipv4_range = var.service_ipv4_range

  service_account_id      = yandex_iam_service_account.k8s_cluster_sa.id
  node_service_account_id = yandex_iam_service_account.k8s_node_sa.id

  labels = var.labels

  release_channel         = "REGULAR"
  network_policy_provider = "CALICO"

  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s_cluster_agent,
    yandex_resourcemanager_folder_iam_member.vpc_admin,
    yandex_resourcemanager_folder_iam_member.k8s_admin,
    yandex_resourcemanager_folder_iam_member.k8s_node_group,
    yandex_resourcemanager_folder_iam_member.vpc_user,
  ]
}
