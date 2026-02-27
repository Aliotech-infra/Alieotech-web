data "aws_ami" "centos9" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["CentOS-Stream-9-*"]
  }
}

resource "aws_instance" "centos9_instances" {
  for_each = var.instances

  ami           = data.aws_ami.centos9.id
  instance_type = each.value
  key_name      = var.key_name

  associate_public_ip_address = true

  tags = {
    Name = each.key
  }
}

output "public_ips" {
  value = {for k, v in aws_instance.centos9_instances : k => v.public_ip}
}