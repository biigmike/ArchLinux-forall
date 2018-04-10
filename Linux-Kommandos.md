# Linux Kommandos für den Administrator

## Benutzer

### Benutzer anlegen

### neue Gruppe anlegen
`sudo groupadd <Gruppenname>`

### Benutzer eine (zusätzliche) Gruppe hinzufügen
`sudo usermod -aG <gruppenname> <username>`
(sieht man erst nach einer Neuanmeldung)

### Gruppen anzeigen
`groups <username>`

### Eigene Benutzerdaten anzeigen
`id <username>`
