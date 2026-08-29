##[>] 🤖🤖
#[why] one unit for the whole workspace: every group variable shares one target, and each
#   producer determines its own latest
variable "group" {
  type = string
}

variable "AI_TOOLS_CONFIGS_REF" {
  type    = string
  default = null
}

variable "AI_SANDBOX_REF" {
  type    = string
  default = null
}

variable "AUTOMATION_REF" {
  type    = string
  default = null
}

variable "CHE_PACKAGES_REF" {
  type    = string
  default = null
}

variable "TOOLS_CONFIGS_REF" {
  type    = string
  default = null
}

variable "GO_MODULES_CHE_REF" {
  type    = string
  default = null
}

variable "GO_MODULES_GET_OS_OPEN_FILES_WITH_REF" {
  type    = string
  default = null
}

variable "GO_MODULES_GET_TERM_OPEN_FILES_WITH_REF" {
  type    = string
  default = null
}

variable "GO_MODULES_LIB_REF" {
  type    = string
  default = null
}

variable "IAC_REF" {
  type    = string
  default = null
}

variable "CENTRALIZED_ASSETS_GENERIC_REF" {
  type    = string
  default = null
}

variable "CENTRALIZED_ASSETS_PROSE_HUMAN_REF" {
  type    = string
  default = null
}

variable "CENTRALIZED_ASSETS_PROSE_AI_REF" {
  type    = string
  default = null
}

variable "CENTRALIZED_ASSETS_PROSE_COMMON_REF" {
  type    = string
  default = null
}

variable "MISC_REF" {
  type    = string
  default = null
}

variable "CHE_SCHEMA_REF" {
  type    = string
  default = null
}

variable "CHE_PACKAGES_SCHEMA_REF" {
  type    = string
  default = null
}

variable "USER_SSH_UTIL_REF" {
  type    = string
  default = null
}

variable "NOTES_REF" {
  type    = string
  default = null
}

variable "OCI_IMAGES_CI_LINUX_DIND_REF" {
  type    = string
  default = null
}

variable "OCI_IMAGES_CI_LINUX_REF" {
  type    = string
  default = null
}

variable "PROSE_ASSETS_REF" {
  type    = string
  default = null
}

variable "PROSE_SPEC_REF" {
  type    = string
  default = null
}

variable "RESUME_MD_PDF_REF" {
  type    = string
  default = null
}

resource "gitlab_group_variable" "ai_tools_configs_ref" {
  count     = var.AI_TOOLS_CONFIGS_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_AI_TOOLS_CONFIGS_REF"
  value     = var.AI_TOOLS_CONFIGS_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "ai_sandbox_ref" {
  count     = var.AI_SANDBOX_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_AI_SANDBOX_REF"
  value     = var.AI_SANDBOX_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "automation_ref" {
  count     = var.AUTOMATION_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_AUTOMATION_REF"
  value     = var.AUTOMATION_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "che_packages_ref" {
  count     = var.CHE_PACKAGES_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_CHE_PACKAGES_REF"
  value     = var.CHE_PACKAGES_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "tools_configs_ref" {
  count     = var.TOOLS_CONFIGS_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_TOOLS_CONFIGS_REF"
  value     = var.TOOLS_CONFIGS_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "go_modules_che_ref" {
  count     = var.GO_MODULES_CHE_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_GO_MODULES_CHE_REF"
  value     = var.GO_MODULES_CHE_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "go_modules_get_os_open_files_with_ref" {
  count     = var.GO_MODULES_GET_OS_OPEN_FILES_WITH_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_GO_MODULES_GET_OS_OPEN_FILES_WITH_REF"
  value     = var.GO_MODULES_GET_OS_OPEN_FILES_WITH_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "go_modules_get_term_open_files_with_ref" {
  count     = var.GO_MODULES_GET_TERM_OPEN_FILES_WITH_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_GO_MODULES_GET_TERM_OPEN_FILES_WITH_REF"
  value     = var.GO_MODULES_GET_TERM_OPEN_FILES_WITH_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "go_modules_lib_ref" {
  count     = var.GO_MODULES_LIB_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_GO_MODULES_LIB_REF"
  value     = var.GO_MODULES_LIB_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "iac_ref" {
  count     = var.IAC_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_IAC_REF"
  value     = var.IAC_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "user_ssh_util_ref" {
  count     = var.USER_SSH_UTIL_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_USER_SSH_UTIL_REF"
  value     = var.USER_SSH_UTIL_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "centralized_assets_generic_ref" {
  count     = var.CENTRALIZED_ASSETS_GENERIC_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_CENTRALIZED_ASSETS_GENERIC_REF"
  value     = var.CENTRALIZED_ASSETS_GENERIC_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "centralized_assets_prose_human_ref" {
  count     = var.CENTRALIZED_ASSETS_PROSE_HUMAN_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_CENTRALIZED_ASSETS_PROSE_HUMAN_REF"
  value     = var.CENTRALIZED_ASSETS_PROSE_HUMAN_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "centralized_assets_prose_ai_ref" {
  count     = var.CENTRALIZED_ASSETS_PROSE_AI_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_CENTRALIZED_ASSETS_PROSE_AI_REF"
  value     = var.CENTRALIZED_ASSETS_PROSE_AI_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "centralized_assets_prose_common_ref" {
  count     = var.CENTRALIZED_ASSETS_PROSE_COMMON_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_CENTRALIZED_ASSETS_PROSE_COMMON_REF"
  value     = var.CENTRALIZED_ASSETS_PROSE_COMMON_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "misc_ref" {
  count     = var.MISC_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_MISC_REF"
  value     = var.MISC_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "notes_ref" {
  count     = var.NOTES_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_NOTES_REF"
  value     = var.NOTES_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "oci_images_ci_linux_dind_ref" {
  count     = var.OCI_IMAGES_CI_LINUX_DIND_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_OCI_IMAGES_CI_LINUX_DIND_REF"
  value     = var.OCI_IMAGES_CI_LINUX_DIND_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "oci_images_ci_linux_ref" {
  count     = var.OCI_IMAGES_CI_LINUX_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_OCI_IMAGES_CI_LINUX_REF"
  value     = var.OCI_IMAGES_CI_LINUX_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "prose_assets_ref" {
  count     = var.PROSE_ASSETS_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_PROSE_ASSETS_REF"
  value     = var.PROSE_ASSETS_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "prose_spec_ref" {
  count     = var.PROSE_SPEC_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_PROSE_SPEC_REF"
  value     = var.PROSE_SPEC_REF
  masked    = false
  protected = false
}

resource "gitlab_group_variable" "resume_md_pdf_ref" {
  count     = var.RESUME_MD_PDF_REF != null ? 1 : 0
  group     = var.group
  key       = "GRP_KO_VAR_RESUME_MD_PDF_REF"
  value     = var.RESUME_MD_PDF_REF
  masked    = false
  protected = false
}

##[<] 🤖🤖
