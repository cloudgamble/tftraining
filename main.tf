#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-d651b8ac
#
# Your subnet ID is:
#
#     subnet-a2a469e9
#
# Your security group ID is:
#
#     sg-2788a154
#
# Your Identity is:
#
#     NWI-vault-trout
#

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

variable "count" {
  default = 2
}

resource "aws_instance" "web" {
  # ami
  ami                    = "ami-d651b8ac"
  subnet_id              = "subnet-a2a469e9"
  vpc_security_group_ids = ["sg-2788a154"]
  instance_type          = "t2.micro"
  count                  = "${var.count}"

  tags {
    "Name"     = "${format("web-%03d", count.index + 1)}"
    "Identity" = "NWI-vault-trout"
    "user"     = "john"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
