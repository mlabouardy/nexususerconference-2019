resource "google_container_cluster" "cluster" {
  name     = "${var.environment}"
  location = "${var.zone}"

  remove_default_node_pool = true

  initial_node_count = "${var.k8s_nodes}"

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "pool" {
  name       = "k8s-node-pool-${var.environment}"
  location   = "${var.zone}"
  cluster    = "${google_container_cluster.cluster.name}"
  node_count = "${var.k8s_nodes}"

  node_config {
    preemptible  = true
    machine_type = "${var.instance_type}"

    metadata {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
