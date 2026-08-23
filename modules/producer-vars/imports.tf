##[>] 🤖🤖
#[why] these ten group variables already exist: cross-repo/infra/iac published them until this repo
#   took ownership, and the two OCI_IMAGES pins were set by hand during the che release. terraform
#   adopts them instead of creating them, which would 409 on the existing key and fail the apply
#[why] the resources carry count, so each address is indexed [0]
#[why] the id is group:key:environment_scope, the scope always * here
#[why] removable once a first apply has them in state: they are only needed for the cutover
import {
  to = gitlab_group_variable.ai_configs_ref[0]
  id = "konradodwrot:GRP_KO_VAR_AI_CONFIGS_REF:*"
}

import {
  to = gitlab_group_variable.automation_ref[0]
  id = "konradodwrot:GRP_KO_VAR_AUTOMATION_REF:*"
}

import {
  to = gitlab_group_variable.che_packages_ref[0]
  id = "konradodwrot:GRP_KO_VAR_CHE_PACKAGES_REF:*"
}

import {
  to = gitlab_group_variable.configs_ref[0]
  id = "konradodwrot:GRP_KO_VAR_CONFIGS_REF:*"
}

import {
  to = gitlab_group_variable.iac_ref[0]
  id = "konradodwrot:GRP_KO_VAR_IAC_REF:*"
}

import {
  to = gitlab_group_variable.misc_ref[0]
  id = "konradodwrot:GRP_KO_VAR_MISC_REF:*"
}

import {
  to = gitlab_group_variable.prose_assets_ref[0]
  id = "konradodwrot:GRP_KO_VAR_PROSE_ASSETS_REF:*"
}

import {
  to = gitlab_group_variable.prose_spec_ref[0]
  id = "konradodwrot:GRP_KO_VAR_PROSE_SPEC_REF:*"
}

import {
  to = gitlab_group_variable.oci_images_ci_linux_ref[0]
  id = "konradodwrot:GRP_KO_VAR_OCI_IMAGES_CI_LINUX_REF:*"
}

import {
  to = gitlab_group_variable.oci_images_ci_linux_dind_ref[0]
  id = "konradodwrot:GRP_KO_VAR_OCI_IMAGES_CI_LINUX_DIND_REF:*"
}
##[<] 🤖🤖
