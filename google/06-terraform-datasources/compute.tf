resource "google_compute_instance" "myapp" {
  count        = 2
  name         = "myapp-vm-${count.index}"
  machine_type = var.machine_type
  zone         = data.google_compute_zones.available.names[count.index]
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
