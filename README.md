# Terraform
IaC - Infrastructure as Code  
- 수동 프로세스가 아닌 코드를 통해 인프라를 관리하고 프로비저닝하는 것   
- 작성용이성, 재사용성, 유지보수 등의 장점을 가짐  

테라폼은 인프라를 생성, 변경, 기록하는 IaC를 위해 만들어진 도구로, `.tf` 파일 형식을 가짐  

## Terraform 구성요소
- provider: 생성할 인프라 종류
- resource: 실제로 생성할 인프라 자원
- state: 생성한 자원의 상태
- output: 자원을 변수 형태로 state에 저장
- module: 공통적으로 활용할 수 있는 코드를 문자 그대로 모듈 형태로 정의
- remote: 다른 경로의 state를 참조 output 변수를 불러올때 주로 사용

### provider
provider 안에서 다양한 Arguments를 가짐  
key를 직접 올리는 것 보단 aws cli등에 로그인 후 사용 권장  
```tf
provider "aws" {
  #access_key = "AWS ACCESS KEY"
  #secret_key = "AWS SECRET KEY" 
  region = "ap-northeast-2"  # 원하는 리전으로 변경
}
```

### resource
테라폼으로 VPC를 생성하는 코드  
```tf
# AWS, vpc 설정
resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/20"
}
```

### state
테라폼으로 작성한 코드를 실행하게 되면 생성되는 파일  
생성한 리소스의 결과값으로 인프라의 실제 상태를 뜻하지 않음  
state 파일과 현재 인프라의 상태를 동일하게 유지하는 것이 핵심  
state는 원격 저장소인 'backend'에도 저장될 수 있음  
```

```

### output
생성한 리소스 값들을 참조하여 변수를 state파일로 저장  
remote를 사용하여 재사용 가능  
```tf
# AWS, vpc 설정
resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/20"
}

output "vpc_id" {
  value = aws_vpc.terraform-vpc.id
}

output "cidr_block" {
  value = aws_vpc.terraform-vpc.cidr_block
}
```

### module
module은 한 번 만들어진 테라폼 코드로 같은 형태를 반복적으로 만들어낼때 주로 사용   
```tf
# AWS, vpc 설정
module "vpc" {
  source = "../_modules/vpc"
  cidr_block = "10.0.0.0/20"
}
```

### remote
remote는 원격 참조 개념
remote state는 key 값에 명시한 state에서 변수를 가져옴
```tf
data "terraform-remote-state" "vpc" {
   backend = "remote"

   config = {
     bucket    = "terraform-s3-bucket"
     region    = "ap-northeast-2"
     key       = "terraform-/vpc/terraform.tfstate"
   }
}
```

## Terraform 기본 명령어
- init: 테라폼 명령어 사용을 위해 설정 진행
- plan: 테라폼으로 작성한 코드가 실제 어떻게 ㅁ나들어질지에 대한 예측 결과 보여줌, 문제가 없다해서 apply가 성공한다는 보장은 없음
- apply: 테라폼 코드로 실제 인프라 생성
- import: 이미 만들어진 자원을 테라폼 state 파일로 옮겨줌
- state: 테라폼 state를 다루는 명령어
- destroy: 생성된 자원을 모두 삭제

  

