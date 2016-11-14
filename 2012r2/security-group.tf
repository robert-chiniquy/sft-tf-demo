resource "aws_security_group" "default" {
  description = "Minimum functional ACLs for a ScaleFT Windows node"

  tags {
    Name = "DEMO-2012r2-sft"
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # WinRM
  ingress {
    from_port   = 5985
    to_port     = 5985
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ScaleFT
  ingress {
    from_port   = 4421
    to_port     = 4421
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # RDP - Can remove this if going 100% ScaleFT-managed
  # ingress {
  #   from_port   = 3389
  #   to_port     = 3389
  #   protocol    = "TCP"
  #   cidr_blocks = [""] # Your office/home subnets here
  # }

  # NTP
  egress {
    from_port   = 123
    to_port     = 123
    protocol    = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # DNS
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
