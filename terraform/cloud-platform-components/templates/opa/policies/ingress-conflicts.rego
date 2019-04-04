package kubernetes.admission
deny[msg] {
    input.request.kind.kind == "Ingress"
    newhost := input.request.object.spec.rules[_].host
    oldhost := data.kubernetes.ingresses[namespace][name].spec.rules[_].host
    newhost == oldhost
    msg := sprintf("ingress host conflicts with ingress %v/%v", [namespace, name])
}