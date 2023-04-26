## `Service Account Permission Needed`
### a. For Admin Service Account
```
Storage Object Admin
```

### b. For service Account
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

## c. Enable the Resource First
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
## `WITH TERRAGRUNT`
Combination of Terrafrom and Terragrunt
### a. Plan and Apply
```bash
./execute.sh plan production
./execute.sh apply production
```