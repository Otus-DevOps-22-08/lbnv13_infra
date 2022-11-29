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

## HW-05
### Packer
Сконфигурирован загрузочный диск, чтобы ВМ загружалась из образа
Сконфигурирован полный загрузочный диск с работающим приложением
Параметризованы созданные шаблоны
Добавлен скрипт create-reddit-vm.sh для создания ВМ из готового образа с помощью Yandex.Cloud CLI

## HW-06
### Terraform-1
Установлен и инициализирован terraform
Добавлен main.tf для работы с yandex cloud
Все необходимые параметры передаются через teraform.tfvars
Добавлен load balancer lb.tf. Настроен dynamic "target"

## HW-07
### Terraform-2
Созданы модули
Добавлено разделение на stage и прод
Настроено хранение стейт файла в удаленном бекенде
Все необходимые параметры передаются через teraform.tfvars
Добавлен provisioner для деплоя приложения. Так же добавлена настройка для mongodb. Проверена работа приложения с БД

## HW-08
### Ansible-1
Установлен и настроен Ansible
Реализован простой плейбук
Написан python скрипт, позволяющий Ansible использовать dynamic inventory

## HW-09
### Ansible-2
Иcпользованы плейбуки, хендлеры и шаблоны для
конфигурации окружения и деплоя тестового приложения.
Использованы различные подходы (Один плейбук, много плейбуков)
Изменен провижн образов Packer на Ansible-плейбуки. Собраны новые образы.
Использован плагин инвентаризации Yandex cloud.
Использован функционал keyed_groups.
