variable "gcp_project" {
  description = "Project in which GPC resources to be created"
  type        = string
  default     = "gcplearn202411"
}

variable "gcp_region" {
  description = "Region which GPC resources to be created"
  type        = string
  default     = "us-central1"
}

variable "machine_type" {
  description = "Compute Engine Machine type"
  type        = string
  default     = "e2-small"
}
