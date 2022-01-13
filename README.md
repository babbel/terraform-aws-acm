# AWS Certificate Manager (ACM) Terraform module creating and validating an ACM certificate

Terraform module which creates a ACM certificate in one region and validates it using Route53 DNS.

This is a simplified version of the [`terraform-aws-modules/acm/aws`](https://registry.terraform.io/modules/terraform-aws-modules/acm/aws) module which is waiting before returning certificate ARN as the `this_acm_certificate_arn` output until the validation is completed (returning `aws_acm_certificate_validation#certificate_arn` instead of `aws_acm_certificate#arn`). This is necessary for a seamless `terraform apply` incl. the resources using that certificate.

## Usage

```tf
module "acm" {
  source  = "babbel/acm/aws"
  version = "~> 1.0"

  primary_domain_name = "example.com"

  domain_names_to_zone_ids = {
    "example.com"     = "XYZXYZXYZXYZXYZ"
    "www.example.com" = "YZXYZXYZXYZXYZX"
  }

  tags = {
    app  = "some-service"
    env  = "production"
  }
}
```
