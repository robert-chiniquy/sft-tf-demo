# sft-tf-demo

Useful Terraform scripts here for spinning up different cloud server configurations with ScaleFT

## Usage

1. Create a terraform.tfvars file like example below
2. `# terraform apply`
3. `sft list-servers` to see the server name or ID; Alternately just use the AWS instance id
`sft rdp <name, id, or instance id>`

### terraform.tfvars

```
access_key = "<IAM access key here>"
secret_key = "<IAM access key secret here>"
aws_key_path = "~/.ssh/aws-demo-rsa.pub"
```

Just use ssh-keygen to make a new keypair (with no passphrase) for this purpose.

## 2012r2

Terraform to create a Windows Server r2012 node on AWS with ScaleFT Agent installed