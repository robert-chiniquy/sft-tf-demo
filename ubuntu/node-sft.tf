variable "userdata" {
  type    = "string"
  default = "echo 'No userdara supplied'"
}

variable "tagname" {
  type = "string"
  default = "ubuntu-node"
}

resource "aws_instance" "node" {
  count                  = 1
  ami                    = "ami-a9d276c9"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  source_dest_check      = false
  user_data              = "${var.userdata}"

  tags = {
    Name = "${var.tagname}-${count.index}"
  }

  lifecycle {
    ignore_changes = ["user_data"]
  }
}

output "public_ip" {
  value = "${aws_instance.node.public_ip}"
}

output "private_ip" {
  value = "${aws_instance.node.private_ip}"
}

output "id" {
  value = "${aws_instance.node.id}"
}
