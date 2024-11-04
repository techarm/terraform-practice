terraform {
  required_version = ">= 1.9.8"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.9.0"
    }
  }
}

provider "google" {
  project = "gcplearn202411" # Project ID
  region  = "us-central1"
}
