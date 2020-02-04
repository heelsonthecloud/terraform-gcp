**Google Cloud Platformda Terraform ile Kaynak Oluşturma**

Google Cloud da bir proje oluşturuyoruz

 ```
 gcloud projects create [project-name]
 
 gcloud config set project [project-name]
 
 ```
ve oluşturduğumuz projede terraform scriptine yetki vermek için bir service account oluşturuyoruz.Bu service accounta proje düzeyinde editor yetkisi veriyoruz. Oluşturduğumuz service accounta bir anahtar oluşturup, anahtar json dosyasını bilgisayarımıza indiriyoruz. Bu dosyayı daha sonra yetki vermek için kullanacağız.

```
gcloud iam service-accounts create [service-account-name] 

gcloud iam service-accounts enable terra-demo@terraform-demo-2020.iam.gserviceaccount.com

gcloud projects add-iam-policy-binding terraform-demo-2020 --member serviceAccount:terra-demo@terraform-demo-2020.iam.gserviceaccount.com --role roles/editor

gcloud iam service-accounts keys create ~/key.json --iam-account terra-demo@terraform-demo-2020.iam.gserviceaccount.com

```
Proje için faturalandırmayı aktif edin (https://console.cloud.google.com/ >> IAM and admin >> Manage Resources >> Project >> Billing)

Compute Engine API ve Cloud DNS API aktive edin
```
gcloud services enable   compute.googleapis.com
gcloud services enable  dns.googleapis.com 

```
main.tf dosyasının bulunduğu dosyada 

```
terraform init 
terraform apply 
```
kodlarını çalıştırın









