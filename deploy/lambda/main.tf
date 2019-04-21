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

  environment = {
    variables = {
      LIST_TABLE_NAME = "${var.list_table_name}"
    }
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

  environment = {
    variables = {
      LIST_TABLE_NAME = "${var.list_table_name}"
    }
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

  environment = {
    variables = {
      LIST_TABLE_NAME = "${var.list_table_name}"
    }
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

  environment = {
    variables = {
      LIST_TABLE_NAME = "${var.list_table_name}"
    }
  }
}

resource "aws_lambda_function" "get_report" {
  filename         = "${path.root}/${var.build_dir}/get-report.zip"
  function_name    = "inventory_list_get_report"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "get-report.handler"
  source_code_hash = "${filebase64sha256("${path.root}/${var.build_dir}/get-report.zip")}"
  runtime          = "nodejs8.10"
  tags = {
    Project = "inventory_tracker"
  }
}