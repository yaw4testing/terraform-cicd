variable "aws_region" {
  description = "aws region default value"
  type = string
  default = "eu-west-2"
}

variable "cidr_block" {
 description = "defining vpc cidr and public and private subnets" 
 default = "10.0.0.0/16"

}
variable "subnet_count" {
  type = number
  default = 2
}
variable "public_subnets" {
  type = list
}
variable "private_subnets" {
  type = list
}