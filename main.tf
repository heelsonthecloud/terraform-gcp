provider "google" {
  credentials = file("terraform-plygrnd-7dcd713ddce7.json")

  project = "terraform-plygrnd"
  region  = "us-west1"
  zone    = "us-west1-a"
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
  metadata = {
   ssh-keys = "heely:${file("~/.ssh/id_rsa.pub")}"
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
resource "google_dns_managed_zone" "heely-zone" {
  name        = "heeled-zone"
  dns_name    = "heelsonthecloud.com."
  description = "Heely DNS zone"
}

resource "google_dns_record_set" "a" {
  name         = "${google_dns_managed_zone.heely-zone.dns_name}"
  managed_zone = google_dns_managed_zone.heely-zone.name
  type         = "A"
  ttl          = 300

  rrdatas = [google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip]
}

resource "google_dns_record_set" "cname" {
  name         = "www.${google_dns_managed_zone.heely-zone.dns_name}"
  managed_zone = google_dns_managed_zone.heely-zone.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["heelsonthecloud.com."]
}
