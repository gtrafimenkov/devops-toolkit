# Upgraded AMI of distributions

## Build examples

```
export AWS_PROFILE=your-profile
packer build ubuntu-18.04.json
packer build -var 'aws_region=eu-west-3' ubuntu-18.04.json
```
