resource "kubernetes_manifest" "jira_prod_app" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "jira-prod"
      namespace = "argocd"
    }
    spec = {
      project = "default"
      source = {
        repoURL        = "https://github.com/nikolaypeshev-86/jira-int"
        targetRevision = "HEAD"
        path           = "jira/prod"
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "jira-prod"
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