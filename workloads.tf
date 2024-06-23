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
    replicas = 1
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
            value = "mongodb://myMongoUser1987:myMongoPass1987@10.10.1.81:27017"
          }

          env {
            name  = "SECRET_KEY"
            value = "sporcello123"
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
