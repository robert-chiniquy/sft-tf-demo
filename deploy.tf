variable "secret_key" {}

variable "access_key" {}

provider "aws" {
  region     = "us-west-2"
  secret_key = "${var.secret_key}"
  access_key = "${var.access_key}"
}

variable "aws_key_path" {
  default     = "~/.ssh/aws-demo-rsa.pub"
  description = "Used to decrypt administrator passwords in the AWS console should you also want to use vanilla RDP"
}

resource "aws_key_pair" "sftwindeployer" {
  key_name   = "demo-2012r2-sft-deployer-key"
  public_key = "${file("${var.aws_key_path}")}"
}

data "template_file" "sftd-init-solo" {
  template = "${file("${path.module}/install-sftd.ps1")}"

  vars {
    altname = "solo-sft-win"
  }
}

module "2012r2-sft-cloud-account-enroll" {
  source   = "./2012r2"
  role     = "cloud-account-enroll"
  userdata = ["${data.template_file.sftd-init-solo.rendered}"]
}
