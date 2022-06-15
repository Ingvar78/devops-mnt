variable "yc_cloud_id" {
  description = "Cloud"
}
variable "yc_folder_id" {
  description = "Folder"
}
variable "yc_zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}

variable "yc_image_family" {
  default = "centos-7"
}

variable "vm_prefix" {
  default = "c7"
}

# variable "public_key_path" {
#   description = "Path to the public key used for ssh access"
#   default     = "~/.ssh/id_rsa.pub"
# }

# variable "private_key_path" {
#   description = "Path to Private Key File"
#   default     = "~/.ssh/id_rsa"
# }

variable "service_account_key_file" {
  description = "key .json"
}


variable "metadata_file" {
  description = "Metadata file for ssh"
}

variable "sa_id" {
  description = "SERVICE ACCOUNT ID"
}

variable "login" {
  default = "ansible"
}

