output "dashboard" {
  value = "https://${google_dns_record_set.nexus-dashboard-record.name}"
}

output "registry" {
  value = "https://${google_dns_record_set.nexus-registry-record.name}"
}
