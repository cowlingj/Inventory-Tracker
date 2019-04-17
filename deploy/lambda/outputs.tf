output "lambda_arns" {
  value = {
    invoke_get_list = "${aws_lambda_function.get_list.invoke_arn}"
    invoke_put_list = "${aws_lambda_function.put_list.invoke_arn}"
    invoke_post_list = "${aws_lambda_function.post_list.invoke_arn}"
    invoke_delete_list = "${aws_lambda_function.delete_list.invoke_arn}"
    invoke_get_report = "${aws_lambda_function.stub_lambda.invoke_arn}"
  }
}