# Deploy simple instance to the default VPC

An example of deploying a simple instance to the default VPC.

It also shows some basic work with volumes (changing the root volume, attaching a persistent
volume).

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
