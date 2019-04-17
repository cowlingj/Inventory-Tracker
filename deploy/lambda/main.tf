resource "aws_iam_role" "lambda_role" {
  name = "inventory_tracker_lambda_role"
  assume_role_policy = "${data.template_file.lambda_role_policy.rendered}"
  tags = {
    Project = "inventory_tracker"
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name = "inventory_tracker_service_policy"
  policy = "${data.template_file.lambda_policy.rendered}"
}

resource "aws_iam_role_policy_attachment" "attach_role_to_policy" {
  role = "${aws_iam_role.lambda_role.name}"
  policy_arn = "${aws_iam_policy.lambda_policy.arn}"
}

resource "aws_lambda_function" "stub_lambda" {
  filename         = "${path.root}/${var.build_dir}/stub.zip"
  function_name    = "inventory_list_stub"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "stub.stub"
  source_code_hash = "${filebase64sha256("${path.root}/${var.build_dir}/stub.zip")}"
  runtime          = "nodejs8.10"
  tags = {
    Project = "inventory_tracker"
  }
}

resource "aws_lambda_function" "get_list" {
  filename         = "${path.root}/${var.build_dir}/get-list.zip"
  function_name    = "inventory_list_get_list"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "get-list.handler"
  source_code_hash = "${filebase64sha256("${path.root}/${var.build_dir}/get-list.zip")}"
  runtime          = "nodejs8.10"
  tags = {
    Project = "inventory_tracker"
  }
}

resource "aws_lambda_function" "post_list" {
  filename         = "${path.root}/${var.build_dir}/post-list.zip"
  function_name    = "inventory_list_post_list"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "post-list.handler"
  source_code_hash = "${filebase64sha256("${path.root}/${var.build_dir}/post-list.zip")}"
  runtime          = "nodejs8.10"
  tags = {
    Project = "inventory_tracker"
  }
}

resource "aws_lambda_function" "put_list" {
  filename         = "${path.root}/${var.build_dir}/put-list.zip"
  function_name    = "inventory_list_put_list"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "put-list.handler"
  source_code_hash = "${filebase64sha256("${path.root}/${var.build_dir}/put-list.zip")}"
  runtime          = "nodejs8.10"
  tags = {
    Project = "inventory_tracker"
  }
}

resource "aws_lambda_function" "delete_list" {
  filename         = "${path.root}/${var.build_dir}/delete-list.zip"
  function_name    = "inventory_list_delete_list"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "delete-list.handler"
  source_code_hash = "${filebase64sha256("${path.root}/${var.build_dir}/delete-list.zip")}"
  runtime          = "nodejs8.10"
  tags = {
    Project = "inventory_tracker"
  }
}

# todo: replace stub with report