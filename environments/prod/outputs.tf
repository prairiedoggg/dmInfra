output "gcp_prod_worker_instance_names" {
  description = "생성된 운영 환경 GCP 워커 노드 인스턴스 이름 목록"
  value       = module.gcp_prod_workers.instance_names
}

output "gcp_prod_worker_internal_ips" {
  description = "생성된 운영 환경 GCP 워커 노드 내부 IP 목록"
  value       = module.gcp_prod_workers.internal_ips
}

output "gcp_prod_worker_external_ips" {
  description = "생성된 운영 환경 GCP 워커 노드 외부 IP 목록 (주의: 보안상 필요한 경우에만 출력)"
  value       = module.gcp_prod_workers.external_ips
  # sensitive   = true # 민감 정보로 처리하여 plan/apply 시 기본으로 숨김
}

# 향후 prod 환경의 다른 주요 리소스 정보를 출력할 수 있습니다.
# output "gke_prod_cluster_endpoint" {
#   description = "운영 환경 GKE 클러스터 엔드포인트"
#   value       = module.gke_prod_cluster.endpoint
#   sensitive   = true
# } 