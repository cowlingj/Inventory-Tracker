data "template_file" "api" {
  template = "${file("${path.module}/api/api.yml")}"
  vars = {
    title = "${local.api_name}",
    description = "${local.api_description}",
    list_get_uri = "${var.lambda_arns["get_list"]}",
    list_get_item_uri = "${var.lambda_arns["get_list_item"]}",
    list_post_uri = "${var.lambda_arns["post_list"]}",
    list_put_uri = "${var.lambda_arns["put_list"]}",
    list_delete_uri = "${var.lambda_arns["delete_list"]}",
    report_get_uri = "${var.lambda_arns["get_report"]}"
  }
}