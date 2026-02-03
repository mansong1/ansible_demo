# OpenTofu: EC2 Linux for Ansible

## Prereqs
- OpenTofu installed (`tofu`)
- AWS credentials configured (env vars, shared config, or SSO)
- An SSH key:
  - Either an existing EC2 key pair name (`key_name`)
  - Or an SSH public key to create one (`ssh_public_key`)

## Quick start
From this folder:

```bash
tofu init

tofu apply \
  -var 'region=us-east-1' \
  -var 'allowed_ssh_cidr=YOUR_PUBLIC_IP/32' \
  -var 'ssh_public_key='"$(cat ~/.ssh/id_rsa.pub)"'
```

## Outputs
After apply, you can grab:
- `public_dns`
- `public_ip`
- `ansible_inventory_host`

Example inventory line:

```text
[myhosts]
<public_dns> ansible_user=ec2-user
```

## Notes
- This uses the default VPC and chooses the first subnet found.
- AMI is Amazon Linux 2023, so the SSH user is `ec2-user`.
