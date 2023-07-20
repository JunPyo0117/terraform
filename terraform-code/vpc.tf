# AWS, vpc 설정
resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/20"

  tags = {
    Name = "apj-terraform-test-vpc"
  }
}

# AWS, vpc 서브넷 설정
resource "aws_subnet" "public-subnet-2a" {
  vpc_id = "${aws_vpc.terraform-vpc.id}"
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true # 해당 서브넷 선택 인스턴스는 퍼블릭 IP 주소 할당
  tags = {
    Name = "public-subnet-az-2a"
  }
}

resource "aws_subnet" "private-subnet-2c" {
  vpc_id = "${aws_vpc.terraform-vpc.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "private-subnet-az-2c"
  }
}

# Internet Gateway(IGW) 생성
resource "aws_internet_gateway" "apj-test-igw" {
    vpc_id = aws_vpc.terraform-vpc.id
    tags = {
      Name = "apj-test-igw"
    }
}

# IGW로 전체 트래픽이 가도록 Default Routing Table CIDR 수정 및 명시적 서브넷 설정
# Default Routing table ID 획득
locals {
  default_route_table_id = aws_vpc.terraform-vpc.default_route_table_id
}
# Default Routing table의 Route 설정 추가
resource "aws_route" "default-rt-to-igw" {
  route_table_id = local.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.apj-test-igw.id
}
# 명시적 서브넷 설정
resource "aws_route_table_association" "pubilc-subnet-a" {
  subnet_id = aws_subnet.public-subnet-2a.id
  route_table_id = local.default_route_table_id
}

# Network Interface 리소스 생성
resource "aws_network_interface" "my_master_net" {
  subnet_id   = aws_subnet.public-subnet-2a.id
  security_groups = [aws_security_group.example-sg.id]
  private_ips = ["10.0.0.20"]
  tags = {
    Name = "private_network_interface-master-01"
  }
}

resource "aws_network_interface" "my_worker01_net" {
  subnet_id   = aws_subnet.public-subnet-2a.id
  security_groups = [aws_security_group.example2-sg.id]
  private_ips = ["10.0.0.21"]
  tags = {
    Name = "private_network_interface-worker-01"
  }
}

resource "aws_network_interface" "my_worker02_net" {
  subnet_id   = aws_subnet.public-subnet-2a.id
  security_groups = [aws_security_group.example2-sg.id]
  private_ips = ["10.0.0.22"]
  tags = {
    Name = "private_network_interface-worker-02"
  }
}

resource "aws_network_interface" "my_worker03_net" {
  subnet_id   = aws_subnet.public-subnet-2a.id
  security_groups = [aws_security_group.example2-sg.id]
  private_ips = ["10.0.0.23"]
  tags = {
    Name = "private_network_interface-worker-03"
  }
}

resource "aws_network_interface" "my_nfs_net" {
  subnet_id   = aws_subnet.public-subnet-2a.id
  security_groups = [aws_security_group.example3-sg.id]
  private_ips = ["10.0.0.24"]
  tags = {
    Name = "private_network_interface-NFS"
  }
}
