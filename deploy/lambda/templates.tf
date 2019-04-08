data "archive_file" "lambda_zip" {
    type        = "zip"
    source_file  = "${path.root}/${var.src_dir}/stub.js"
    output_path = "${path.root}/${var.build_dir}/stub.zip"
}

data "template_file" "lambda_role_policy" {
   template = "${file("${path.module}/lambda-service-role.json")}"
   vars = {
       table_arn = "${var.table_arn}"
   }
}

data "template_file" "lambda_policy" {
   template = "${file("${path.module}/lambda-policy.json")}"
   vars = {
       table_arn = "${var.table_arn}"
   }
}