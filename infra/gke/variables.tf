variable "name" {
  type        = string
  description = "Deployment name"
  default     = "gke-app"
}

variable "project" {
  type        = string
  description = "GCP project name"
  default     = "denis-sandbox-666"
}

variable "region" {
  type        = string
  description = "GCP region for deployment"
  default     = "us-central1"
}

variable "zone" {
  type        = string
  description = "GCP zone for deployment"
  default     = "us-central1-a"
}

variable "gke_location" {
  type        = string
  description = "Specific location of GKE cluster"
  default     = "us-central1-a"
}

variable "gke_preemptible" {
  type        = bool
  description = "Use preemptible K8S nodes to save costs(and add more risks (: )"
  default     = true
}

variable "gke_default_node_count" {
  type        = number
  description = "Number of GKE ndoes in default node pool"
  default     = 2
}

variable "gke_default_machine_type" {
  type        = string
  description = "Machine type for nodes in default pool"
  default     = "n1-standard-1"
}