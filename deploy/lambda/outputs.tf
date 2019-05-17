output "lambda_arns" {
  value = {
    invoke_get_list = "${aws_lambda_function.get_list.invoke_arn}"
    invoke_put_list = "${aws_lambda_function.put_list.invoke_arn}"
    invoke_post_list = "${aws_lambda_function.post_list.invoke_arn}"
    invoke_delete_list = "${aws_lambda_function.delete_list.invoke_arn}"
    invoke_get_report = "${aws_lambda_function.get_report.invoke_arn}"
    get_list = "${aws_lambda_function.get_list.arn}"
    post_list = "${aws_lambda_function.post_list.arn}"
    put_list = "${aws_lambda_function.put_list.arn}"
    delete_list = "${aws_lambda_function.delete_list.arn}"
    get_report = "${aws_lambda_function.get_report.arn}"
  }
}

output "lambda_names" {
  value = {
    get_list = "${aws_lambda_function.get_list.function_name}"
    post_list = "${aws_lambda_function.post_list.function_name}"
    put_list = "${aws_lambda_function.put_list.function_name}"
    delete_list = "${aws_lambda_function.delete_list.function_name}"
    get_report = "${aws_lambda_function.get_report.function_name}"
  }
}