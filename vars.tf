#variable "AWS_ACCESS_KEY"{
#    description = "aws access key"
#}

#variable "AWS_SECRET_KEY" {
#    description = "aws secret key"
#}

variable "AWS_REGION" {
    description = "aws region"
    default = "ap-southeast-1"
}

#variable "PATH_TO_PUBLIC_KEY" {
#    description = "public key"
#    default = "terraform-ssh-key.pub"
#}

#variable "PATH_TO_PRIVATE_KEY" {
#    description = "private key for terraform"
#    default = "terraform-ssh-key"
#}

variable "AMIS" {
    description = "the AMIS to use"
    default = {
        ap-southeast-1 = "ami-063e3af9d2cc7fe94"
    }
}        