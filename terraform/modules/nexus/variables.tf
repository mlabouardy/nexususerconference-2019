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
