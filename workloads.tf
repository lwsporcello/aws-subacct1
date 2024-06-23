resource "kubernetes_namespace" "namespace-tasky" {
  metadata {
    name = "tasky"
  }
}

resource "kubernetes_deployment" "deployment-tasky" {
  depends_on = [
    kubernetes_service_account.tasky-sa,
    kubernetes_cluster_role_binding.tasky-sa-rb
  ]
  metadata {
    name      = "tasky"
    namespace = "tasky"
    labels = {
      app = "tasky"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "tasky"
      }
    }
    template {
      metadata {
        labels = {
          app = "tasky"
        }
      }
      spec {
        service_account_name = "tasky-sa"
        container {
          image = "sporcello/tasky:latest"
          name  = "tasky"

          port {
            container_port = 8080
          }

          env {
            name  = "MONGODB_URI"
            value = "mongodb://${var.mongo-user}:${var.mongo-pass}@10.10.1.81:27017"
          }

          env {
            name  = "SECRET_KEY"
            value = "${var.secret-key}"
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "tasky" {
  metadata {
    name      = "tasky"
    namespace = "tasky"
  }
  spec {
    selector = {
      app = "tasky"
    }
    type = "LoadBalancer"
    port {
      port        = 8080
      target_port = 8080
    }
  }
}

resource "kubernetes_service_account" "tasky-sa" {
  metadata {
    name      = "tasky-sa"
    namespace = "tasky"
    labels = {
      "app.kubernetes.io/name"      = "tasky"
      "app.kubernetes.io/component" = "controller"
    }
  }
}

resource "kubernetes_cluster_role_binding" "tasky-sa-rb" {
  depends_on = [
    kubernetes_service_account.tasky-sa
  ]

  metadata {
    name = "tasky-sa-rb"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "tasky-sa"
    namespace = "tasky"
  }
}
