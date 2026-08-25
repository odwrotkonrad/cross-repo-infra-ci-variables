##[>] 🤖🤖
#[why] these five group variables already exist: cross-repo/infra/iac published them until this
#   module took ownership. terraform adopts them instead of creating them, which would 409 on the
#   existing key and fail the apply
#[why] the id is group:key:environment_scope, the scope always * here
#[why] removable once a first apply has them in state: they are only needed for the cutover
import {
  to = gitlab_group_variable.che_schema_ref
  id = "konradodwrot:GRP_KO_VAR_CHE_SCHEMA_REF:*"
}

import {
  to = gitlab_group_variable.che_packages_schema_ref
  id = "konradodwrot:GRP_KO_VAR_CHE_PACKAGES_SCHEMA_REF:*"
}

import {
  to = gitlab_group_variable.ci_images_ref
  id = "konradodwrot:GRP_KO_VAR_CI_IMAGES_REF:*"
}

import {
  to = gitlab_group_variable.enable_darwin_ci
  id = "konradodwrot:GRP_KO_VAR_ENABLE_DARWIN_CI:*"
}

import {
  to = gitlab_group_variable.che_backup_auto_create
  id = "konradodwrot:GRP_KO_VAR_CHE_BACKUP_AUTO_CREATE:*"
}
##[<] 🤖🤖
