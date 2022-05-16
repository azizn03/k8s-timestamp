variable "AWS_ACCESS_KEY_ID" {
    type = string
    default = ""
}

variable "AWS_SECRET_ACCESS_KEY" {
    type = string
    default = ""
}


data "aws_eks_cluster" "cluster" {
    name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
    name = module.eks.cluster_id
}

data "aws_availability_zones" "available" {
}
