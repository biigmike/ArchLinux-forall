# Arch Linux für Linux-Neulinge
# nach dem Video "Total Arch Linux | 3.4 Snapper auf die leichte Art!"
Arch Linux installieren für jemand der keine Ahnung von Linux hat und seinen Computer/Notebook einfach nur benutzen will.
Btrfs-Snapper-Pamac
***************
## Partitionierung
***************
### Einfachste Art
/dev/sda1* ==> Label=ROOT ==> Btrfs
Btrfs Subvolumes:      @     @home  @log	          @pkg                @snapshots
==> Arch Linux System  / -> /home -> /var/log -> /var/cache/pacman/pkg -> /.snapshots 

/dev/sda3 ==> Label=SWAP ==> Linux Swap

### Für Leute, die nur Anwender sind
/dev/sda1* ==> Label=ROOT ==> Btrfs

Btrfs Subvolumes:      @     @log	          @pkg                @snapshots

==> Arch Linux System  / -> /var/log -> /var/cache/pacman/pkg -> /.snapshots 

/dev/sda2 ==> Label=HOME ==> XFS

==> Benutzerdaten	/home

/dev/sda3 ==> Label=SWAP ==> Linux Swap

(Swapfile – XFS)

`grub install /dev/sda`

## Partitionierung/Formatierung
### Partitionieren mit fdisk
### Dateisysteme anlegen:
`mkfs.btrfs -L ROOT /dev/sda1
mkfs.xfs -L HOME /dev/sda2
mkswap -L SWAP /dev/sda3`

********************
## Subvolumes erstellen
********************
`mount /dev/sda1 /mnt`
`btrfs sub cr /mnt/@`
`btrfs sub cr /mnt/@log`
`btrfs sub cr /mnt/@pkg`
`btrfs sub cr /mnt/@snapshots`
`umount /mnt`

********************
## Dateisysteme mounten
********************
`mount -o relatime,space_cache=v2,ssd,compress=lzo,subvol=@ /dev/sda1 /mnt
mkdir -p /mnt/{home,var/log,var/cache/pacman/pkg,btrfs}
mount -o relatime,space_cache=v2,ssd,compress=lzo,subvol=@log /dev/sda1 /mnt/var/log
mount -o relatime,space_cache=v2,ssd,compress=lzo,subvol=@pkg /dev/sda1 /mnt/var/cache/pacman/pkg/
mount -o relatime,space_cache=v2,ssd,compress=lzo,subvolid=5 /dev/sda1 /mnt/btrfs
mount /dev/sda2 /mnt/home
swapon /dev/sda3`

***********************
# Arch Linux installieren
***********************
`pacstrap /mnt base base-devel bash-completion btrfs-progs xfsprogs dosfstools grub`

## fstab mit Labels generieren und nacharbeiten

`genfstab -Lp /mnt > /mnt/etc/fstab`

fstab nacharbeiten. Die ID's vom Btrfs rausnehmen und nur die subvols stehen lassen ausser bei subvolid=5.

## System Konfiguration
- In die Inatallation wechseln mit:
`arch-chroot /mnt/`
- Rechnernamen vergeben mit:
`echo arch-laptop > /etc/hostname`
- Spracheinstellungen festlegen: 
`echo LANG=de_DE.UTF-8 > /etc/locale.conf`
`echo LANGUAGE=de_DE >> /etc/locale.conf`
- Locales generieren:
Datei mit `nano /etc/locale.gen` öffnen und die Zeile `de_DE.UTF-8 UTF-8` das Kommentarteichen weg nehmen. Dann mit `locale-gen` die Locales generieren.
- Tastaturbelegung der Konsole einstellen mit: `echo KEYMAP=de-latin1-nodeadkeys > /etc/vconsole.conf`
- Zeitzone festlegen mit: `ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime`
- Pacman Konfiguration bearbeiten mit `nano /etc/pacman.conf` den Bereich für [Multilib] freischalten um 32-bit Programma ausführen zu können. Danach mit `pacman -Syu` das System updaten.
- Root Passwort vergeben mit `passwd`


************************
# Bootloader Konfiguration/Installation
************************

