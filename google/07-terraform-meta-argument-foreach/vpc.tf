resource "google_compute_network" "myvpc" {
  name                    = "vpc1"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "mysubnet" {
  name          = "mysubnet1"
  region        = var.gcp_region
  ip_cidr_range = "10.128.0.0/20"
  network       = google_compute_network.myvpc.id
}
