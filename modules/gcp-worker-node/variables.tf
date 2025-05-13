variable "project_id" {
  description = "GCP 프로젝트 ID"
  type        = string
}

variable "zone" {
  description = "워커 노드를 생성할 Zone"
  type        = string
}

variable "network_name" {
  description = "워커 노드가 사용할 네트워크 이름"
  type        = string
}

variable "subnetwork_name" {
  description = "워커 노드가 사용할 서브네트워크 이름"
  type        = string
  default     = null # null이면 네트워크의 기본 서브넷 사용 (auto mode)
}

variable "boot_disk_image" {
  description = "워커 노드 부팅 디스크 이미지"
  type        = string
  # 예: "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "service_account_email" {
  description = "인스턴스에 할당할 서비스 계정 이메일"
  type        = string
  default     = null # null이면 Compute Engine 기본 서비스 계정 사용
}

variable "scopes" {
  description = "서비스 계정에 허용할 접근 범위 목록"
  type        = list(string)
  default     = ["https://www.googleapis.com/auth/cloud-platform"]
}

variable "instance_count" {
  description = "생성할 워커 노드 인스턴스 수"
  type        = number
}

variable "machine_type" {
  description = "워커 노드 머신 타입"
  type        = string
  default     = "e2-medium" # 2 vCPU, 4 GB memory
}

variable "tags" {
  description = "인스턴스에 적용할 태그 목록"
  type        = list(string)
  default     = []
}

variable "labels" {
  description = "인스턴스에 적용할 라벨 맵"
  type        = map(string)
  default     = {}
}

variable "k3s_url" {
  description = "k3s 마스터 노드 URL (예: https://<master_ip>:6443)"
  type        = string
  default     = null # 이 값이 null이면 시작 스크립트가 실행되지 않도록 처리 가능
}

variable "k3s_token" {
  description = "k3s 클러스터 조인 토큰"
  type        = string
  sensitive   = true # 토큰은 민감 정보로 처리
  default     = null
}