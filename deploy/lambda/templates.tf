data "archive_file" "lambda_zip" {
    type        = "zip"
    source_file  = "${path.root}/${var.src_dir}/stub.js"
    output_path = "${path.root}/${var.build_dir}/stub.zip"
}

data "template_file" "lambda_iam" {
   template = "${file("${path.module}/lambda-iam.json")}"
   vars = {
       table_arn = "${var.table_arn}"
   }
}