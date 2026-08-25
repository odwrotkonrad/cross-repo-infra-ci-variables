##[>] 🤖🤖
#[why] its own unit beside producers/ and consumers/, so the variables no generation touches plan
#   and apply on their own: a regenerated producers file cannot block a flag change, and a flag
#   change cannot ride along with a release
include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_repo_root()}/modules/static-vars"
}
##[<] 🤖🤖
