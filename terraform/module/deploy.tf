
resource "kubernetes_deployment" "app" {
  metadata {
    name = var.deployName
    labels = {
      tier = "frontend"
    }
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        tier = "frontend"
      }
    }

    template {

      metadata {
        labels = {
          tier = "frontend"
        }
      }

      spec {
        image_pull_secrets {name  = "gitlab-cr"}
        container {
          image = "gitlab.cns-com.com:5678/dcindrak/example-simple-app"
          image_pull_policy = "Always"
          name  = var.deployName
          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "250Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name = var.serviceName
    namespace = var.namespace
  }
  spec {
    selector = {
      tier = kubernetes_deployment.app.spec[0].template.0.metadata.0.labels.tier
    }
    
  port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}
