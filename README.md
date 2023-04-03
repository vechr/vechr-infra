## Enable the Resource First
```bash
gcloud services enable \
    cloudresourcemanager.googleapis.com \
    compute.googleapis.com \
    iam.googleapis.com \
    container.googleapis.com \
    servicenetworking.googleapis.com \
    sqladmin.googleapis.com \
    networkservices.googleapis.com
```

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