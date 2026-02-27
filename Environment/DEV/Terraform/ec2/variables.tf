variable "key_name" {
  type = string
}

variable "instances" {
  type = map(string)
  default = {
    app-server-1 = "t3.micro"
    app-server-2 = "t3.micro"
    db-server-1  = "t3.small"
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-2"
}