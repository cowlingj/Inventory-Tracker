output "lambda_arns" {
  value = {
    get_list = "${aws_lambda_function.get_list.invoke_arn}"
    get_list_item = "${aws_lambda_function.get_list_item.invoke_arn}"
    put_list = "${aws_lambda_function.put_list.invoke_arn}"
    post_list = "${aws_lambda_function.post_list.invoke_arn}"
    delete_list = "${aws_lambda_function.delete_list.invoke_arn}"
    get_report = "${aws_lambda_function.get_report.invoke_arn}"
  }
}

output "lambda_names" {
  value = {
    get_list = "${aws_lambda_function.get_list.function_name}"
    get_list_item = "${aws_lambda_function.get_list_item.function_name}"
    post_list = "${aws_lambda_function.post_list.function_name}"
    put_list = "${aws_lambda_function.put_list.function_name}"
    delete_list = "${aws_lambda_function.delete_list.function_name}"
    get_report = "${aws_lambda_function.get_report.function_name}"
  }
}