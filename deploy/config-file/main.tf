resource "local_file" "postman" {
  sensitive_content = "${data.template_file.postman_env.rendered}"
  filename = "${var.postman_dir}/secrets/environment_${terraform.workspace}.json"
}

resource "local_file" "client_config" {
  sensitive_content = "${data.template_file.client_config.rendered}"
  filename = "${var.build_dir}/secrets/list-client.json"
}