resource "aws_iam_role" "lambda_role" {
  name = "inventory_tracker_lambda_role"
  assume_role_policy = "${data.template_file.lambda_iam.rendered}"
  tags = {
    Project = "inventory_tracker"
  }
}

# resource "aws_iam_policy" "lambda_policy" {
#   name = ""
#   policy = "todo" #todo
# }

# resource "aws_iam_role_policy_attachment" "attach_role_to_policy" {
#   role = "${aws_iam_role.lambda_role.name}"
#   policy_arn = "${aws_iam_policy.lambda_policy.arn}"
# }

resource "aws_lambda_function" "stub_lambda" {
  filename         = "${data.archive_file.lambda_zip.output_path}"
  function_name    = "inventory_list_stub"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "stub.stub"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "nodejs8.10"
  tags = {
    Project = "inventory_tracker"
  }
}