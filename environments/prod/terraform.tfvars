# dmInfra/environments/prod/terraform.tfvars
# 운영 환경 변수들의 실제 값을 여기에 지정합니다.
# 중요: 이 파일은 민감한 정보를 포함할 수 있으므로, 실제 값으로 채운 후 .gitignore 에 추가하세요.

# --- 필수 값 (반드시 실제 운영 환경 값으로 변경하세요) ---
gcp_project_id = "redream-459306" # 예: my-prod-project-12345

# --- 선택 값 (기본값을 사용하지 않거나 변경할 경우 주석 해제 및 수정) ---
gcp_region     = "asia-northeast3"
# gcp_zone       = "asia-northeast3-c" # 기본값(asia-northeast3-a)과 다른 Zone 사용 시

# gcp_network_name = "prod-vpc-network" # 기본값 'default' 대신 사용할 경우
# gcp_subnetwork_name = "prod-subnet-01" # 특정 서브넷 지정 시

worker_node_count_prod = 5 # 기본값(3)과 다른 워커 노드 수 지정 시

worker_node_machine_type_prod = "e2-standard-2" # 기본값(e2-medium)과 다른 머신 타입 지정 시

  worker_node_boot_disk_image_prod = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts" # 우분투 22.04 이미지 사용

# prod_tags = ["production", "webserver"] # 기본값과 다른 태그 사용 시

prod_labels = {
  environment = "production"
  app_tier    = "backend"
  version     = "v1-0"
} # 기본값과 다른 라벨 사용 시₩

# --- k3s 워커 노드 설정 (매우 민감한 정보 포함 가능, 보안 주의) ---
# 실제 운영 환경에서는 k3s_token_prod 값을 .tfvars에 직접 저장하는 것보다
# GCP Secret Manager에서 가져오거나 CI/CD 환경 변수를 통해 주입하는 것을 강력히 권장합니다.
# k3s_url_prod = "https://<YOUR_K3S_MASTER_IP_OR_DNS>:6443"
# k3s_token_prod = "<YOUR_K3S_CLUSTER_JOIN_TOKEN>" # 실제 토큰 값으로 변경

# gcp_service_account_email_prod = "your-prod-service-account@your-actual-prod-gcp-project-id.iam.gserviceaccount.com" # 워커 노드에 특정 서비스 계정 할당 시 