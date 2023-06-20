
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_provider_versions"></a> [provider\_versions](#module\_provider\_versions) | git::https://github.com/GlueOps/terraform-module-provider-versions.git | n/a |

## Resources

| Name | Type |
|------|------|
| [github_branch.pr_test](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/branch) | resource |
| [github_repository.test](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/repository) | resource |
| [github_repository_file.test_files](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/repository_file) | resource |
| [github_repository_pull_request.pr](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/repository_pull_request) | resource |
| [github_user.current](https://registry.terraform.io/providers/hashicorp/github/latest/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_owner"></a> [github\_owner](#input\_github\_owner) | The owner of the github repositories. This should be the tenant organization. | `string` | `"example-tenant"` | no |
| <a name="input_n_repositories"></a> [n\_repositories](#input\_n\_repositories) | Number of repositories to create. It's best to not do more than 10-20 at a time. Going over 140 in a short period of time will result in a rate limit and likely cause orphaned github repos which will require manual clean up. | `number` | `2` | no |
| <a name="input_template_github_repo"></a> [template\_github\_repo](#input\_template\_github\_repo) | value of the github repository to use as a template. This should be a public repo. | `string` | `"GlueOps/qa-test-harness-template"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
