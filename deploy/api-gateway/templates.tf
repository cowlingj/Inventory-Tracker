data "template_file" "api" {
  template = "${file("${path.root}/${var.api_spec}")}"
  vars = {
    list_get_uri = "${var.lambda_args["invoke_get_list"]}",
    list_post_uri = "${var.lambda_args["invoke_post_list"]}",
    list_put_uri = "${var.lambda_args["invoke_put_list"]}",
    list_delete_uri = "${var.lambda_args["invoke_delete_list"]}",
    report_get_uri = "${var.lambda_args["invoke_get_report"]}"
  }
}