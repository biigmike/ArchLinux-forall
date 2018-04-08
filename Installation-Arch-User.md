Arch Linux Installation für User (UEFI)

Partitionslayout
Setup:
Eine Festplatte /dev/sda für UEFI System - GPT Prtitionstabelle:
/dev/sda1 --> Label=BOOT --> EXT4 Dateisystem
--> Dateien für den Systemstart, Kernel, Initramfs

/dev/sda2 --> Labes=EFI --> EFI System Parition (ESP)

/dev/sda3 --> Label= ROOT --> Btrfs Dateisystem
Btrfs Subvolumes:	@	@home 	@pkg		@snapshots
--> Arch Linux System

/dev/sda4 --> Label=HOME --> XFS Dateisystem
--> Benutzerdaten

/dev/sda5 --> Label=SWAP --> Linux Swap
--> Auslagerungssspeicher für Ram/Hibernate

Partitionierung

Überprüfung EFI-Modus: efivar -l
Ermittlung der Festplatte: lsblk

gdisk

1. Partition (BOOT, ext4)
n, <Enter>, <Enter>, <Enter> , +300M, <Enter> (HexCode: 8300)

2. Partition (EFI, fat32)
n, <Enter>, <Enter>, <Enter> , +100M, ef00 (HexCode: ef00)

3. Partition (ROOT, btrfs)
n, <Enter>, <Enter>, <Enter> , +20-25G, <Enter> (HexCode: 8300)

4. Partition (HOME, xfs)
n, <Enter>, <Enter>, <Enter> , -1G (für Swap), <Enter> (HexCode: 8300)

5. Parition (SWAP, swap)
n, <Enter>, <Enter>, <Enter> , +300M, 8200 (HexCode: 8200)

Kontrolle: p (Print)

w (Write, Partitionstabelle schreiben)

Dateisysteme/Subvolumes erstellen

Dateisysteme erstellen

mkfs.ext4 -L BOOT /dev/sda1

mkfs.vfat -F 32 -n EFI /dev/sda2

mkfs.btrfs -L ROOT /dev/sda3

mkfs-xfs -L HOME /dev/sda4

mkswap -L SWAP /dev/sda5

swapon /dev/sda5 (Swap aktivieren)

Kontrolle: free -h

Subvolumes

mount /dev/sda3 /mnt

btrfs sub create /mnt/@

btrfs sub create /mnt/@pkg

btrfs sub create /mnt/@log

btrfs sub create /mnt/@snapshots

umount /mnt

Dateisystem ROOT erstellen/mounten

mount -o noatime,ssd,space_cache=v2,compress=lzo,subvol=@ /dev/sda3 /mnt

mkdir -p /mnt/{boot,home,var/log,var/cache/pacman/pkg,btrfs}

Kontrolle: ls /mnt

mount /dev/sda1 /mnt/boot/

mkdir /mnt/boot/efi

mount /dev/sda2 /mnt/boot/efi

mount /dev/sda4 /mnt/home

mount -o noatime,ssd,space_cache=v2,compress=lzo,subvol=@log /dev/sda3 /mnt/var/log/

mount -o noatime,ssd,space_cache=v2,compress=lzo,subvol=@pkg /dev/sda3 /mnt/var/cache/pacman/pkg

mount -o noatime,ssd,space_cache=v2,compress=lzo,subvolid=5 /dev/sda3 /mnt/btrfs

Kontrolle: df -Th

Base System installieren

pacstrap /mnt base base-devel bash-completion btrfs-progs dosfstools xfsprogs grub efibootmgr

fstab erstellen und ändern

genfstab -L /mnt >> /mnt/etc/fstab

gedit /mnt/etc/fstab

Bei den Einträgen nur subvol=@ oder subvol=@log stehen lassen, da die Namen der Subvolumes eindeutig sind.
Bei dem btrfs Mountpoint nur noch die subvolid=5 sehen lassen

...
Systemkonfiguration (extra Video)
...


Bootloader konfiguration

grub-mkconfig -o /boot/grub/grub.cfg

EFI (andere Varianten wie im Einsteigertutorial)

grub-install --target=x86_64-efi --efidirectory=/boot/efi

BIOS
grub-install /dev/sda

User anlegen
`useradd -m -g users -G wheel,audio,video -s /bin/bash <username>`

