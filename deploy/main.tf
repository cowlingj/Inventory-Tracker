provider "aws" {
  region                  = "eu-west-1"
  shared_credentials_file = "${path.root}/secrets/aws/credentials"
  profile                 = "default"
  version = "2.3"
  assume_role {
    role_arn     = "arn:aws:iam::057981246180:role/inventory_tracker_admin_role"
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
  table_arn = "${module.dynamo-db.table_arn}"
}

module "api-gateway" {
  source = "./api-gateway"
  table_arn = "${module.dynamo-db.table_arn}"
  api_spec = "${var.api_spec}"
  lambda_args = {
    invoke_get_list = "${module.lambda.lambda_arns["invoke_get_list"]}"
    invoke_put_list = "${module.lambda.lambda_arns["invoke_put_list"]}"
    invoke_post_list = "${module.lambda.lambda_arns["invoke_post_list"]}"
    invoke_delete_list = "${module.lambda.lambda_arns["invoke_delete_list"]}"
    invoke_get_report = "${module.lambda.lambda_arns["invoke_get_report"]}"
  }
}

