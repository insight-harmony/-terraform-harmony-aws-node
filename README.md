# terraform-harmony-aws-node

[![open-issues](https://img.shields.io/github/issues-raw/insight-harmony/terraform-harmony-aws-node?style=for-the-badge
)](https://github.com/insight-harmony/terraform-harmony-aws-node/issues)
[![open-pr](https://img.shields.io/github/issues-pr-raw/insight-harmony/terraform-harmony-aws-node?style=for-the-badge)](https://github.com/insight-harmony/terraform-harmony-aws-node/pulls)

> Warning: WIP - not ready for use 

## Features

This module bootstraps a node on the Harmony blockchain. 

## Terraform Versions

For Terraform v0.12.0+

## Usage

```hcl-terraform
module "defaults" {
  source           = "../.."
  private_key_path = var.private_key_path
  public_key_path  = var.public_key_path
}
```
## Examples

- [defaults](https://github.com/insight-infrastructure/terraform-harmony-aws-node/tree/master/examples/defaults)

## Known  Issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| null | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| additional\_security\_groups | List of additional security groups | `list(string)` | `[]` | no |
| create | Boolean to make module or not | `bool` | `true` | no |
| create\_ansible | Boolean to make module or not | `bool` | `true` | no |
| create\_security\_group | Bool to create security group | `bool` | `true` | no |
| instance\_type | Instance type | `string` | `"t2.small"` | no |
| key\_name | The name of the preexisting key to be used instead of the local public\_key\_path | `string` | `""` | no |
| monitoring\_enabled | Enable cloudwatch monitoring on node | `bool` | `true` | no |
| name | The name of the resources | `string` | `""` | no |
| network\_name | The network name, ie kusama / mainnet | `string` | `""` | no |
| node\_name | Name of the node | `string` | `""` | no |
| private\_key\_path | Path to private key | `string` | `""` | no |
| public\_key | The public ssh key. key\_name takes precidence | `string` | `""` | no |
| public\_key\_path | The public ssh key path. key\_name takes precidence | `string` | `""` | no |
| root\_volume\_size | Root volume size | `string` | `"90"` | no |
| ssh\_ips | List of IPs to restrict ssh traffic to | `list(string)` | n/a | yes |
| subnet\_id | The id of the subnet. Must be supplied if given vpc\_id | `string` | n/a | yes |
| tags | Tags to associate with the instance. | `map(string)` | `{}` | no |
| vpc\_id | The vpc id to associate with.  Must be supplied if given subnet\_id | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_id | n/a |
| private\_ip | n/a |
| public\_ip | n/a |
| security\_group\_ids | n/a |
| subnet\_id | n/a |
| user\_data | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Testing
This module has been packaged with terratest tests

To run them:

1. Install Go
2. Run `make test-init` from the root of this repo
3. Run `make test` again from root

## Authors

Module managed by [insight-infrastructure](https://github.com/insight-infrastructure)

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.