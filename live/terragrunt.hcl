##[>] 🤖🤖
#[why] one unit per consumer repo, so a regenerated file for one repo plans and applies alone:
#   a broken generation for one cannot block every other repo's apply
locals {
  group = "konradodwrot"
}

remote_state {
  backend = "gcs"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "konradodwrot-ci-variables-tfstate"
    prefix = "${path_relative_to_include()}"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "gitlab" {
  token = get_env("GITLAB_TOKEN")
}
EOF
}

inputs = {
  group = local.group
}
##[<] 🤖🤖
