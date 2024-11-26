# Resource: Certificate Manager DNS Authorization
resource "google_certificate_manager_dns_authorization" "myapp" {
  location    = var.gcp_region
  name        = "${local.name}-myapp-dns-authorization"
  description = "myapp dns authorization"
  domain      = local.mydomain
}

# Resource: Certificate manager certificate
resource "google_certificate_manager_certificate" "myapp" {
  location    = var.gcp_region
  name        = "${local.name}-ssl-certificate"
  description = "${local.name} Certificate Manager SSL Certificate"
  scope       = "DEFAULT"
  labels = {
    env = local.environment
  }
  managed {
    domains = [
      google_certificate_manager_dns_authorization.myapp.domain
    ]
    dns_authorizations = [
      google_certificate_manager_dns_authorization.myapp.id
    ]
  }
}

# Resource: DNS record to be created in DNS zone for DNS Authorization
resource "google_dns_record_set" "myapp_cname" {
  managed_zone = local.dns_managed_zone
  name         = google_certificate_manager_dns_authorization.myapp.dns_resource_record[0].name
  type         = google_certificate_manager_dns_authorization.myapp.dns_resource_record[0].type
  ttl          = 300
  rrdatas      = [google_certificate_manager_dns_authorization.myapp.dns_resource_record[0].data]
}
