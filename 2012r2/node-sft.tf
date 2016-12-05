variable "role" {
  type = "string"
}

variable "userdata" {
  type    = "list"
  default = ["<powershell>Write-Output 'No userdata set'</powershell>"]
}

data "template_file" "userdata" {
  template = "<powershell>\n$ErrorActionPreference = \"Stop\"\n$ErrorView = \"CategoryView\"\n\n${join("\n\n", var.userdata)}\n</powershell>\n"
}

resource "aws_instance" "demo-2012r2-sft" {
  count                  = "1"
  ami                    = "ami-1712d877"                            // Microsoft Windows Server 2012 R2 Base - ami-1712d877
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  source_dest_check      = false
  user_data              = "${data.template_file.userdata.rendered}"
  key_name               = "demo-2012r2-sft-deployer-key"

  tags = {
    Name = "aws-demo-${var.role}"
  }

  lifecycle {
    ignore_changes = ["user_data"]
  }
}

output "public_ip" {
  value = "${aws_instance.demo-2012r2-sft.public_ip}"
}

output "private_ip" {
  value = "${aws_instance.demo-2012r2-sft.private_ip}"
}

output "id" {
  value = "${aws_instance.demo-2012r2-sft.id}"
}
