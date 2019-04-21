output "list_table_arn" {
  value = "${aws_dynamodb_table.inventory-list-store.arn}"
}

output "list_table_name" {
  value = "${aws_dynamodb_table.inventory-list-store.name}"
}