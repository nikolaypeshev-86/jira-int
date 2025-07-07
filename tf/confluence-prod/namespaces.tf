resource "kubernetes_namespace" "confluence_prod" {
  metadata {
    name = "confluence-prod"
  }
}