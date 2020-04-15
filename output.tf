output "name" {
  value = "${proxmox_vm_qemu.vm.*.name}.${var.domain_name}"
}