## Installation
Für EFI Installation:
`grub-install --target=x86_64-efi --efidirectory=/boot/efi`
Für BIOS Installation:
`grub-install /dev/sda`

## Konfiguration
`grub-mkconfig -o /boot/grub/grub.cfg`

**************************
## Optional die Fehlermeldung des Journallog beim Herunterfahren zu entfernen
**************************

In Datei /etc/systemd/journald.conf im Block [Journal] den Eintrag Storage=volatile setzen

# mkinitcpio konfigurieren
`nano /etc/mkinitcpio.conf`
In der Zeile "HOOKS=..."  am Ende das "fsck" weg machen und vor "filesystems" ein "btrfs" davor schreiben.
Sollte dann so aussehen:

"HOOKS="base udev autodetect modconf block btrfs filesystems keyboard"

# X-System installieren und Vorzugsweise XFCE
## User anlegen
Ein User mit mehreren Gruppen anlegen mit: `useradd -m -g users -G wheel,audio,video -s /bin/bash mike`
und dem User mit `passwd mike` ein Passwort zuweisen.
## Sudo konfigurieren
Sudo konfiguriert man mit: `EDITOR=nano visudo` und die Zeile `%wheel ALL=(ALL) ALL` auskommentieren,
damit die User der Gruppe wheel Sudo-Rechte haben.
## Nützliche Dienste installieren
Ein paar nützliche Dienste mit `pacman -S acpid avahi cups cronie`installieren.
Dienste startenmit `systemctl enable acpid avahi-daemon org.cups.cupsd.service cronie`
Zeitsyncronisation mit `systemctl enable systemd-timesyncd.service` starten.


**************************************
## Überprüfung ob alle Subvolumes da sind
**************************************
`sudo su
btrfs sub list /`

Es sollten da sein: @, @log, @pkg, @snapshots (@home)

Alles richtig gemountet:
`df -Th`

*******
#Snapper installieren
*******

`pacman -S Snapper`

Erstkonfiguration Snapper um snapshots von Root zu bekommen

`snapper -c root create-config /`

erstellt ein Subvolume .snapshots, was wir nicht gebrauchen können

`btrfs sub del /.snapshots/
mkdir /.snapshots
nano /etc/fstab`

In der fstab ein neuen Eintrag ertellen (einen von vorher kopieren) für /.snapshots (Subvolume @snapshots)

`mount /.snapshots/

snapper list`

sollte ein Eintrag mit single 0  root  current
erscheinen.

Programme aus AUR (AUR-Helper trizen):

- grub-btrfs
- snap-pac (Pacman Hooks für vorher/nachher Aktionen)
- snap-pac-grub (sorgt dafür, dass die Bootloaderkonfiguration neu geschrieben wird, damit die Snapshots im Bootloader auftauchen)

**********
#grub-Btrfs
**********
`less /etc/grub.d/41_snapshots-btrfs` (enthällt Erklärungen und möglicheOptionen, die man anwenden kann)

(2.Terminal)
`nano /etc/default/grub`
Einträge:
GRUB_BTRFS_CREATE_ONLY_HARMONIZED_ENTRIES="true"
GRUB_BTRFS_LIMIT="10"
hinzufügen.

Snapperconfig anpassen
`nano /etc/snapper/configs/root`

NUMBER_CLEANUP="yes"

NUMBER_MIN_AGE="0"
NUMBER_LIMIT="12"
NUMBER_LIMIT_IMPORTANT="3"

TIMLINE_CREATE="no" (!Sonst macht er jede Stunde einen Snapshot)

Prüfen ob cronie  läuft, weil Numbercleanup ist ein Cron-Job
`systemctl status cronie.service`

********
#snap-pac
********

Installiert Hooks, die Snapshots (vorher/nachher) auslösen.

*******************
#snap-pac-grub (AUR)
*******************

Sorgt dafür, dass nach einer pacman-Aktion die Bootloaderkonfiguration aktualisiert wird

***********************************
##ggf. Fehlende pgp-Keys installieren
***********************************

pgp --search-keys <ID> (ID=kopieren von "Unbekannter öffentlicher Schlüssel...")

Tippe "1" um zu importieren.

snapper list sollte dann schon ein paar Snapshots anzeigen.
