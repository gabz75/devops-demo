provider "google" {
  project     = var.project_id
  credentials = file(var.credentials_path)
  region      = "us-central1"
}

resource "google_storage_bucket" "terraform_state_bucket" {
  name          = var.bucket_name
  location      = "us-central1"
  force_destroy = true
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true
}

terraform {
  backend "gcs" {
    bucket  = "devops-demo-440201-terraform-state"
    prefix  = "terraform/state"
  }
}