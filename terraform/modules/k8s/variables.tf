variable "zone" {
  description = "availability zone"
}

## Default variables

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
