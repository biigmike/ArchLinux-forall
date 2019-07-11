# X-Window-System installieren nach dem Video der Serie Total Arch Linux von unicks.eu
## Neuen User anlegen
`useradd -m -g users -G wheel,audio,video -s /bin/bash <username>`
und das Passwort festlegen:
`passwd <username>`

## Sudo installieren und konfigurieren
mit `pacman -S sudo` Sudo installieren und mit `EDITOR=nano visudo` die Sudoers Datei ändern. 
Die Zeile mit `%wheel ALL=(ALL) ALL` auskommentieren.
Dann mit CTRL+X und Y speichern und verlassen.

## Nützliche Dienste installieren
### ACPID
ist für die Energieverwaltung da
### AVAHI
ist für Netzwerkerkennung da
### Cups
ist für Druckerdienste da
### Cronnie
ist für Zeitgesteuerte Vorgänge da

Mit `pacman -S acpid avahi cups cronie` installieren und mit `systemctl enable acpid avahi-daemon org.cups.cupsd.service cronie` aktivieren.

### Automatische Zeiteinstellung
mit `date` das Datum kontrollieren und dann mit `hwclock -w` aktivieren (Nähere Infos siehe Einsteigerguide unter "Automatische Zeiteinstellung".

## X-Server installieren
`pacman -S xorg-server xorg-xinit xorg-drivers`

## XFCE-Desktopumgebung und einige Programme
`pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter bash-completion networkmanager network-manager-applet nm-connection-editor 
alsa-tools alsa-utils pulseaudio-alsa pavucontrol`
Bei Abfrage alle Pakete installieren.
Danach einige Services aktivieren mit `systemctl enable lightdm.service NetworkManager`
Einige Tools:
`pacman -S firefox firefox-i18n-de chromium gnome-keyring libreoffice-fresh libreoffice-fresh-de hunspell mpv qt4 vlc`

Und dann evtl. noch einige Fonts mit `pacman -S ttf-ubuntu-font-family ttf-liberation ttf-hanazono ttf-droid ttf-freefont noto-fonts`

Und einige Icon Themes: `pacman -S human-icon-theme elementary-icon-theme arc-icon-theme faenza-icon-theme`

GTK Thema: `pacman -S deepin-gtk-theme numix-gtk-theme gtk-engine-murrine`
