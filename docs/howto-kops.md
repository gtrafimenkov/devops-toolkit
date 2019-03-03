# Kops

- [Kops on AWS](#kops-on-aws)
	- [Creating a cluster](#creating-a-cluster)
		- [State bucket setup](#state-bucket-setup)
		- [Create cluster from scratch](#create-cluster-from-scratch)
		- [Create cluster from exising manifest](#create-cluster-from-exising-manifest)
- [How To](#how-to)
	- [How to export manifest of an existing cluster](#how-to-export-manifest-of-an-existing-cluster)

## Kops on AWS

https://github.com/kubernetes/kops/blob/master/docs/aws.md

### Creating a cluster

#### State bucket setup

```
aws s3api create-bucket --bucket dtk-kops-state --region us-east-1
aws s3api put-bucket-versioning --bucket dtk-kops-state --versioning-configuration Status=Enabled
aws s3api put-bucket-encryption --bucket dtk-kops-state --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'
```

```
export KOPS_STATE_STORE=s3://dtk-kops-state
```

#### Create cluster from scratch

```
export NAME=dtk-kops-01.k8s.local
kops create cluster --zones us-east-1a ${NAME}
kops create cluster \
    --zones us-east-1a \
    --master-count=1 \
    --node-count=1 \
    --node-size=t2.micro \
    --master-size=t2.micro
    ${NAME}
```

If you only want to create the manifest for later usage, add `--dry-run -o yaml` to `kops create cluster` command.

#### Create cluster from exising manifest

```
kops create -f ${NAME}.conf
```

## How To

### How to export manifest of an existing cluster

```
kops get $NAME -o yaml >${NAME}.conf
```
