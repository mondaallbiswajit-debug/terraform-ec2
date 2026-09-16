//step 1: allocate an Elastic ip in the vpc

resource "aws_eip" "elastic_ip" {
  domain = "vpc"

  tags = {
    Name = "${var.instance_name}-eip"
  }
}

//step 2: assign the allocated ip to the instance

resource "aws_eip_association" "elastic_ip" {
  instance_id   = aws_instance.example.id
  allocation_id = aws_eip.elastic_ip.id
}
