locals {
  mydomain         = "myapp.cloud.techarm.uk"
  dns_managed_zone = "cloud-techarm-uk"
}

# Resource: Cloud DNS Record Set for A Record
resource "google_dns_record_set" "a_record" {
  managed_zone = local.dns_managed_zone
  name         = "${local.mydomain}."
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_address.mylb.address]
}
