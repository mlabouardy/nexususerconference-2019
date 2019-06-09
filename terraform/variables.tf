variable "credentials" {
  description = " file that contains your service account private key in JSON format"
}

variable "project" {
  description = "GCP project where resources will be created"
}

variable "region" {
  description = "location for your resources to be created in"
}

variable "zone" {
  description = "availability zone"
}

variable "ssh_user" {
  description = "GCE SSH username"
}

variable "ssh_pub_key_file" {
  description = "SSH Public key path"
}

## Default variables

variable "image_name" {
  description = "Image to be used"
  default     = "nexus-v3-16-2-01"
}

variable "instance_type" {
  description = "Machine type"
  default     = "n1-standard-1"
}

variable "k8s_nodes" {
  description = "Kubernetes cluster nodes"
  default     = 3
}

variable "environment" {
  description = "Environment"
  default     = "sandbox"
}
