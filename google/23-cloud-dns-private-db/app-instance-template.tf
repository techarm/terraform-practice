# Google Compute Engine: Regional Instance Template
resource "google_compute_region_instance_template" "myapp" {
  name        = "${local.name}-myapp-template"
  description = "This template is used to create MyApp server instances."
  tags = [
    tolist(google_compute_firewall.fw_ssh.target_tags)[0],
    tolist(google_compute_firewall.fw_http.target_tags)[0],
    tolist(google_compute_firewall.fw_health_checks.target_tags)[0]
  ]
  instance_description = "MyApp VM Instances"
  machine_type         = var.machine_type
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  # Create a new boot disk from an image
  disk {
    # source_image      = "debian-cloud/debian-12"
    source_image = data.google_compute_image.my_image.self_link
    auto_delete  = true
    boot         = true
  }

  # Network Info
  network_interface {
    subnetwork = data.terraform_remote_state.project_db.outputs.mysubnet_id
  }

  # Install Webserver
  # metadata_startup_script = file("${path.module}/scripts/setup.sh")
  metadata_startup_script = templatefile("ums-install.tmpl", { cloudsql_db_endpoint = data.terraform_remote_state.project_db.outputs.cloudsql_db_private_ip })

  labels = {
    environment = local.environment
  }

  metadata = {
    environment = local.environment
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.myapp.email
    scopes = ["cloud-platform"]
  }
}

