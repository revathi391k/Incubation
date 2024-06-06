variable "resource_group_name" {
  type        = string
  description = ""
}

variable "location" {
  type        = string
  description = ""
}

variable "cluster_name" {
  type        = string
  description = ""
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}

variable "acr_name" {
  type        = string
  description = "ACR name"
}
