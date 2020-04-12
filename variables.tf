variable name {
    type = string
}

variable cores {
    type = number
    default = 1
}

variable memory_gb {
    type = number
    default = 2
}

variable disks {
    type = list
    default = [
    {
        type = "ssd"
        size = 8
    }
  ]
}

variable domain_name {
    type = string
    default = "home"
}

variable target_node {
    type = string
    default = "lenuc"
}

variable "vm_count" {
    type = number
}

variable "ssh_key_path" {
    type = string
    default = "~/.ssh/id_rsa.pub"
}

variable "image" {
    type = string
    default = "centos"
}

variable pve_user {
    default = "root"
}

variable pve_password {

}

variable "pve_host" {
  
}
