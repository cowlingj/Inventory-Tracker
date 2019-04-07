output "api_key" {
  value = "${aws_api_gateway_api_key.key.value}"
}

output "api" {
  value = "${data.template_file.api.rendered}"
}