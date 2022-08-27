resource "aws_instance" "bastion_instance" {
  ami                       = var.bastion_ami
  instance_type             = var.bastion_instance_type
  subnet_id                 = var.public_subnet_id
  vpc_security_group_ids    = [var.bastion_security_group_id]
  key_name                  = "bot_fredrick_kp"
  tags                      = var.bastion_tags
}

resource "aws_instance" "private_instance" {
  ami                       = var.private_instance_ami
  instance_type             = var.private_instance_type
  subnet_id                 = var.private_subnet_id
  vpc_security_group_ids    = [var.private_instance_security_group_id]
  key_name                  = "bot_fredrick_kp"
  tags                      = var.private_instance_tags
  user_data                 = "${data.template_file.private_instance_userdata_script.template}"
}

data "template_file" "private_instance_userdata_script" {
  template = file("${path.module}/templates/user-data.tpl")
}