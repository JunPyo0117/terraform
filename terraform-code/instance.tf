# AWS, Master 인스턴스 생성
resource "aws_instance" "test-ec2" {
  ami           = "ami-04341a215040f91bb" # ubuntu 20.04 (64bit, x86)
  instance_type = "t2.xlarge"
  key_name      = "AJP-KEY"

  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }

#  vpc_security_group_ids = [aws_security_group.example-sg.id]  # 기존 VPC 보안 그룹의 ID를 직접 지정
  #subnet_id = aws_subnet.public-subnet-2a.id

  network_interface {
    network_interface_id = aws_network_interface.my_master_net.id
    device_index         = 0
  }

  tags = {
    Name = "Master"
  }
}

# AWS, Worker 인스턴스 3대 생성
resource "aws_instance" "worker1-ec2" {
  ami           = "ami-04341a215040f91bb" # ubuntu 20.04 (64bit, x86)
  instance_type = "t2.xlarge"
  key_name      = "AJP-KEY"

  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }

#  vpc_security_group_ids = [aws_security_group.example2-sg.id]  # 기존 VPC 보안 그룹의 ID를 직접 지정
  #subnet_id = aws_subnet.public-subnet-2a.id

  network_interface {
    network_interface_id = aws_network_interface.my_worker01_net.id
    device_index         = 0
  }

  tags = {
    Name = "Worker1"
  }
}

resource "aws_instance" "workder2-ec2" {
  ami           = "ami-04341a215040f91bb" # ubuntu 20.04 (64bit, x86)
  instance_type = "t2.xlarge"
  key_name      = "AJP-KEY"

  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }

#  vpc_security_group_ids = [aws_security_group.example2-sg.id]  # 기존 VPC 보안 그룹의 ID를 직접 지정
  #subnet_id = aws_subnet.public-subnet-2a.id

  network_interface {
    network_interface_id = aws_network_interface.my_worker02_net.id
    device_index         = 0
  }

  tags = {
    Name = "Worker2"
  }
}

resource "aws_instance" "worker3-ec2" {
  ami           = "ami-04341a215040f91bb" # ubuntu 20.04 (64bit, x86)
  instance_type = "t2.xlarge"
  key_name      = "AJP-KEY"

  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }

#  vpc_security_group_ids = [aws_security_group.example2-sg.id]  # 기존 VPC 보안 그룹의 ID를 직접 지정
  #subnet_id = aws_subnet.public-subnet-2a.id

  network_interface {
    network_interface_id = aws_network_interface.my_worker03_net.id
    device_index         = 0
  }

  tags = {
    Name = "Worker3"
  }
}

# AWS, Worker 인스턴스 3대 생성
resource "aws_instance" "nfs-ec2" {
  ami           = "ami-04341a215040f91bb" # ubuntu 20.04 (64bit, x86)
  instance_type = "t2.micro"
  key_name      = "AJP-KEY"

  root_block_device {
    volume_type = "gp2"
    volume_size = 50
  }

#  vpc_security_group_ids = [aws_security_group.example3-sg.id]  # 기존 VPC 보안 그룹의 ID를 직접 지정
  #subnet_id = aws_subnet.public-subnet-2a.id

  network_interface {
    network_interface_id = aws_network_interface.my_nfs_net.id
    device_index         = 0
  }

  tags = {
    Name = "NFS"
  }
}
