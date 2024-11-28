# GCP Project
variable "gcp_project" {
  description = "Project in which GCP Resources to be created"
  type        = string
  default     = ""
}

# GCP Region
variable "gcp_region" {
  description = "Region in which GCP Resources to be created"
  type        = string
  default     = ""
}

# GCP Compute Engine Machine Type
variable "machine_type" {
  description = "Compute Engine Machine Type"
  type        = string
}

variable "subnetwork" {
  description = "Subnet to deploy to. Only one of network or subnetwork should be specified."
  type        = string
}

variable "zone" {
  type        = string
  description = "Zone where the instances should be created. If not specified, instances will be spread across available zones in the region."
  default     = null
}

variable "vminstance_name" {
  type        = string
  description = "VM Instance Name"
}

variable "firewall_tags" {
  description = "List of firewall tags"
  type        = list(string)
}
