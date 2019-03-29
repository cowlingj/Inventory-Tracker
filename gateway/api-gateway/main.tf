data "template_file" "api" {
  template = "${file("${path.root}/${var.api_spec}")}"
  vars = {
    list_get_uri = "${aws_lambda_function.test_lambda.invoke_arn}",
    list_post_uri = "${aws_lambda_function.test_lambda.invoke_arn}",
    list_put_uri = "${aws_lambda_function.test_lambda.invoke_arn}",
    list_delete_uri = "${aws_lambda_function.test_lambda.invoke_arn}",
    report_get_uri = "${aws_lambda_function.test_lambda.invoke_arn}"
  }
}

resource "aws_api_gateway_rest_api" "inventory_tracker_api" {
  name = "inventory-tracker-api"
  body = "${data.template_file.api.rendered}"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
  assume_role_policy = "${file("${path.module}/lambda-iam.json")}"
}

data "archive_file" "lambda_zip" {
    type        = "zip"
    source_file  = "${path.root}/${var.src_dir}/stub.js"
    output_path = "${path.root}/${var.build_dir}/stub.zip"
}

resource "aws_lambda_function" "test_lambda" {
  filename         = "${data.archive_file.lambda_zip.output_path}"
  function_name    = "lambda_function_name"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "stub.stub"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "nodejs8.10"

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


