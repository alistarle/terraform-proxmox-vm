provider "proxmox" {
    pm_api_url = "https://192.168.1.200:8006/api2/json"
    pm_user = "root@pam"
    pm_password = var.pve_password
    pm_tls_insecure = true
}

variable "pve_password" {

}


module "vms" {
  source  = "app.terraform.io/alykraft/vm/proxmox"
  version = "0.0.4"

  name = "kubernetes"
  pve_host = "192.168.1.200"
  cores = 4
  memory_gb = 8
  disks = [
    {
        type = "ssd"
        size = 50
    }
  ]
  pve_password = var.pve_password
  vm_count = 3
}

output "vm_names" {
  value = module.vms.name
}