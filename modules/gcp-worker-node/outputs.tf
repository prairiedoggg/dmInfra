output "instance_names" {
  description = "생성된 워커 노드 인스턴스 이름 목록"
  value       = google_compute_instance.worker[*].name
}

output "internal_ips" {
  description = "생성된 워커 노드 인스턴스의 내부 IP 목록"
  value       = google_compute_instance.worker[*].network_interface[0].network_ip
}

output "external_ips" {
  description = "생성된 워커 노드 인스턴스의 외부 IP 목록"
  value       = google_compute_instance.worker[*].network_interface[0].access_config[0].nat_ip
}