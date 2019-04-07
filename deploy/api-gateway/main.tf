resource "aws_api_gateway_rest_api" "inventory_tracker_api" {
  name = "inventory-tracker-api"
  body = "${data.template_file.api.rendered}"
}

resource "aws_api_gateway_deployment" "inventory_tracker_deployment" {

  rest_api_id = "${aws_api_gateway_rest_api.inventory_tracker_api.id}"
  stage_name  = "${terraform.workspace}"
  variables = {}
}

resource "aws_api_gateway_usage_plan" "usage_plan" {
  name = "usage_plan"

  api_stages {
    api_id = "${aws_api_gateway_rest_api.inventory_tracker_api.id}"
    stage  = "${aws_api_gateway_deployment.inventory_tracker_deployment.stage_name}"
  }
}

resource "aws_api_gateway_api_key" "key" {
  name = "${terraform.workspace}_key"
}

resource "aws_api_gateway_usage_plan_key" "usage_plan_key" {
  key_id        = "${aws_api_gateway_api_key.key.id}"
  key_type      = "API_KEY"
  usage_plan_id = "${aws_api_gateway_usage_plan.usage_plan.id}"
}


