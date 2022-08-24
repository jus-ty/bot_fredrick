resource "aws_instance" "bastion_instance" {
  ami                       = var.instance_ami
  instance_type             = "t2.micro"
  subnet_id                 = var.public_subnet_id
  vpc_security_group_ids    = [var.security_group_id]
  key_name                  = "bot_fredrick_kp"
  tags                      = var.bastion_tags
}

resource "aws_instance" "private_instance" {
  ami                       = var.instance_ami
  instance_type             = "t2.micro"
  subnet_id                 = var.private_subnet_id
  vpc_security_group_ids    = [var.security_group_id]
  key_name                  = "bot_fredrick_kp"
  tags                      = var.private_instance_tags
}