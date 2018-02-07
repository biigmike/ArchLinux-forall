#!/bin/bash
loadkeys de-latin1-nodeadkeys
echo raspi3-arch > /etc/hostname

echo LANG=de_DE.UTF-8 > /etc/locale.conf
echo LC_COLLATE=C >> /etc/locale.conf
echo LANGUAGE=de_DE >> /etc/locale.conf
nano /etc/locale.gen

locale-gen

echo KEYMAP=de-latin1 > /etc/vconsole.conf
echo FONT=lat9w-16 >> /etc/vconsole.conf

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
