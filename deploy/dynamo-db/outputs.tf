output "table_arn" {
  value = "${aws_dynamodb_table.inventory-list-store.arn}"
}

# todo: report arn