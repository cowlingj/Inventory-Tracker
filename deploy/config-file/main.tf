resource "local_file" "postman" {
  sensitive_content = "${data.template_file.postman_env.rendered}"
  filename = "${var.postman_dir}/secrets/environment_${terraform.workspace}.json"
}

resource "local_file" "api" {
  sensitive_content = "${var.api}"
  filename = "${var.clients_dir}/generated/api_${terraform.workspace}.yml"
}