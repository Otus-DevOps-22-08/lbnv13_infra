terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "otus.test"
    region     = "ru-central1"
    key        = "stage/terraform.tfstate"
    access_key = "secretkey"
    secret_key = "secretkey-secretkey-secretkey"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
