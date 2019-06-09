provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

terraform {
  backend "gcs" {
    bucket      = "terraform-remote-state-mlabouardy"
    prefix      = "nexus-user-conference-2019/"
    credentials = "/Users/mlabouardy/.gcp/account.json"
  }
}
