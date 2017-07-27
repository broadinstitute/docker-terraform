resource "aws_instance" "instance" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  user_data = "${data.template_file.template_file.rendered}"
  security_groups = ["${aws_security_group.security_group.name}"]
  associate_public_ip_address = true
  tags {
    Name = "${var.name}"
  }
}

data "template_file" "template_file" {
  template = "${file("${path.module}/user_data.sh")}"
}

resource "aws_security_group" "security_group" {
  tags {
    Name = "instance_sg"
  }
}

resource "aws_security_group_rule" "allow_inbound_http" {
  security_group_id = "${aws_security_group.security_group.id}"
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_outgoing_all" {
  security_group_id = "${aws_security_group.security_group.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

output "public_dns" {
  value = "${aws_instance.instance.public_dns}"
}
