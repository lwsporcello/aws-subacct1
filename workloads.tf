resource "kubernetes_namespace" "namespace-tasky" {
  metadata {
    name = "tasky"
  }
}

resource "kubernetes_deployment" "deployment-tasky" {
  metadata {
    name = "tasky"
    labels = {
      App = "tasky"
    }
  }

  spec {
    replicas = 0
    selector {
      match_labels = {
        App = "tasky"
      }
    }
    template {
      metadata {
        labels = {
          App = "tasky"
        }
      }
      spec {
        container {
          image = "sporcello/tasky:latest"
          name  = "tasky"

          port {
            container_port = 8080
          }

          env {
            name  = "MONGODB_URI"
            value = "mongodb://"
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
