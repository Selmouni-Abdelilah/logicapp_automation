variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  default     = "la-tfdeploy-rg"
}

variable "location" {
  description = "Azure region for resources"
  default     = "East US"
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account"
  default     = "logicappacc"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  default     = "logicappserviceplan"
}

variable "logic_app_name" {
  description = "Name of the Logic App"
  default     = "logicapptoslack"
}
