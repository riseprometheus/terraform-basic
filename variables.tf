variable "aws_region" {
  description = "Region that your AWS resources will be created in"
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Value of the name tag for the EC2 instance"
  type        = string
  default     = "EC2 Test Instance"
}

variable "vpc_name" {
  description = "Value of the name tag for the VPC"
  type        = string
  default     = "server_vpc"
}

variable "subnet_name" {
  description = "Value of the name tag for the subnet"
  type        = string
  default     = "server_subnet"
}

variable "network_gateway_name" {
  description = "Value of the name tag for the internet network gateway"
  type        = string
  default     = "server_network_gateway"
}

variable "route_table_name" {
  description = "Value of the name tag for the route table"
  type        = string
  default     = "server_route_table"
}

variable "security_group_name" {
  description = "Value of the name tag for the security group"
  type        = string
  default     = "ssh_security_group"
}
