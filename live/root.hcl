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

#[why] no token attribute: the heredoc is written to provider.tf verbatim, so get_env() reached
#   terraform, which has no such function. the provider reads GITLAB_TOKEN from the environment on
#   its own, so naming it here buys nothing and only re-introduces that failure
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "gitlab" {}
EOF
}

inputs = {
  group = local.group
}
##[<] 🤖🤖
