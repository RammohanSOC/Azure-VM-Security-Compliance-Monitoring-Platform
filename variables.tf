variable "location" {
  description = "Azure region"
  type        = string
  default     = "Central India"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "rg-vm-compliance"
}

variable "vm_name" {
  description = "Linux VM name"
  type        = string
  default     = "vm-compliance-01"
}

variable "admin_username" {
  description = "Linux administrator username"
  type        = string
  default     = "azureadmin"
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
  sensitive   = true
}

variable "alert_email" {
  description = "Email address for Azure Monitor alerts"
  type        = string
}
