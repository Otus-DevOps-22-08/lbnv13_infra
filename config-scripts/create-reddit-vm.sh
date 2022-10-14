#!/bin/bash
yc compute instance create \
  --name reddit-from-image \
  --hostname reddit-from-image \
  --memory=4 \
  --create-boot-disk image-id=fd8tpr0gdu2a9uqg1kim \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --ssh-key ~/.ssh/appuser.pub
