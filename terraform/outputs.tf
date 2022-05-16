output "cluster_endpoint" {
    description = "Endpoint for EKS control plane"
    value = module.eks.cluster_endpoint
}


output "eks_status" {
    description = "Outputs the status of the eks cluster"
    value = module.eks.cluster_status
}


output "timestamp_loadbalancer" {
    description = "Output the hostname of the loadbalancer"
    value = kubernetes_service.timestamp_loadbalancer.status.0.load_balancer.0.ingress.0.hostname



}

