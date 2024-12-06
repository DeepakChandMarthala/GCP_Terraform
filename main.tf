provider "google" {
  project = "YOUR_PROJECT_ID"
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_compute_instance" "ci_cd_instance" {
  name         = "ci-cd-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y nginx
    curl -o /var/www/html/index.html https://raw.githubusercontent.com/deepakchand.marthala/terraform-ci-cd/main/index.html
    sudo systemctl restart nginx
  EOF
}
