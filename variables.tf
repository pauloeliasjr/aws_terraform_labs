variable "region" {
    default = "us-east-1"
  }
variable "ami_mapping" {
    type = "map"
    default = {
        "sa-east-1" = "ami-09beb384ba644b754"
        "us-east-1" = "ami-07d0cf3af28718ef8"
    }
}

variable "ssh_key" {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQWWvX8jfSML4ZLKAEiZSWe/klemAe7PrpzuEbWS7aft2+uQUkvpj5vuxulTNOqiykmQlHpdsThUpjXdYD/uyctDK+J7WR3ls9HKLqHeOHg+bgqgMUWywSmJ3h22+aY32pZkEc+kVO/Cjy/lZMvBB0z/8rOXeDfJLOOai99Vx/ucUijquamsrTutggyu1eHQJr4D7RUNPt3tdR48RDwI/DZlSUrVv9TyvDtEcgtAdnM/M3BEZozpv1JsbKhETVxzs5VQhJE0R1JocQ29DtrqJIC8WgnSTqUUnLSGcyFG3Wo2nWFQw3poOwrXtwtW/uXORUWfvImilfcqo3IV0HUChb pauloeliasjr@thinkpad"
}