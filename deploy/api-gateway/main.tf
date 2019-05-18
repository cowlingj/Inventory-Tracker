locals {
  source_arn = "${aws_api_gateway_deployment.inventory_tracker_deployment.execution_arn}"
}

resource "aws_api_gateway_rest_api" "inventory_tracker_api" {
  name = "${local.api_name}"
  description = "${local.api_description}"
  body = "${data.template_file.api.rendered}"
}

resource "aws_lambda_permission" "get_list" {
  statement_id  = "AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = "${var.lambda_names["get_list"]}"
  principal = "apigateway.amazonaws.com"
  source_arn = "${local.source_arn}/GET/list"
}

resource "aws_lambda_permission" "get_list_item" {
  statement_id  = "AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = "${var.lambda_names["get_list_item"]}"
  principal = "apigateway.amazonaws.com"
  source_arn = "${local.source_arn}/GET/list/{id}"
}

resource "aws_lambda_permission" "post_list" {
  statement_id  = "AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = "${var.lambda_names["post_list"]}"
  principal = "apigateway.amazonaws.com"
  source_arn = "${local.source_arn}/POST/list"
}

resource "aws_lambda_permission" "put_list" {
  statement_id  = "AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = "${var.lambda_names["put_list"]}"
  principal = "apigateway.amazonaws.com"
  source_arn = "${local.source_arn}/PUT/list"
}

resource "aws_lambda_permission" "delete_list" {
  statement_id  = "AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = "${var.lambda_names["delete_list"]}"
  principal = "apigateway.amazonaws.com"
  source_arn = "${local.source_arn}/DELETE/list"
}

resource "aws_lambda_permission" "get_report" {
  statement_id  = "AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = "${var.lambda_names["get_report"]}"
  principal = "apigateway.amazonaws.com"
  source_arn = "${local.source_arn}/GET/report"
}

resource "aws_api_gateway_deployment" "inventory_tracker_deployment" {

  rest_api_id = "${aws_api_gateway_rest_api.inventory_tracker_api.id}"
  stage_name = "${terraform.workspace}"
  variables = {}
}

resource "aws_api_gateway_usage_plan" "usage_plan" {
  name = "usage_plan"

  api_stages {
    api_id = "${aws_api_gateway_rest_api.inventory_tracker_api.id}"
    stage = "${aws_api_gateway_deployment.inventory_tracker_deployment.stage_name}"
  }

  quota_settings {
    limit = 1000
    period = "DAY"
  }

  throttle_settings {
    burst_limit = 2
    rate_limit = 5
  }
}

resource "aws_api_gateway_api_key" "key" {
  name = "inventory_tracker_${terraform.workspace}_key"
}

resource "aws_api_gateway_usage_plan_key" "usage_plan_key" {
  key_id = "${aws_api_gateway_api_key.key.id}"
  key_type = "API_KEY"
  usage_plan_id = "${aws_api_gateway_usage_plan.usage_plan.id}"
}


