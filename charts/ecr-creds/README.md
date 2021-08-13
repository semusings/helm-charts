# ecr-creds

A Helm chart for Kubernetes with AWS ECR

# Usage

Run the following command to install this chart

```bash
helm install --name ecr-creds zbytes/ecr-creds \
--set-string aws.account=<aws_account_id> \
--set aws.region=<aws_region> \
--set aws.accessKeyId=<base64> \
--set aws.secretAccessKey=<base64> \
--set targetPullSecretName=my-regcred \
--set targetNamespace=['default']
```

In you kubernetes deployment use imagePullSecrets: my-regcred.

Example:

```yaml
apiVersion: apps/v1
kind: Deployment
spec:
  template:
    spec:
      imagePullSecrets:
        - name: aws-registry
    containers:
      - name: node
        image: node:latest
```