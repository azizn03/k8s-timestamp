output "cluster_endpoint" {
    description = "Endpoint for EKS control plane"
    value = module.eks.cluster_endpoint
}

/* output "cluster_security_group_id" {
    description = "Security group ids attached to the cluster"
    value = module.eks.cluster_security_group_id
} */

output "eks_status" {
    description = "Outputs the status of the eks cluster"
    value = module.eks.cluster_status
}


output "timestamp_loadbalancer" {
    description = "Security group ids attached to the cluster"
    value = kubernetes_service.timestamp_loadbalancer.status.0.load_balancer.0.ingress.0.hostname
}

