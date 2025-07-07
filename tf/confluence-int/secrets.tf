resource "kubernetes_secret" "confluence_db_secret" {
  metadata {
    name      = "confluence-db-secret"
    namespace = kubernetes_namespace.confluence_int.metadata[0].name
  }

  data = {
    username = base64encode(var.db_username)
    password = base64encode(var.db_password)
  }

  type = "Opaque"
}