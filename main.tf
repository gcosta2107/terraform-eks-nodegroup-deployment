provider "aws" {
  region = "eu-central-1"
}

data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Name"
    values = ["myvpc-cdcp"]
  }
}

data "aws_subnets" "existing_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]
  }
}

data "aws_security_group" "existing_sg" {
  filter {
    name   = "group-name"
    values = ["eks-cluster-sg-eksDeepDiveFrankfurt-1978535350"]
  }
}

data "aws_eks_cluster" "existing_cluster" {
  name = "eksDeepDiveFrankfurt"
}

data "aws_eks_cluster_auth" "existing_cluster_auth" {
  name = data.aws_eks_cluster.existing_cluster.name
}