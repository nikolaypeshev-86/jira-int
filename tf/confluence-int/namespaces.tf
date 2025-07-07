resource "kubernetes_namespace" "confluence_int" {
  metadata {
    name = "confluence-int"
  }
}