provider "kubernetes" {
 config_context_cluster   = "minikube"
 config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "otus" {
  metadata {
        name = "otus"
        
  }
}

resource "kubernetes_namespace" "otus-dev" {
  metadata {
        name = "otus-dev"
  }
}

resource "kubernetes_deployment" "nginx-otus-dev" {
  metadata {
    name = "nginx-otus-dev"
    namespace = kubernetes_namespace.otus-dev.id
    labels = {
      App = "NginxOtusDev"
    }
  }

   spec {
         replicas = 2
    selector {
      match_labels = {
        App = "NginxOtusDev"
      }
    }
    template {
      metadata {
        labels = {
          App = "NginxOtusDev"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8"
          name  = "nginx-otus-dev"

          port {
            container_port = var.numport
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


