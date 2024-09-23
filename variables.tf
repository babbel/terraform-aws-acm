variable "domain_names_to_zone_ids" {
  type = map(string)

  description = <<EOS
Map of domain names (incl. `var.primary_domain_name`) to Route53 hosted zone IDs.
EOS
}

variable "primary_domain_name" {
  type = string

  description = <<EOS
A domain name for which the certificate should be issued.
EOS
}

variable "tags" {
  type    = map(string)
  default = {}

  description = <<EOS
Map of tags assigned to all AWS resources created by this module.
EOS
}
