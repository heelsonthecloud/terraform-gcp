provider "google" {
  credentials = file("terraform-plygrnd-7dcd713ddce7.json")

  project = "terraform-plygrnd"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.vpc_network.name
  allow {
    protocol="icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22","80", "443"]
  }
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  tags         = ["web", "dev"]

  boot_disk {
    initialize_params {
      image = "centos-7"
      size = 50
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
  provisioner "local-exec" {
    command = "echo ${google_compute_instance.vm_instance.name} >> ip_address.txt"
  }
}
