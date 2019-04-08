output "lambda_arns" {
  value = {
    invoke_get_list = "${aws_lambda_function.stub_lambda.invoke_arn}"
    invoke_put_list = "${aws_lambda_function.stub_lambda.invoke_arn}"
    invoke_post_list = "${aws_lambda_function.stub_lambda.invoke_arn}"
    invoke_delete_list = "${aws_lambda_function.stub_lambda.invoke_arn}"
    invoke_get_report = "${aws_lambda_function.stub_lambda.invoke_arn}"
  }
}
