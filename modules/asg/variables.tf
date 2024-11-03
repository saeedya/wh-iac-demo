variable "project_name"{}
variable "ami" {
    default = "ami-0d64bb532e0502c46"
}
variable "instance_type" {
    default = "t2.micro"
}
variable "key_name" {}
variable "client_sg_id" {}
variable "max_size" {
    default = 6
}
variable "min_size" {
    default = 2
}
variable "desired_cap" {
    default = 2
}
variable "asg_health_check_type" {
    default = "EC2"
}
variable "pri_sub_3a_id" {}
variable "pri_sub_4b_id" {}
variable "tg_arn" {}