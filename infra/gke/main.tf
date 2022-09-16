locals {
  gke_version = "1.22.12-gke.300"
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

data "google_client_config" "provider" {}

resource "google_container_cluster" "gke" {
  name               = var.name
  project            = var.project
  description        = "GKE cluster for postgres deployment"
  min_master_version = local.gke_version
  location           = var.gke_location

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "default_pool" {
  name       = "${var.name}-default-pool"
  project    = var.project
  location   = var.gke_location
  cluster    = google_container_cluster.gke.name
  node_count = var.gke_default_node_count
  version    = local.gke_version

  node_config {
    preemptible  = var.gke_preemptible
    machine_type = var.gke_default_machine_type

    metadata = {
      disable-legacy-endpoints = true
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      app  = "k8s-app"
      pool = "default_pool"
    }
  }
}
