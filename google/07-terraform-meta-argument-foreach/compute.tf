variable "zone_machine_map" {
  type = map(string)
  default = {
    "us-central1-a" = "e2-micro"
    "us-central1-b" = "e2-small"
    "us-central1-c" = "e2-medium"
  }
}

resource "google_compute_instance" "myapp" {
  # for_each = toset(data.google_compute_zones.available.names)
  for_each = var.zone_machine_map

  name         = "myapp-vm-${each.key}"
  machine_type = each.value
  zone         = each.key
  tags = [
    tolist(google_compute_firewall.fw_ssh.target_tags)[0],
    tolist(google_compute_firewall.fw_http.target_tags)[0]
  ]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  metadata_startup_script = file("${path.module}/scripts/setup.sh")
  network_interface {
    subnetwork = google_compute_subnetwork.mysubnet.id
    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}
