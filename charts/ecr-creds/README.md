# ecr-creds

A Helm chart for Kubernetes with AWS ECR

## Usage

Run the following command to install this chart

- Using access key

```bash
cat > values.yaml <<EOF
targetPullSecretName: ecr-registry
targetNamespaces:
  - kube-addons
aws:
  account: "xxx"
  region: "us-east-1"
  credentials:
    accessKey: "xxx"
    secretKey: "xxx"
EOF

helm install --name ecr-creds zbytes/ecr-creds --values values.yaml
```

- Using IRSA

```bash
cat > sa-values.yaml <<EOF
serviceAccount:
  create: true
  name: ecr-creds-sa
  annotations:
    eks.amazonaws.com/role-arn: <irsa_arn>
targetPullSecretName: ecr-registry
targetNamespaces:
  - kube-addons
aws:
  account: "xxx"
  region: "us-east-1"
EOF

helm install --name ecr-creds zbytes/ecr-creds --values sa-values.yaml
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
