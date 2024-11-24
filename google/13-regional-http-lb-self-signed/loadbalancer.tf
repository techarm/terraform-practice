# Resource: Reserve Regional Static IP Address
resource "google_compute_address" "mylb" {
  name   = "${local.name}-mylb-regional-static-ip"
  region = var.gcp_region
}

# Resource: Regional Health Check
resource "google_compute_region_health_check" "mylb" {
  name                = "${local.name}-mylb-myapp-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 3
  http_health_check {
    request_path = "/index.html"
    port         = 80
  }
}

# Resource: Regional Backend Service
resource "google_compute_region_backend_service" "mylb" {
  name                  = "${local.name}-myapp-backend-service"
  protocol              = "HTTP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  health_checks         = [google_compute_region_health_check.mylb.self_link]
  port_name             = "webserver"
  backend {
    group           = google_compute_region_instance_group_manager.myapp.instance_group
    capacity_scaler = 1.0
    balancing_mode  = "UTILIZATION"
  }
}

# Resource: Regional URL Map
resource "google_compute_region_url_map" "mylb" {
  name            = "${local.name}-mylb-url-map"
  default_service = google_compute_region_backend_service.mylb.self_link
}

# Resource: Regional HTTP Proxy
resource "google_compute_region_target_https_proxy" "mylb" {
  name                             = "${local.name}-mylb-http-proxy"
  url_map                          = google_compute_region_url_map.mylb.self_link
  certificate_manager_certificates = [google_certificate_manager_certificate.myapp.id]
}

# Resource: Regional Forwarding Rule
resource "google_compute_forwarding_rule" "mylb" {
  name                  = "${local.name}-mylb-forwarding-rule"
  target                = google_compute_region_target_https_proxy.mylb.self_link
  port_range            = "443"
  ip_protocol           = "TCP"
  ip_address            = google_compute_address.mylb.address
  load_balancing_scheme = "EXTERNAL_MANAGED" # Creates new GCP LB (not classic)
  network               = google_compute_network.myvpc.id
  # During the destroy process, we need to ensure LB is deleted first, before deleting VPC proxy-only subnet
  depends_on = [google_compute_subnetwork.regional_proxy_subnet]
}








