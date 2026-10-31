variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "canadacentral"
}

variable "app_name" {
  description = "Short app name used in every resource name"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,12}$", var.app_name))
    error_message = "app_name must be 3-12 lowercase letters or digits."
  }
}

variable "environment" {
  description = "Environment name"
  type        = string

  validation {
    condition     = contains(["lab", "dev", "test", "prod"], var.environment)
    error_message = "environment must be lab, dev, test or prod."
  }
}

variable "name_suffix" {
  description = "Short suffix that keeps globally unique names unique"
  type        = string
}

variable "tags" {
  description = "Extra tags merged into the standard tags"
  type        = map(string)
  default     = {}
}
