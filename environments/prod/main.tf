# --- Provider Configuration ---
# 운영 환경 GCP 프로젝트 및 인증 정보를 설정합니다.
# 인증은 별도 설정을 하지 않으면 Application Default Credentials (ADC)를 사용합니다.
# (로컬에서 gcloud auth application-default login 실행 또는 CI/CD 환경의 서비스 계정/Workload Identity 사용)
# 특정 서비스 계정 키 파일을 사용하려면 credentials 인자를 추가할 수 있습니다.
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# --- Resource Definitions ---

# 1. GCP 워커 노드 생성
# modules/gcp-worker-node 모듈을 사용하여 운영 환경 워커 노드를 생성합니다.
module "gcp_prod_workers" {
  # source 경로는 이 파일(environments/prod/main.tf) 기준 상대 경로입니다.
  source = "../../modules/gcp-worker-node"

  # 모듈의 variables.tf 에 정의된 입력 변수들에 값을 전달합니다.
  # 값은 이 디렉토리의 variables.tf 에 선언된 변수들을 참조합니다.
  project_id      = var.gcp_project_id
  zone            = var.gcp_zone
  network_name    = var.gcp_network_name
  subnetwork_name = var.gcp_subnetwork_name
  boot_disk_image = var.worker_node_boot_disk_image_prod
  instance_count  = var.worker_node_count_prod
  machine_type    = var.worker_node_machine_type_prod
  tags            = var.prod_tags  # GCP에서는 network tags로 사용됨
  labels          = var.prod_labels

  # k3s 관련 변수 전달
  k3s_url         = var.k3s_url_prod
  k3s_token       = var.k3s_token_prod

  # 만약 서비스 계정을 variables.tf 에 추가했다면 아래 주석 해제 및 값 전달
  # service_account_email = var.gcp_service_account_email_prod
}

# 2. (향후 추가될 prod 환경 리소스들)
# 예: GKE 클러스터, Cloud SQL 데이터베이스, 로드 밸런서 등
# module "gke_prod_cluster" { ... }
# module "cloudsql_prod_db" { ... }

# --- Backend Configuration (Optional but Recommended for Prod) ---
# Terraform 상태 파일을 원격 스토리지(예: GCS)에 안전하게 저장합니다.
terraform {
  backend "gcs" {
    bucket  = "redream-terraform-state-prod" 
    prefix  = "terraform/prod/state" 
  }
} 