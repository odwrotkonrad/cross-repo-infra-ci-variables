##[>] 🤖🤖
#[why] the group variables nothing generates: a schema pin, a CI image pin and two feature flags.
#   producer-vars and consumer-vars are both fed by cross-repo/automation's generated tfvars, one
#   entry per released artifact, so a value no release produces has nowhere to live there
#[why] the value is written here rather than in a tfvars file: automation owns every generated
#   file in live/, and a hand-edited value in one of them is overwritten by the next generation.
#   These change when a human decides they change, so a human edits them here and applies
#[why] they came from cross-repo/infra/iac, which is being emptied. Not to cross-repo/infra/base:
#   base owns identity and the resources it can derive a value from, and none of these is either

variable "group" {
  type = string
}

#[why] the che schema every repo's che.yml validates against, published as a generic package. It
#   moves when che's schema changes shape, which is a deliberate release, not an artifact version
variable "che_schema_ref" {
  type    = string
  default = "v0.0.1-che-min-v0.0.96"
}

#[why] the che-packages catalog schema. A separate pin from che_schema_ref: the catalog and the
#   loader version independently, and one moving must not drag the other
variable "che_packages_schema_ref" {
  type    = string
  default = "v0.0.1-che-min-v0.0.96"
}

#[why] the ci-linux image tag every pipeline pulls. Raised by cross-repo/infra/oci-images releasing
#   a new image, which is a human-reviewed bump rather than an automatic one: a bad CI image breaks
#   every repo at once
variable "ci_images_ref" {
  type    = string
  default = "v0.0.128"
}

#[why] the macOS CI switch. Off: the SaaS macOS runners cost minutes this group does not have, so
#   the darwin jobs stay declared and skipped until someone turns them on deliberately
variable "enable_darwin_ci" {
  type    = string
  default = "false"
}

#[why] whether che archives what it replaces before loading onto a host. Off in CI: the runner pod
#   is deleted with the job, so an archive of what che changed outlives nothing
variable "che_backup_auto_create" {
  type    = string
  default = "false"
}

resource "gitlab_group_variable" "che_schema_ref" {
  group     = var.group
  key       = "GRP_KO_VAR_CHE_SCHEMA_REF"
  value     = var.che_schema_ref
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "che_packages_schema_ref" {
  group     = var.group
  key       = "GRP_KO_VAR_CHE_PACKAGES_SCHEMA_REF"
  value     = var.che_packages_schema_ref
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "ci_images_ref" {
  group     = var.group
  key       = "GRP_KO_VAR_CI_IMAGES_REF"
  value     = var.ci_images_ref
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "enable_darwin_ci" {
  group     = var.group
  key       = "GRP_KO_VAR_ENABLE_DARWIN_CI"
  value     = var.enable_darwin_ci
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "che_backup_auto_create" {
  group     = var.group
  key       = "GRP_KO_VAR_CHE_BACKUP_AUTO_CREATE"
  value     = var.che_backup_auto_create
  masked    = false
  protected = false
}
##[<] 🤖🤖
