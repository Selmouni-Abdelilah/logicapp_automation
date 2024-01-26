variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  default     = "logic-app-rg"
}

variable "location" {
  description = "Azure region for resources"
  default     = "East US"
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account"
  default     = "logicappacc1937"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  default     = "logicapp-service-plan"
}

variable "logic_app_name" {
  description = "Name of the Logic App"
  default     = "logicapptoslackterraform"
}
