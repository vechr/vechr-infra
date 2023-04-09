## Service Account Permission Needed
### For Admin Service Account
```
Storage Object Admin
```

### For service Account
Notes: `Service Account` User is to access default service account compute kubernetes
```
Compute Admin
Compute Network Admin
Compute Storage Admin
Kubernetes Engine Admin
Quota Administrator
Service Account Admin
Service Account User // to access default service account compute
Service Account Key Admin
Storage Object Admin
Cloud SQL Admin
```

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
terraform init -backend-config=backend.tfbackend
```

## Apply the Configuration
```bash
cd providers/gcp/global
terraform apply -var-file=../stages/dev/terraform.tfvars
```