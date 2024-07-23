#
# Variables Configuration. Check for REPLACE to substitute custom values. Check the description of each
# tag for more information
#

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  default = "ng-health-prd" #REPLACE
}

variable "vpc_cidr_block" {
  description = "CIDR block"
  default = "192.168.0.0/16"
}


variable "network_availability_zones" {
  description = "Configure availability zones configuration for VPC. Leave as default for India. Recommendation is to have subnets in at least two availability zones"
  default = ["af-south-1b", "af-south-1a"] #REPLACE IF NEEDED
}

variable "availability_zones" {
  description = "Amazon EKS runs and scales the Kubernetes control plane across multiple AWS Availability Zones to ensure high availability. Specify a comma separated list to have a cluster spanning multiple zones. Note that this will have cost implications"
  default = ["af-south-1b"] #REPLACE IF NEEDED
}

variable "kubernetes_version" {
  description = "kubernetes version"
  default = "1.29"
}

variable "instance_type" {
  description = "eGov recommended below instance type as a default"
  default = "m5.xlarge"
}

variable "override_instance_types" {
  description = "Arry of instance types for SPOT instances"
  default = ["m5.xlarge"]
  
}

variable "number_of_worker_nodes" {
  description = "eGov recommended below worker node counts as default"
  default = "4" #REPLACE IF NEEDED
}

variable "ssh_key_name" {
  description = "ssh key name, not required if your using spot instance types"
  default = "ng-impl" #REPLACE
}


variable "db_name" {
  description = "RDS DB name. Make sure there are no hyphens or other special characters in the DB name. Else, DB creation will fail"
  default = "nghealthprd" #REPLACE
}

variable "db_username" {
  description = "RDS database user name"
  default = "nghealthprd" #REPLACE
}

#DO NOT fill in here. This will be asked at runtime
variable "db_password" {}

variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnlDWZx+BNCam1Oktz8qq6/LVxWAS/IiphPSxYYbiRwoXsDtmMsYg2bqdpdJZpJLL5usvjF3YP7Gs0ILT5CvAW5f2lR4MfR6HR1u4OpT8R+sNmP0eUBu/v9tOzHJca7oe8jQkD/LUErUuvWCgvLAgYMOBw1x1x831PgxT22XJ3seS8SFgFf9pNag3zAy8mQ2fvf7MN+FTyrsH1Ya/7ZuxtcXkT4otocKZoudP1cX8NJqA9I/prs8q1nj5uCqIYEdqY4o1XaWQXHnRzjR2W2z6ZCJGYljK7DujHxmxZVbL87tk3b3lBDJJhO1nkvyt5OEWIm7DHJ2HQ6IViybjzaQ88E6kADmisJnxdvdwb2RAWhya3fDk9AWKW4lUSn/TYAo3tl+t7vLp3y5ls39F8aQ1qV3UgzPJLvfsy2KrGoePMhq6BUFTdNwcfqKLiDuGpR6xoIO2yj+CN7ZT3/IvfbwvYnZbzq4uoRqt8SWrjxjvlL51BN+a/uKg7vmMcbrXvTD0FT0p9ByY/kS2v6ZVPOz7m1frC6/FITIhc+D7KGAJ7WF4Q00yAok6Freh4/ZbfaMoRNL0zwZ5SlirW15QhpkAETIc/t6lXtFQFW6JykfRqpVUMuWdh4h+NJ112UiNGFejspSChuTJTXM5kh07yyJu9pJ5fTF5w9kWPuLsQLY9kPQ== prasanna@prasanna-Latitude-3420"
  description = "ssh key"
}

## change ssh key_name eg. digit-quickstart_your-name



