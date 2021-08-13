# ecr-creds

A Helm chart for Kubernetes with AWS ECR

# Usage

Run the following command to install this chart

```bash
helm install --name ecr-creds zbytes/ecr-creds \
--set-string aws.account=<aws_account_id> \
--set aws.region=<aws_region> \
--set aws.accessKeyId=<accessKeyId> \
--set aws.secretAccessKey=<secretAccessKey> \
--set targetPullSecretName=my-regcred \
--set targetNamespaces[0]=kube-system \
--set targetNamespaces[1]=kube-addons
```

In you kubernetes deployment use `imagePullSecrets: my-regcred`

Example:

```yaml
apiVersion: apps/v1
kind: Deployment
spec:
  template:
    spec:
      imagePullSecrets:
        - name: my-regcred
    containers:
      - name: pod-name
        image: pod-image:latest
```
