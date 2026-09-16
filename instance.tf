resource "aws_instance" "example" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = var.instance_name
  }
  user_data = file("${path.module}/script.sh")

}