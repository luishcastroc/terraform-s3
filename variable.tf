variable app_name {
  type = string
  default = "universe-simplification"
}

variable aws_region {
  default = "us-east-1"
}


variable env_type {
    type = string
    default = "dev"
}

variable "codestarconnections_name" {
  default = "connection"
  type = string
}

variable "env_vars" {default = {}} 

variable frontend {
  default = "angular"
}

variable "reponame" {
  default = "luishcastroc/solucrea-nx"
}

variable "repo_branch" {
  default = "main"
}

variable folder {
  default = "frontend"
}
