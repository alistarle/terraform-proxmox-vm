resource "null_resource" "cloud_init_config_files" {
  count = var.vm_count
  connection {
    type     = "ssh"
    user     = var.pve_user
    password = var.pve_password
    host     = var.pve_host
  }

  provisioner "file" {
    content      = templatefile("${path.module}/files/user_data.cfg", {
                        pubkey   = file(var.ssh_key_path)
                        hostname = "${var.name}${count.index+1}"
                        domain     = var.domain_name
                    })
    destination = "/var/lib/vz/snippets/user_data_${var.name}-${count.index}.yml"
  }
}

resource "proxmox_vm_qemu" "vm" {
  count = var.vm_count
  depends_on = [
    null_resource.cloud_init_config_files,
  ]
  name = "${var.name}${count.index+1}.${var.domain_name}"
  target_node = var.target_node
  agent = var.agent
  clone = var.image
  cores = var.cores
  sockets = 1
  memory = var.memory_gb * 1024

  dynamic "disk" {
    for_each = var.disks
    content {
      id = disk.key
      size = disk.value.size
      type = "scsi"
      storage = disk.value.type
      storage_type = "lvmthin"
      iothread = true
    }
  }

  network {
    id = 0
    model = "virtio"
    bridge = "vmbr0"
  }

  os_type = "cloud-init"

  cicustom = "meta=local:snippets/user_data_${var.name}-${count.index}.yml,user=local:snippets/user_data_${var.name}-${count.index}.yml"
}
