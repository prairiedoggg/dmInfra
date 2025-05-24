terraform {
  backend "gcs" {
    bucket = "redream-terraform-state-prod"  # GCS 버킷명
    prefix = "terraform/prod/state"
  }
}
