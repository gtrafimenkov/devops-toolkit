# k8s shell tips

## Trigger new deployment rollout

```
kubectl patch deployment nginx -p "{\"spec\":{\"template\":{\"metadata\":{\"annotations\":{\"date\":\"`date +'%s'`\"}}}}}"
```