Passwort für user
`passwd <username>`

Sudo einrichten
`EDITOR=nano visudo`
Zeile mit %wheel ALL=[ALL] ALL auskommentieren

Nützliche Dienste installieren und aktivieren
`pacman -S acpid avahi cups cronie
systemctl enable avahi-daemon cups.cupsd.service cronie`

Zeiteinstellungen
`systemctl enable systemd-timesyncd.service`
Erst nach einem Neustart
`hwclock -w`

# XOrg Server installieren
(Anleitung für Einsteiger Vorlage)
`pacman -S xorg-server xorg-xinit`

## Grafikkarte
XF86-video-ati für ATI oder AMD-Grafikkarten
XF86-video-intel für Intel (onboard) Grafikkarten
XF86-video-nuovo (vermutlich schlechtester) Opensource Treiber für Nvidia Grafikkarten
pacman -S nvidia wäre der proprietäre Treiber

#XFCE4 installieren
`pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter networkmanager network-manager-applet nm-connection-editor alsa-tools alsa-utils pulseaudio-alsa pavucontrol

systemctl enable lightdm.service NetworkManager`

##Software installieren
`pacman -S chromium firefox
pacman -S gnome-keyring
pacman -S libreoffice-fresh libreoffice-fresh-de hunspell-de
pacman -S mpv qt4 vlc
pacman -S ttf-ubuntu-font-family ttf-liberation ttf-hana-zono ttf-droid ttf-freefont noto-fonts
pacman -S human-icon-theme elemetary-icon-theme arc-icon-theme faenza-icon-theme
pacman -S deepin-gtk-theme numix-gtk-theme
pacman-S gtk-engine-murrine
`

exit
umount -R /mnt
exit

REBOOT!

...
XFCE einrichten
...

sudo einrichten

als Root (via sudo)

nano /etc/systemd/journald.conf

--> Storage=volatile



btrfs sub list /btrfs/

bei einer SSD-Platte:
systemctl enable fstrim.timer
Snapperkonfiguration

/dev/sda3 --> Label= ROOT --> Btrfs Dateisystem
Btrfs Subvolumes:	@	@home 	@pkg		@snapshots
--> Arch Linux System

@.snapshots
@.snapshots/1/snapshot
...

@snapshots ==> /snapshots(Verzeichnis) ==> /etc/fstab
@snapshots/1/snapshot
...

Snapper installieren

pacman -S snapper

nano /etc/snapper/config-templates/default

NUMBER_CLEANUP="yes"
NUMBER_LIMIT="10"
NUMBER_LIMIT_IMPORTANT="5"

TIMELINE_CREATE="no"

EMPTY_PRE_POST_CLEANUP="yes"

snapper -c  root create-config /

btrfs sub list /btrfs/ (Subvolume @.snapshots wurde erstellt)

btrfs sub del /.snapshots

mkdir /.snapshots

nano /etc/fstab

Subvolume @snapshots auf /.snapshots mounten (Eintrag kopieren und anpassen)

mount /.snapshots
mkdir .AUR

cd .AUR/

sudo pacman -S git svn rsync wget linux-headers

Optional:
sudo nano /etc/makepkg.conf

MAKEFLAGS="9" (Zahl für Threads)

git clone <URL zu Git für grub-btrfs)

cd grub-btrfs

makepkg -rsi

less /etc/grub.d/41_snapshots-btrfs
ist nur die Vorlage
Befehle in grub.cfg kopieren

nano /etc/default/grub

(unter GRUB_CMDLINE_LINUX="")
GRUB_BTRFS_CREATE_ONLY_HARMONIZED_ENTRIES="true"
GRUB_BTRFS_LIMIT="20"


aus AUR update-grub installieren (siehe grub-btrfs)

sudo update-grub

aus AUR cower installieren (PGP Keys vorher herunterladen, steht in der Beschreibung, gpg --seachkeys <key>)

aus AUR pacaur installieren

pacaur -S pamac-aur

sudo pacman -S snap-pac

Pacman Hooks

unter /etc/pacman.d/hooks (Dateien newkernel.hook, newkernel.sh, oldkernel.hook, oldkernel.sh, siehe ZIP-Datei)

In Datei /etc/snapper/configs/root folgendes ändern
NUMBER_MIN_AGE="0"
NUMBER_LIMIT_IMPORTANT="2"
