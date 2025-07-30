# Jira Data Center Deployment with ArgoCD

This document describes how to deploy **Atlassian Jira Data Center** in Kubernetes using Helm and ArgoCD with our GitOps folder structure and chart wrapping best practices.

---

## 📁 Folder Structure

repo-root/
├── argocd/
├── confluence/
│ ├── int/
│ └── prod/
├── jira/
│ ├── int/
│ └── prod/

- **`jira/int`** and **`jira/prod`** contain all chart and values for respective environments.

---

## 🚀 Deployment Workflow

### 1. **Wrapper Chart Pattern**

- We use a *wrapper* Helm chart in each environment folder.
- Atlassian’s official Jira Data Center Helm chart is added as a dependency in `Chart.yaml`.
- All configuration values for Jira are provided under the `jira:` key in the environment-specific values file (e.g., `values-int.yaml`).

### 2. **ArgoCD Application Manifest**

- Each environment (`int`, `prod`) has a corresponding ArgoCD `Application` manifest.
- The manifest points to this directory as the chart path and references the appropriate values file.

---

## 🛠️ Installation Steps

### **A. Prerequisites**

- Kubernetes cluster and admin access
- ArgoCD installed and running
- Access to the Atlassian Helm chart repo (public)
- Database, storage, and ingress configured per your environment

### **B. Prepare Your Values**

Edit `values-int.yaml` (or `values-prod.yaml`) with your Jira configuration.
- All settings **must be under the `jira:` key** (see values file for structure).
- Example (snippet):
  ```yaml
  jira:
    replicaCount: 2
    ingress:
      create: true
      host: jira-int.catena-x.polygran.io
    database:
      type: postgres72
      url: jdbc:postgresql://<db-host>:5432/jiradb-int

### **C. Update Chart Dependencies**

From the jira/int directory, run:
 ```sh
helm dependency update
 ```
This will pull the official Jira chart into your local charts/ directory.


### **D. Apply the ArgoCD Application**
From your repo root, apply the Application manifest:
 ```sh
kubectl apply -f argocd/jira-int-application.yaml
 ```
(Adjust path/filename as needed for your setup)

## 🧐 Tips & Troubleshooting
- Direct Helm install (bypassing wrapper chart) expects all values at root.
- Our GitOps approach requires nesting under jira:.

- To upgrade dependencies or Jira chart version, update Chart.yaml and rerun helm dependency update.

- Common issues:

    - nil pointer evaluating interface errors: likely a missing or empty key in your values file—see README troubleshooting for testPods defaults.

    - ArgoCD “missing config”: make sure your values are under jira:, not root.