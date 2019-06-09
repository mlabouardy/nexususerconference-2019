resource "google_compute_instance" "nexus" {
  name         = "nexus"
  machine_type = "${var.instance_type}"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "${var.image_name}"
      size  = 100
    }
  }

  metadata {
    sshKeys = "${var.ssh_user}:${file(var.ssh_pub_key_file)}"
  }

  network_interface {
    network       = "${google_compute_network.nexus.name}"
    access_config = {}
  }
}

resource "google_compute_instance_group" "nexus-group" {
  name      = "nexus-group"
  zone      = "${var.zone}"
  instances = ["${google_compute_instance.nexus.self_link}"]

  named_port {
    name = "dashboard"
    port = "8081"
  }

  named_port {
    name = "registry"
    port = "5000"
  }
}
