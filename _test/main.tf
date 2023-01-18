provider "aws" {
  region = "local"
}

module "acm" {
  source = "./.."

  primary_domain_name = "example.com"

  domain_names_to_zone_ids = {
    "example.com"     = "XYZXYZXYZXYZXYZ"
    "www.example.com" = "YZXYZXYZXYZXYZX"
  }

  tags = {
    app = "some-service"
    env = "production"
  }
}
