# Declaring the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAQKX7OL4VGQYGMTVH"
  secret_key = "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"

}

resource "aws_instance" "Sonarqube" {
  ami                    = "ami-0557a15b87f6559cf" # free tier AMI image
  instance_type          = "t2.medium"
  user_data              = file("sonar_script.sh")
  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name               = "infrasonar" # Existing ssh key

  tags = {
    Name = "Sonarqube_Instance"
  }
}

data "aws_route53_zone" "selected" {
  name         = "sonarqubeljc.link"
  private_zone = false
}

resource "aws_route53_record" "domainName" {
  name    = "sonar"
  type    = "A"
  zone_id = data.aws_route53_zone.selected.zone_id
  records = [aws_instance.Sonarqube.public_ip]
  ttl     = 300
  depends_on = [
    aws_instance.Sonarqube
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "infrasonar"
  public_key = file("C:/users/lucio/.ssh/infrasonar.pub")
}