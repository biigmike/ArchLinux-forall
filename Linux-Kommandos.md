# Linux Kommandos für den Administrator

## Benutzer

### Benutzer anlegen
`useradd -m -g users -G wheel,audio,video -s /bin/bash <username>`
### neue Gruppe anlegen
`sudo groupadd <Gruppenname>`

### Benutzer eine (zusätzliche) Gruppe hinzufügen
`sudo usermod -aG <gruppenname> <username>`
(sieht man erst nach einer Neuanmeldung)

### Gruppen anzeigen
`groups <username>`

### Eigene Benutzerdaten anzeigen
`id <username>`

### Cups - Drucker angehalten
auf Konsole den Befehl:
`cupsenable <druckername>`
aufrufen. Es könnte sein, dass der Netzwerkdrucker angehalten wird, wenn er nach Ablauf eines Timeouts nicht mehr gefunden wurde. Das ganze kann man unterdrücken, wenn man in der Konfigurationsdatei /etc/cups/cupsd.conf die Zeile:
`Timeout 0` 
einfügt
