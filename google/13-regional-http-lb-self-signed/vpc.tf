resource "google_compute_network" "myvpc" {
  name                    = "${local.name}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "mysubnet" {
  name          = "${var.gcp_region}-subnet"
  region        = var.gcp_region
  ip_cidr_range = "10.128.0.0/20"
  network       = google_compute_network.myvpc.id
}

resource "google_compute_subnetwork" "regional_proxy_subnet" {
  name          = "${var.gcp_region}-regional-proxy-subnet"
  region        = var.gcp_region
  ip_cidr_range = "10.0.0.0/24"
  purpose       = "REGIONAL_MANAGED_PROXY"
  network       = google_compute_network.myvpc.id
  role          = "ACTIVE"
}
