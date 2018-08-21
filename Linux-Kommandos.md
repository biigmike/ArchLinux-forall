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
einfügt.

Um den Cups-Dienst neu zu starten benutzt man den Befehl: 
`systemctl restart org.cups.cupsd.service`

### Teamviwer verbinden
Als erstes muss der Teamviewer Daemon laufen 
`systemctl start teamviewerd`.
Um ein Passwort anzulegen führt man unter root den Befehl `teamviewer passwd <Passwort>`aus. Danach kann man mit  `teamviewer info` die TeamViwer ID rausbekommen mit der man sich verbinden kann.
