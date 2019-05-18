resource "aws_iam_role" "lambda_role" {
  name = "inventory_tracker_lambda_role-${terraform.workspace}"
  assume_role_policy = "${data.template_file.lambda_role_policy.rendered}"
  tags = {
    Project = "inventory_tracker"
    Version = "${terraform.workspace}"
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name = "inventory_tracker_service_policy-${terraform.workspace}"
  policy = "${data.template_file.lambda_policy.rendered}"
}

resource "aws_iam_role_policy_attachment" "attach_role_to_policy" {
  role = "${aws_iam_role.lambda_role.name}"
  policy_arn = "${aws_iam_policy.lambda_policy.arn}"
}

resource "aws_lambda_function" "get_list_item" {
  filename         = "${path.root}/${var.build_dir}/get-list-item.zip"
  function_name    = "inventory_list_get_list_item-${terraform.workspace}"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "get-list-item.handler"
  source_code_hash = "${filebase64sha256("${path.root}/${var.build_dir}/get-list-item.zip")}"
  runtime          = "nodejs8.10"
  tags = {
    Project = "inventory_tracker"
    Version = "${terraform.workspace}"
  }

  environment = {
    variables = {
      LIST_TABLE_NAME = "${var.list_table_name}"
    }
  }
}

resource "aws_lambda_function" "get_list" {
  filename         = "${path.root}/${var.build_dir}/get-list.zip"
  function_name    = "inventory_list_get_list-${terraform.workspace}"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "get-list.handler"
  source_code_hash = "${filebase64sha256("${path.root}/${var.build_dir}/get-list.zip")}"
  runtime          = "nodejs8.10"
  tags = {
    Project = "inventory_tracker"
    Version = "${terraform.workspace}"
  }

  environment = {
    variables = {
      LIST_TABLE_NAME = "${var.list_table_name}"
    }
  }
}

resource "aws_lambda_function" "post_list" {
  filename         = "${path.root}/${var.build_dir}/post-list.zip"
  function_name    = "inventory_list_post_list-${terraform.workspace}"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "post-list.handler"
  source_code_hash = "${filebase64sha256("${path.root}/${var.build_dir}/post-list.zip")}"
  runtime          = "nodejs8.10"
  tags = {
    Project = "inventory_tracker"
    Version = "${terraform.workspace}"
  }

  environment = {
    variables = {
      LIST_TABLE_NAME = "${var.list_table_name}"
    }
  }
}

resource "aws_lambda_function" "put_list" {
  filename         = "${path.root}/${var.build_dir}/put-list.zip"
  function_name    = "inventory_list_put_list-${terraform.workspace}"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "put-list.handler"
  source_code_hash = "${filebase64sha256("${path.root}/${var.build_dir}/put-list.zip")}"
  runtime          = "nodejs8.10"
  tags = {
    Project = "inventory_tracker"
    Version = "${terraform.workspace}"
  }

  environment = {
    variables = {
      LIST_TABLE_NAME = "${var.list_table_name}"
    }
  }
}

resource "aws_lambda_function" "delete_list" {
  filename         = "${path.root}/${var.build_dir}/delete-list.zip"
  function_name    = "inventory_list_delete_list-${terraform.workspace}"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "delete-list.handler"
  source_code_hash = "${filebase64sha256("${path.root}/${var.build_dir}/delete-list.zip")}"
  runtime          = "nodejs8.10"
  tags = {
    Project = "inventory_tracker"
    Version = "${terraform.workspace}"
  }

  environment = {
    variables = {
      LIST_TABLE_NAME = "${var.list_table_name}"
    }
  }
}

resource "aws_lambda_function" "get_report" {
  filename         = "${path.root}/${var.build_dir}/get-report.zip"
  function_name    = "inventory_list_get_report-${terraform.workspace}"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "get-report.handler"
  source_code_hash = "${filebase64sha256("${path.root}/${var.build_dir}/get-report.zip")}"
  runtime          = "nodejs8.10"
  tags = {
    Project = "inventory_tracker"
    Version = "${terraform.workspace}"
  }
}