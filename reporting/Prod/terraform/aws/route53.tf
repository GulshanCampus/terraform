data "aws_route53_zone" "myastutesolutions" {
  name = "myastutesolutions.com."
}


resource "aws_route53_record" "tableau2020" {
  zone_id = data.aws_route53_zone.myastutesolutions.zone_id
  name    = "tableau2020.myastutesolutions.com"
  type    = "A"

  alias {
    name                   = aws_lb.tableau-production.dns_name
    zone_id                = aws_lb.tableau-production.zone_id
    evaluate_target_health = false
  }
}