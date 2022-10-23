variable "instance_name" {
  description = "Instance name"
  type        = string
  default     = "vm"
}

variable "instance_family_image" {
  description = "Instance image"
  type        = string
  default     = "lamp"
}

variable "vpc_subnet_id" {
  description = "VPC subnet network id"
  type        = string
}

variable "nat" {
  description = "Is external IP enabled"
  type        = bool
}