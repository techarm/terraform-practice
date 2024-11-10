
resource "google_compute_instance_from_template" "myapp" {
  for_each                 = toset(data.google_compute_zones.available.names)
  name                     = "${local.name}-myapp-vm-${each.key}"
  zone                     = each.key
  source_instance_template = google_compute_region_instance_template.myapp.self_link
}
