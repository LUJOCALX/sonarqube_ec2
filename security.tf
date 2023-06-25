resource "aws_security_group" "ec2" {
  name        = "allow_sonar"
  description = "Allow sonar outbound traffic and ssh"
  ingress = [
    {
      description      = "Allow sonar outbound traffic"
      cidr_blocks      = ["0.0.0.0/0"]
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
    {
      description      = "Allow ssh outbound traffic"
      cidr_blocks      = ["0.0.0.0/0"]
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    }
  ]
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_sonar"
  }
}

