provider "proxmox" {
    pm_api_url = "https://192.168.1.200:8006/api2/json"
    pm_user = "${var.pve_user}@pam"
    pm_password = var.pve_password
    pm_tls_insecure = true
}

module "proxmox_vm" {
  source = "alykraft/vm/proxmox"
  
}
