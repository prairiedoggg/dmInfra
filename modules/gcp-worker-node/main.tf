resource "google_compute_instance" "worker" {
  count        = var.instance_count
  project      = var.project_id
  zone         = var.zone
  name         = "gcp-worker-${count.index}"
  machine_type = var.machine_type
  tags         = var.tags
  labels       = var.labels

  boot_disk {
    initialize_params {
      image = var.boot_disk_image
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork_name
    # access_config를 빈 블록으로 두면 임시 외부 IP 할당
    access_config {}
  }

  # 서비스 계정 설정 (지정된 경우)
  service_account {
    email  = var.service_account_email
    scopes = var.scopes
  }

  # k3s_url 과 k3s_token 이 제공되었을 경우에만 시작 스크립트 실행
metadata_startup_script = (
  var.k3s_url != null && var.k3s_token != null ?
  <<-EOT
    #!/bin/bash
    sleep 10   # 네트워크 준비 대기
    curl -sfL https://get.k3s.io | K3S_URL="${var.k3s_url}" K3S_TOKEN="${var.k3s_token}" sh -

  EOT
  : null
)

}