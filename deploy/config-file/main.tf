resource "local_file" "postman" {
  sensitive_content = "${data.template_file.postman_env.rendered}"
  filename = "${var.postman_dir}/secrets/environment_${terraform.workspace}.json"
}