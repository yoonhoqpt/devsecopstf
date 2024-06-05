provider "google" {
  project = "learnproject-425520"
  region  = "us-central1"
}

resource "google_container_cluster" "primary" {
  name     = "primary"
  location = "us-central1"

  node_config {
    machine_type = "e2-medium"
  }

  initial_node_count = 2
}

resource "google_container_node_pool" "primary_nodes" {
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  node_count = 3

  node_config {
    machine_type = "e2-medium"
  }
}

resource "google_container_cluster" "k8s_cluster" {
  name     = "sample-k8s-cluster"
  location = "us-central1"
  initial_node_count = 1
  min_master_version = "latest"
}

output "k8s_cluster_name" {
  value = google_container_cluster.k8s_cluster.name
}