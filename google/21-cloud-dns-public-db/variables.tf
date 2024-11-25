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
  description = "Compute Engine Machine Type"
  type        = string
  default     = "e2-small"
}

variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
  default     = "dev"
}

variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type        = string
  default     = "sap"
}

# GCP Notification Email for Cloud Monitoring
variable "gcp_notification_email" {
  description = "GCP Notification email"
  type        = string
  default     = "abcd1234@gmail.com"
}
