terraform {
  backend "gcs" {
    bucket = "redream-terraform-state-bucket-prod"  # GCS 버킷명
    prefix = "terraform/prod/state"
  }
}
