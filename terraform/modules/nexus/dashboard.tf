resource "google_compute_target_https_proxy" "nexus-dashboard-proxy" {
  name             = "nexus-dashboard-proxy"
  url_map          = "${google_compute_url_map.nexus-dashboard-mapping.self_link}"
  ssl_certificates = ["dashboard-serverlessmovies"]
}

resource "google_compute_url_map" "nexus-dashboard-mapping" {
  name = "nexus-dashboard-mapping"

  default_service = "${google_compute_backend_service.nexus-dashboard-backend.self_link}"

  host_rule {
    hosts        = ["nexus.serverlessmovies.com"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = "${google_compute_backend_service.nexus-dashboard-backend.self_link}"

    path_rule {
      paths   = ["/*"]
      service = "${google_compute_backend_service.nexus-dashboard-backend.self_link}"
    }
  }
}

resource "google_compute_backend_service" "nexus-dashboard-backend" {
  name        = "nexus-dashboard-backend"
  port_name   = "dashboard"
  protocol    = "HTTP"
  timeout_sec = 10

  health_checks = ["${google_compute_http_health_check.nexus-backend-healthcheck.self_link}"]

  backend {
    group = "${google_compute_instance_group.nexus-group.self_link}"
  }
}

resource "google_compute_http_health_check" "nexus-backend-healthcheck" {
  name               = "nexus-backend-healthcheck"
  request_path       = "/"
  port               = "8081"
  check_interval_sec = 1
  timeout_sec        = 1
}

resource "google_compute_global_forwarding_rule" "nexus-dashboard-forward-rule" {
  name       = "nexus-dashboard-forward-rule"
  target     = "${google_compute_target_https_proxy.nexus-dashboard-proxy.self_link}"
  port_range = 443
}

data "google_dns_managed_zone" "default" {
  name = "serverlessmovies"
}

resource "google_dns_record_set" "nexus-dashboard-record" {
  name         = "nexus.serverlessmovies.com."
  type         = "A"
  ttl          = 3
  managed_zone = "${data.google_dns_managed_zone.default.name}"
  rrdatas      = ["${google_compute_global_forwarding_rule.nexus-dashboard-forward-rule.ip_address}"]
}
