variable "gcp_project_id" {
  description = "운영 환경 GCP 프로젝트 ID"
  type        = string
  # Sensitive value, to be provided via terraform.tfvars or environment variables
}

variable "gcp_region" {
  description = "운영 환경 GCP 리전"
  type        = string
  default     = "asia-northeast3" # 예: 서울 리전
}

variable "gcp_zone" {
  description = "운영 환경 GCP Zone"
  type        = string
  default     = "asia-northeast3-a" # 예: 서울 리전 Zone A
}

variable "gcp_network_name" {
  description = "운영 환경에서 사용할 GCP 네트워크 이름"
  type        = string
  default     = "default" # 실제 운영 환경 네트워크 이름으로 변경 필요
}

variable "gcp_subnetwork_name" {
  description = "운영 환경에서 사용할 GCP 서브네트워크 이름"
  type        = string
  default     = null # 기본값 null (네트워크의 기본 서브넷 사용) 또는 실제 운영 환경 서브넷 이름 지정
}

variable "worker_node_count_prod" {
  description = "운영 환경에 생성할 워커 노드 인스턴스 수"
  type        = number
  default     = 3 # MVP에 필요한 적절한 수로 조정
}

variable "worker_node_machine_type_prod" {
  description = "운영 환경 워커 노드의 머신 타입"
  type        = string
  default     = "e2-medium" # 운영 환경 부하에 맞게 조정 필요 (예: "e2-standard-2")
}

variable "worker_node_boot_disk_image_prod" {
  description = "운영 환경 워커 노드의 부팅 디스크 이미지"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2004-lts" # 운영체제 및 버전 확인 필요
}

variable "prod_tags" {
  description = "운영 환경 리소스에 적용할 공통 태그 목록 (GCP에서는 network_tags)"
  type        = list(string)
  default     = ["prod", "mvp-worker"]
}

variable "prod_labels" {
  description = "운영 환경 리소스에 적용할 공통 라벨 맵"
  type        = map(string)
  default = {
    environment = "prod"
    service     = "mvp-backend" # 예시 라벨
    purpose     = "worker-node"
  }
}

variable "k3s_url_prod" {
  description = "운영 환경 k3s 마스터 노드 URL"
  type        = string
  default     = null
}

variable "k3s_token_prod" {
  description = "운영 환경 k3s 클러스터 조인 토큰"
  type        = string
  sensitive   = true
  default     = null
}

# 필요에 따라 추가 변수 선언 (예: 서비스 계정 이메일)
# variable "gcp_service_account_email_prod" {
#   description = "운영 환경 워커 노드에 할당할 서비스 계정 이메일"
#   type        = string
#   default     = null # null이면 Compute Engine 기본 서비스 계정 사용
# } 