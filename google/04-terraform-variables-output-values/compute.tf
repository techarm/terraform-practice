resource "google_compute_instance" "myapp1" {
  name         = "myapp1"
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
    subnetwork = google_compute_subnetwork.mysubnet.id
  }
}
