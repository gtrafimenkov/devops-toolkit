// SPDX-License-Identifier: MIT
// Copyright (c) 2019 Gennady Trafimenkov

provider "google" {
  project     = "gtfree-181909"
  credentials = "${file("gcloud-service-account-credentials.json")}"
}

resource "google_compute_instance" "test" {
  name         = "test"
  machine_type = "f1-micro"
  zone         = "europe-west3-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-1804-lts"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = "echo hi > /test.txt"

  provisioner "local-exec" {
    command = "echo ${google_compute_instance.test.network_interface.0.access_config.0.assigned_nat_ip} > public-ip.txt"
  }

  provisioner "local-exec" {
    command = "gcloud compute config-ssh"
  }
}
