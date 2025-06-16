resource "proxmox_virtual_environment_role" "csi-role" {
  role_id = "${var.cluster_name}-csi-tole"
  privileges = [
    "VM.Audit",
    "VM.Config.Disk",
    "Datastore.Allocate",
    "Datastore.AllocateSpace",
    "Datastore.Audit"
  ]
}

resource "proxmox_virtual_environment_user" "csi-user" {
  user_id = "${var.cluster_name}-csi-user@${var.proxmox.cluster_name}"
  comment = "User for Proxmox CSI Plugin"

  acl {
    path      = "/"
    propagate = true
    role_id   = proxmox_virtual_environment_role.csi-role.role_id
  }
}

resource "proxmox_virtual_environment_user_token" "proxmox-csi-user-token" {
  comment               = "Token for Proxmox CSI Plugin"
  token_name            = "csi"
  user_id               = proxmox_virtual_environment_user.csi-user.user_id
  privileges_separation = false
}

resource "kubernetes_namespace" "proxmox-csi-namespace" {
  depends_on = [kubernetes_namespace.flux_system]
  metadata {
    name = "csi-proxmox"
    labels = {
      "pod-security.kubernetes.io/enforce" = "privileged"
      "pod-security.kubernetes.io/audit"   = "baseline"
      "pod-security.kubernetes.io/warn"    = "baseline"
    }
  }
}

resource "kubernetes_secret" "proxmox-csi-plugin-secret" {
  metadata {
    name      = "proxmox-csi-plugin"
    namespace = kubernetes_namespace.proxmox-csi-namespace.id
  }

  data = {
    "config.yaml" = <<EOF
clusters:
- url: "${var.proxmox.endpoint}/api2/json"
  insecure: true
  token_id: "${proxmox_virtual_environment_user_token.proxmox-csi-user-token.id}"
  token_secret: "${element(split("=", proxmox_virtual_environment_user_token.proxmox-csi-user-token.value), length(split("=", proxmox_virtual_environment_user_token.proxmox-csi-user-token.value)) - 1)}"
  region: ${var.proxmox.cluster_name}
EOF
  }
}
