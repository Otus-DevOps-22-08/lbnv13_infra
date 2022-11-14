terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "otus.test"
    region     = "ru-central1"
    key        = "stage/terraform.tfstate"
    access_key = "YCAJEXDUoRE3RNlxUbUEbSTb9"
    secret_key = "YCMZLn97Ng-lg3L1TnRgA3bS-Ntm__oKb6CJBzFt"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
