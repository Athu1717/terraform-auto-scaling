variable "vpc_id" {
    type = string
    default =  "vpc-040aa66ace8b32bea" 
  
}

variable "security_grp" {
    type = list(string)
    default = [ "sg-064249156caf312c0" ]
  
}

variable "ami_id" {
    type = string
    default = "ami-01760eea5c574eb86" 
  
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "subnet_ids" {
    type = list(string)
    default = ["subnet-0d32a965141517d55","subnet-03a0f583fb9b3cd28","subnet-000caf484d7fbe423"]
    }

variable "key_name" {
    type = string
    default = "mumkey"
}
