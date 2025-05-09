resource "aws_eks_node_group" "node_dp010" {
  cluster_name    = data.aws_eks_cluster.existing_cluster.name
  node_group_name = "Nodedp010"
  node_role_arn = "arn:aws:iam::325583868777:role/role-for-eksDeepDiveFrankfurt-eks-cluster"

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3.small"]

  subnet_ids = data.aws_subnets.existing_subnets.ids

  tags = {
    Name = "Nodedp010"
  }
}

