provider "proxmox" {
    pm_api_url = "https://192.168.1.200:8006/api2/json"
    pm_user = "root@pam"
    pm_password = var.pve_password
    pm_tls_insecure = true
}

module "vms" {
  source  = "app.terraform.io/alykraft/vm/proxmox"
  version = "0.0.2"

  name = "centos"
  pve_host = "192.168.1.200"
  pve_password = var.pve_password
  vm_count = 1
}
