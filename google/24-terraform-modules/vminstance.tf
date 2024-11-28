resource "google_compute_instance" "myapp" {
  name         = "${local.name}-myapp"
  machine_type = var.machine_type
  zone         = "us-central1-a"
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
    subnetwork = module.vpc.subnets_ids[0]
    access_config {
      # Include this section to give the VM an external IP address
    }
  }
}
