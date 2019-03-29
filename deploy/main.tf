provider "aws" {
  region                  = "eu-west-1"
  shared_credentials_file = "${path.root}/secrets/aws/credentials"
  profile                 = "default"
  version = "2.3"
}

provider archive {
  version = "1.2"
}

provider template {
  version = "2.1"
}

module "api-gateway" {
  source = "./api-gateway"
  build_dir = "${var.build_dir}"
  src_dir = "${var.src_dir}"
  api_spec = "${var.api_spec}"
}