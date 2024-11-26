resource "google_compute_region_autoscaler" "myapp" {
  name   = "${local.name}-myapp-autoscaler"
  target = google_compute_region_instance_group_manager.myapp.id
  autoscaling_policy {
    max_replicas    = 6
    min_replicas    = 2
    cooldown_period = 60
    cpu_utilization {
      target = 0.9
    }
  }
}
