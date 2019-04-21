variable "api_spec" {
  type = "string"
}

variable "lambda_arns" {
  type = "map"
}

variable "api_name" {
  type = "string"
  default = "Inventory Tracker API"
}

variable "api_description" {
  type = "string"
  default = "The API that the Inventory Tracker clients communicate with"
}

