package kubernetes.admission

import data.kubernetes.namespaces

import input.request.object.metadata.annotations as annotations

deny[msg] {
    input.request.kind.kind = "Service"
    input.request.operation = "CREATE"
    input.request.object.spec.type = "LoadBalancer"
    missing_required_annotations[msg]
}

# Require use of Security Group sg-123
missing_required_annotations[msg] {
    not annotations["service.beta.kubernetes.io/aws-load-balancer-security-groups"] = "sg-123"
    msg = "Services of type LoadBalancer must use Security Group sg-123"
}