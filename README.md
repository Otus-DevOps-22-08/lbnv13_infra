# lbnv13_infra
lbnv13 Infra repository

## HW-03
### connection command
ssh -i ~/.ssh/appuser -J appuser@178.154.202.148 appuser@10.128.0.8

### ssh someinternalhost
.ssh/config:
    Host someinternalhost
        HostName 10.128.0.8
        User appuser
        ProxyJump appuser@178.154.202.148

### https Pritunl Web
https://178.154.202.148.nip.io/

### VPN config
bastion_IP = 178.154.202.148
someinternalhost_IP = 10.128.0.8

## HW-04
### cloud-testapp
testapp_IP = 62.84.113.75
testapp_port = 9292

### yc command
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  ----metadata-from-file user-data=startup.yaml \
  --metadata serial-port-enable=1
