module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name                 = "eks_vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names 
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets       = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

}

resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_Worker_management"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
  }

}

