provider "kubernetes" {
  host                   = data.aws_eks_cluster.existing_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.existing_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.existing_cluster_auth.token
}

resource "kubernetes_deployment" "dp010-app" {
  metadata {
    name      = "dp010-app-deployment-dp010"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "dp010-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "dp010-app"
        }
      }

      spec {
        container {
          name  = "dp010-app"
          image = "gabgabgabas/getting-started:latest"

          port {
            container_port = 80
          }

          resources {
            requests = {
              memory = "512Mi"
              cpu    = "250m"
            }
            limits = {
              memory = "1Gi"
              cpu    = "500m"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "dp010-app" {
  metadata {
    name      = "dp010-app-service-dp010"
    namespace = "default"
  }

  spec {
    selector = {
      app = "dp010-app"
    }

    port {
      port        = 80
      target_port = 3000
      protocol = "TCP"
    }

    type = "LoadBalancer"
  }
}
