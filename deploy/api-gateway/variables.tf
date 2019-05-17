variable "lambda_arns" {
  type = "map"
}

variable "lambda_names" {
  type = "map"
}


locals {
  api_name = "inventory_tracker_api-${terraform.workspace}"
  api_description = "The API that the Inventory Tracker clients communicate with"
}


