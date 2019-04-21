resource "aws_dynamodb_table" "inventory-list-store" {
  name = "inventory-list-store-${terraform.workspace}"
  read_capacity = 1
  write_capacity = 1
  hash_key = "id"
  tags = {
    Project = "inventory_tracker"
  }

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "name"
    type = "S"
  }

  global_secondary_index {
    name = "name-index"
    hash_key = "id"
    range_key = "name"
    projection_type = "ALL"
    read_capacity = 1
    write_capacity = 1
  }
}

# TODO: report table
