data "template_file" "values" {
  template = "${file("${path.module}/templates/opa/values.yaml.tpl")}"

  vars {
    # concourse_image_tag       = "${var.concourse_image_tag}"
    # basic_auth_username       = "${random_string.basic_auth_username.result}"
    # basic_auth_password       = "${random_string.basic_auth_password.result}"
    # github_auth_client_id     = "${local.secrets["github_auth_client_id"]}"
    # github_auth_client_secret = "${local.secrets["github_auth_client_secret"]}"
    # concourse_hostname        = "concourse.apps.${data.terraform_remote_state.cluster.cluster_domain_name}"
    # github_org                = "${local.secrets["github_org"]}"
    # github_teams              = "${local.secrets["github_teams"]}"
    # postgresql_user           = "${aws_db_instance.concourse.username}"
    # postgresql_password       = "${aws_db_instance.concourse.password}"
    # postgresql_host           = "${aws_db_instance.concourse.address}"
    # postgresql_sslmode        = false
    # host_key_priv             = "${indent(4, tls_private_key.host_key.private_key_pem)}"
    # host_key_pub              = "${tls_private_key.host_key.public_key_openssh}"
    # session_signing_key_priv  = "${indent(4, tls_private_key.session_signing_key.private_key_pem)}"
    # worker_key_priv           = "${indent(4, tls_private_key.worker_key.private_key_pem)}"
    # worker_key_pub            = "${tls_private_key.worker_key.public_key_openssh}"
  }
}


resource "helm_release" "open-policy-agent" {
  name          = "opa"
  namespace     = "opa"
  repository    = "stable"
  chart         = "opa"
  version       = "1.3.2"
  recreate_pods = true

  values = [
    "${data.template_file.values.rendered}",
  ]

  lifecycle {
    ignore_changes = ["keyring"]
  }
}