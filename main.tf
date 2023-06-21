variable "n_repositories" {
  description = "Number of repositories to create. It's best to not do more than 10-20 at a time. Going over 140 in a short period of time will result in a rate limit and likely cause orphaned github repos which will require manual clean up."
  default     = 2
}

variable "github_owner" {
  description = "The owner of the github repositories. This should be the tenant organization."
  default     = "example-tenant"
}

variable "template_github_repo" {
  description = "value of the github repository to use as a template. This should be a public repo."
  default     = "GlueOps/qa-test-harness-template"
}

provider "github" {
  owner = var.github_owner
}

data "github_user" "current" {
  username = ""
}

locals {
  branch_name = "testing-prs"
  repos       = { for i in range(var.n_repositories) : "${data.github_user.current.login}-test-repo-${i}" => i }
}

resource "github_repository" "test" {
  for_each    = local.repos
  name        = each.key
  description = "Created with terraform"
  visibility  = "public"
  template {
    owner                = split("/", var.template_github_repo)[0]
    repository           = split("/", var.template_github_repo)[1]
    include_all_branches = true
  }
}

resource "github_branch" "pr_test" {
  depends_on = [github_repository.test]
  for_each   = local.repos
  repository = each.key
  branch     = local.branch_name
}

resource "github_repository_file" "test_files" {
  depends_on          = [github_branch.pr_test, github_repository.test]
  for_each            = local.repos
  repository          = each.key
  branch              = local.branch_name
  file                = ".gitignore"
  content             = "#ignore me"
  commit_message      = "Managed by Terraform"
  commit_author       = "terraform test harness"
  commit_email        = "no-reply@glueops.rocks"
  overwrite_on_create = true
}


resource "github_repository_pull_request" "pr" {
  depends_on      = [github_branch.pr_test, github_repository_file.test_files, github_repository.test]
  for_each        = local.repos
  base_repository = each.key
  base_ref        = "main"
  head_ref        = local.branch_name
  title           = "My newest feature"
  body            = "This will change everything"
}
