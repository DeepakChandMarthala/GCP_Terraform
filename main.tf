terraform {
  required_version = ">= 1.0.0"  # Terraform version
}

provider "google" {
  project     = "adept-odyssey-443800-t2"  # Replace with your GCP Project ID
  region      = "us-central1"             # Set your desired region
  zone        = "us-central1-a"           # Set your desired zone
  credentials = file("service-account.json")  # Path to your service account JSON file
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
    curl -o /var/www/html/index.html https://raw.githubusercontent.com/DeepakChandMarthala/GCP_Terraform/main/index.html
    sudo systemctl restart nginx
  EOF
}
