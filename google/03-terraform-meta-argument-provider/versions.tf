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
  project = "gcplearn202411"
  region  = "us-central1"
  alias   = "us-central1"
}

provider "google" {
  project = "gcplearn202411"
  region  = "europe-west1"
  alias   = "europe-west1"
}
