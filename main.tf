resource "aws_acm_certificate" "this" {
  domain_name               = var.primary_domain_name
  subject_alternative_names = setsubtract(keys(var.domain_names_to_zone_ids), [var.primary_domain_name])
  validation_method         = "DNS"

  tags = merge(var.default_tags, var.acm_certificate_tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = var.domain_names_to_zone_ids[each.key]
  name    = each.value.name
  type    = each.value.type
  ttl     = 60

  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn = aws_acm_certificate.this.arn

  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}
