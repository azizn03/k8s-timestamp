module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = "timestamp-cluster"
  cluster_version = "1.21"
  cluster_endpoint_private_access = true
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets


  eks_managed_node_group_defaults = {
    disk_size      = 50
    instance_types = ["t2.small"]
  }

  eks_managed_node_groups = {
      ec2_timestamp = {
      min_size     = 1
      max_size     = 5
      desired_size = 1

      instance_types = ["t2.small"]
      capacity_type  = "SPOT"
    }}

  }

  resource "kubernetes_deployment" "timestamp_deployment" {
  metadata {
    name = "timestamp-deployment"
    labels = {
      app = "timestamp-nodejsapp"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "timestamp-nodejsapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "timestamp-nodejsapp"
        }
      }

      spec {
        container {
          name  = "timestamp-nodejsapp"
          image = "azizn03/timestamp:latest"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "timestamp_loadbalancer" {
  metadata {
    name = "timestamp-loadbalancer"
  }

  spec {
    selector = {
      app = "timestamp-nodejsapp"
    }
    port {
      port        = 8080
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}