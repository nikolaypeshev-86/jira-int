resource "kubernetes_namespace" "jira_prod" {
  metadata {
    name = "jira-prod"
  }
}

resource "kubernetes_namespace" "jira_int" {
  metadata {
    name = "jira-int"
  }
}