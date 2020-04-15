output "name" {
  value = formatlist("%s.%s", proxmox_vm_qemu.vm.*.name, var.domain_name)
}