resource "kubernetes_manifest" "confluence_prod_app" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "confluence-prod"
      namespace = "argocd"
    }
    spec = {
      project = "default"
      source = {
        repoURL        = "https://github.com/nikolaypeshev-86/jira-int"
        targetRevision = "HEAD"
        path           = "confluence/prod"
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "confluence-prod"
      }
      syncPolicy = {
        automated = {
          selfHeal = true
          prune    = true
        }
        syncOptions = ["CreateNamespace=true"]
      }
    }
  }
}