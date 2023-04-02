## Formatting Terraform
```bash
terraform fmt -recursive
```

## Init Terraform
```bash
terraform init \
    -backend-config="bucket=vechr-iiot-tf-state" \
    -backend-config="prefix=terraform/state" \
    -backend-config="credentials=/Users/zulfikar4568/Downloads/vechr-iiot-dev-key.json"
```

## Apply the Configuration
```bash
cd providers/gcp/global
terraform apply -var-file=../stages/dev/terraform.tfvars
```