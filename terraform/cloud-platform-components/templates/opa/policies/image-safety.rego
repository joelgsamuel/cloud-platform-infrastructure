package kubernetes.admission
deny[msg] {
    input.request.kind.kind == "Pod"
    image := input.request.object.spec.containers[_].image
    not startswith(image, "hooli.com")
    msg := sprintf("image fails to come from trusted registry: %v", [image])
}