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
