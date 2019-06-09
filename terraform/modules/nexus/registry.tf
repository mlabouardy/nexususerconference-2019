resource "google_compute_target_https_proxy" "nexus-registry-proxy" {
  name             = "nexus-registry-proxy"
  url_map          = "${google_compute_url_map.nexus-registry-mapping.self_link}"
  ssl_certificates = ["registry-serverlessmovies"]
}

resource "google_compute_url_map" "nexus-registry-mapping" {
  name = "nexus-registry-mapping"

  default_service = "${google_compute_backend_service.nexus-registry-backend.self_link}"

  host_rule {
    hosts        = ["registry.serverlessmovies.com"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = "${google_compute_backend_service.nexus-registry-backend.self_link}"

    path_rule {
      paths   = ["/*"]
      service = "${google_compute_backend_service.nexus-registry-backend.self_link}"
    }
  }
}

resource "google_compute_backend_service" "nexus-registry-backend" {
  name        = "nexus-registry-backend"
  port_name   = "registry"
  protocol    = "HTTP"
  timeout_sec = 10

  health_checks = ["${google_compute_http_health_check.nexus-backend-healthcheck.self_link}"]

  backend {
    group = "${google_compute_instance_group.nexus-group.self_link}"
  }
}

resource "google_compute_global_forwarding_rule" "nexus-registry-forward-rule" {
  name       = "nexus-registry-forward-rule"
  target     = "${google_compute_target_https_proxy.nexus-registry-proxy.self_link}"
  port_range = 443
}

resource "google_dns_record_set" "nexus-registry-record" {
  name         = "registry.serverlessmovies.com."
  type         = "A"
  ttl          = 3
  managed_zone = "${data.google_dns_managed_zone.default.name}"
  rrdatas      = ["${google_compute_global_forwarding_rule.nexus-registry-forward-rule.ip_address}"]
}
