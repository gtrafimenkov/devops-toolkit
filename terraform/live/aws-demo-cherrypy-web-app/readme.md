# Deploy simple web app into AWS

An example of deploying a simple web application into a public subnet of
new VPC on AWS.

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
