# Deploy simple bastion host to the default VPC

An example of deploying a simple bastion host to the default VPC.

## Create

```
. env.sh
export AWS_PROFILE=your-profile
tfi           # terraform init
tfp           # terraform plan
tfa           # terraform apply
```

## Destroy

```
tfd           # terraform destroy
```
