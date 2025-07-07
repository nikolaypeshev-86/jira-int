resource "kubernetes_manifest" "confluence_int_app" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "confluence-int"
      namespace = "argocd"
    }
    spec = {
      project = "default"
      source = {
        repoURL        = "https://github.com/nikolaypeshev-86/jira-int"
        targetRevision = "HEAD"
        path           = "confluence/int"
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "confluence-int"
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