# Arch Linux persistent auf ein USB-Stick installieren

Link: https://github.com/r-darwish/alma/blob/master/README.md

Das Ganze passiert mit dem Tool alma(trizen -S alma)

Nach dem Befehl: 
sudo alma create /dev/disk/by-id/usb-Generic_USB_Flash_Disk-0:0

erhält man ein nacktes Arch Linux System, was vom USB-Stick aus gebootet werden kann.

Um das System einzudeutschen kann man das folgende Skript mit wget herunterladen:

wget https://raw.githubusercontent.com/biigmike/ArchLinux-forall/master/arch-deutsch.sh

Danach editiert man das Skript (z.B. mit nano) und fügt den gewünschten Hostnamen ein.
