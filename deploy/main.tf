provider "aws" {
  region = "eu-west-1"
  shared_credentials_file = "${path.root}/secrets/aws/credentials"
  profile = "default"
  version = "2.3"
  assume_role {
    role_arn = "arn:aws:iam::057981246180:role/inventory_tracker_admin_role"
  }
}

provider archive {
  version = "1.2"
}

provider template {
  version = "2.1"
}

module "dynamo-db" {
  source = "./dynamo-db"
}

module "lambda" {
  source = "./lambda"
  build_dir = "${var.build_dir}"
  list_table_arn = "${module.dynamo-db.list_table_arn}"
  list_table_name = "${module.dynamo-db.list_table_name}"
}

module "api-gateway" {
  source = "./api-gateway"
  lambda_arns = {
    get_list = "${module.lambda.lambda_arns["get_list"]}"
    get_list_item = "${module.lambda.lambda_arns["get_list_item"]}"
    put_list = "${module.lambda.lambda_arns["put_list"]}"
    post_list = "${module.lambda.lambda_arns["post_list"]}"
    delete_list = "${module.lambda.lambda_arns["delete_list"]}"
    get_report = "${module.lambda.lambda_arns["get_report"]}"
  }
  lambda_names = {
    get_list = "${module.lambda.lambda_names["get_list"]}"
    get_list_item = "${module.lambda.lambda_names["get_list_item"]}"
    put_list = "${module.lambda.lambda_names["put_list"]}"
    post_list = "${module.lambda.lambda_names["post_list"]}"
    delete_list = "${module.lambda.lambda_names["delete_list"]}"
    get_report = "${module.lambda.lambda_names["get_report"]}"
  }
}

module "config-file" {
  source = "./config-file"
  api_key = "${module.api-gateway.api_key}"
  base_url = "${module.api-gateway.base_url}"
  postman_dir = "${var.postman_dir}"
  clients_dir = "${var.clients_dir}"
  build_dir = "${var.build_dir}"
  auth_name = "${module.api-gateway.auth_name}"
}



