#!/usr/bin/env bash

set -e -u

useradd -m -G wheel,audio,video,storage,optical,network,power,input,render -s /bin/bash liveuser
passwd -d liveuser

mkdir -p /etc/sudoers.d
echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/liveuser-nopasswd
chmod 0440 /etc/sudoers.d/liveuser-nopasswd

systemctl enable sddm.service
systemctl enable NetworkManager.service
