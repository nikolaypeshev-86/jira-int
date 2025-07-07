resource "kubernetes_secret" "jira_db_secret" {
  metadata {
    name      = "jira-db-secret"
    namespace = kubernetes_namespace.jira_prod.metadata[0].name
  }

  data = {
    username = base64encode(var.db_username)
    password = base64encode(var.db_password)
  }

  type = "Opaque"
}