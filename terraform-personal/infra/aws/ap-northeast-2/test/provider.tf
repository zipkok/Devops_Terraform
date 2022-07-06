# Terminal Output: provider registry.terraform.io/hashicorp/local v2.0.0
# Terminal Output: provider registry.terraform.io/hashicorp/tls v3.0.0
terraform {
  required_version = "0.14.5"
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "3.0.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.0.0"
    }
  }
}

provider "tls" {}
provider "local" {}

# Ref: https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Ref: https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "cloud_config" {
    content  = data.template_file.dt_cloud_config.rendered
    filename = "cloud-config.yaml"
}

data "template_file" "dt_cloud_config" {
  template = file("cloud-config.yaml.tpl")

  vars = {
    private_key = indent(4, tls_private_key.ssh_key.private_key_pem)
    public_key  = indent(4, tls_private_key.ssh_key.public_key_pem)
  }
}

# output "out_ssh_keys" {
#  value     = data.template_file.dt_cloud_config_render
#  sensitive = true
# }