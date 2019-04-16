resource "aws_dynamodb_table" "inventory-list-store" {
  name = "inventory-list-store-${terraform.workspace}"
  read_capacity = 1
  write_capacity = 1
  hash_key = "id"
  range_key = "name"
  tags = {
    Project = "inventory_tracker"
  }

  attribute {
    name = "id"
    type = "N"
  }

  attribute {
    name = "name"
    type = "S"
  }

  local_secondary_index {
    name = "name-index"
    range_key = "name"
    projection_type = "ALL"
  }
}

# TODO: report table
