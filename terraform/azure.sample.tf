variable "amis" {
  default = {
    us-east-1      = "ami-6d1c2007"
    us-west-2      = "ami-d2c924b2"
    us-west-1      = "ami-af4333cf"
    eu-central-1   = "ami-9bf712f4"
    eu-west-1      = "ami-7abd0209"
    ap-southeast-1 = "ami-f068a193"
    ap-southeast-2 = "ami-fedafc9d"
    ap-northeast-1 = "ami-eec1c380"
    sa-east-1      = "ami-26b93b4a"
  }
}
variable "availability_zones"  {
  default = "a,b,c"
}
variable "control_count" { default = 3 }
variable "datacenter" {default = "azure-west-us"}
variable "edge_count" { default = 1 }
variable "location" {default = "West US"}
variable "short_name" {default = "mantl"}
variable "ssh_username" {default = "centos"}
variable "worker_count" { default = 2 }
variable "kubeworker_count" { default = 0 }
variable "dns_subdomain" { default = ".dev" }
variable "dns_domain" { default = "jobmeerkat.com" }
variable "dns_zone_id" { default = "Z20TJGASY4GRJ9" }
variable "control_type" { default = "m3.medium" }
variable "edge_type" { default = "m3.medium" }
variable "worker_type" { default = "m4.2xlarge" }
variable "kubeworker_type" { default = "m3.xlarge" }

provider "azurerm" {
}

# _local is for development only s3 or something else should be used
# https://github.com/hashicorp/terraform/blob/master/state/remote/remote.go#L47
# https://www.terraform.io/docs/state/remote.html
#resource "terraform_remote_state" "vpc" {
#  backend = "_local"
#  config {
#    path = "./vpc/terraform.tfstate"
#  }
# }

# s3 example
#resource  "terraform_remote_state" "vpc" {
# backend = "s3"
#  config {
#    bucket = "mybucketname"
#   key = "name_of_state_file"
#  }
#}

module "virtual_network" {
  source ="./terraform/azure/virtual_network"
  network_name = "${var.short_name}"
  resource_name = "production"
  subnet_name = "${var.short_name}-subnet"
  location = "${var.location}"
}

