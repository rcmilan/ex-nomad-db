job "postgres" {
  datacenters = ["dc1"]

  group "database" {
    count = 1

    network {
      mode = "host"
      port "db" {
        to = 5432
      }
    }

    task "postgres" {
      driver = "docker"

      config {
        image = "postgres:latest"
      }

      env {
        POSTGRES_USER     = "your_username"
        POSTGRES_PASSWORD = "your_password"
        POSTGRES_DB       = "your_database"
      }

      resources {
        cpu    = 500
        memory = 1024
      }

      service {
        name     = "postgres"
        port     = "db"
        provider = "nomad"
        check {
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
