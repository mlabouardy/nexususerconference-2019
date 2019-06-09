module "nexus" {
  source           = "./modules/nexus"
  zone             = "${var.zone}"
  ssh_user         = "${var.ssh_user}"
  ssh_pub_key_file = "${var.ssh_pub_key_file}"
  image_name       = "${var.image_name}"
  instance_type    = "${var.instance_type}"
}

module "kubernetes" {
  source        = "./modules/k8s"
  zone          = "${var.zone}"
  instance_type = "${var.instance_type}"
  k8s_nodes     = "${var.k8s_nodes}"
  environment   = "${var.environment}"
}
