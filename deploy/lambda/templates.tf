data "template_file" "lambda_role_policy" {
   template = "${file("${path.module}/lambda-service-role.json")}"
   vars = {
       table_arn = "${var.list_table_arn}"
   }
}

data "template_file" "lambda_policy" {
   template = "${file("${path.module}/lambda-policy.json")}"
   vars = {
       table_arn = "${var.list_table_arn}"
   }
}