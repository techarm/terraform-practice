terraform {
  required_version = ">= 1.9.8"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.9.0"
    }
  }
  backend "gcs" {
    bucket = "gcplearn-tfstate"
    prefix = "myapp/httpslb-clouddns-publicdb"
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}
