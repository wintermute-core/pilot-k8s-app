

provider "kubernetes" {
  config_path    = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
  }
}

resource "kubernetes_namespace" "postgres_namespace" {
  metadata {
    annotations = {
      name = var.postgres_namespace
    }
    labels = {
      applabel = var.postgres_namespace
    }
    name = var.postgres_namespace
  }
}

data "kubernetes_namespace" "postgres_namespace" {
  depends_on = [kubernetes_namespace.postgres_namespace]
  metadata {
    name = var.postgres_namespace
  }
}

resource "helm_release" "postgres_helm_chart" {
  depends_on = [kubernetes_namespace.postgres_namespace]

  name      = "postgres"
  chart     = "bitnami/postgresql"
  namespace = data.kubernetes_namespace.postgres_namespace.metadata[0].name
  values    = [templatefile("postgres-values.yaml", {})]
}