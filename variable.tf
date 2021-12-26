variable app_name {}

variable aws_region {}


variable env_type {
    type = string
    default = "prod"
}

variable "codestarconnections_name" {
  default = "connection"
  type = string
}

variable "env_vars" {default = {}} 

variable frontend {}

variable "reponame" {}

variable "repo_branch" {}

variable folder {}
