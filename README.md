**Terraform Google Cloud Platform Provider**

Create project in google cloud platform

 ```
 gcloud projects create [project-name]
 
 gcloud config set project [project-name]
 
 ```
In order to grant terraform script for google cloud resource provisioning create a service account. Grant this service account as project level editor. Create Service account key and download key as json. We will use this key in terraform script for granting access to google cloud platform

```
gcloud iam service-accounts create [service-account-name] 

gcloud iam service-accounts enable terra-demo@terraform-demo-2020.iam.gserviceaccount.com

gcloud projects add-iam-policy-binding terraform-demo-2020 --member serviceAccount:terra-demo@terraform-demo-2020.iam.gserviceaccount.com --role roles/editor

gcloud iam service-accounts keys create ~/key.json --iam-account terra-demo@terraform-demo-2020.iam.gserviceaccount.com

```
Activate billing for project (https://console.cloud.google.com/ >> IAM and admin >> Manage Resources >> Project >> Billing)

Enable Compute Engine API ve Cloud DNS API
```
gcloud services enable   compute.googleapis.com
gcloud services enable  dns.googleapis.com 

```
inside the project folder run below code  

```
terraform init 
terraform apply 
```









