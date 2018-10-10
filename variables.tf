variable "access_ip" {
  description = "IP address to be whitelisted"
}

variable "ssh_pubkey_path" {
  description = "SSH public key path"
  default     = "~/.ssh/id_rsa.pub"
}

variable "instance_type" {
  default = "t3.large"
}
