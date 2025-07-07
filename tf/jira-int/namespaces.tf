resource "kubernetes_namespace" "jira_int" {
  metadata {
    name = "jira-int"
  }
}