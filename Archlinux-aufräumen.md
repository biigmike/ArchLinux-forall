#Archlinux aufräumen
Diese Datei dient dazu, Informationen bereit zu stellen um ein Arch linux aufzuräumen und zu entschlacken.
(unnötige Pakete entfernen, Dateileichen zu entfernen die keiner mehr braucht,...)

##Paccache(like https://wiki.archlinux.de/title/Pacman#Paccache)
Paccache ist ein Werkzeug zur Bereinigung des Pacman-Cache /var/cache/pacman/pkg.

Archivierte Pakete können hiermit differenzierter als mit pacman -Scc bereinigt werden. Eine Übersicht der Möglichkeiten erhält man mit dem Befehl paccache -h. Zur Bereinigung des Paket-Cache kann man beispielsweise so vorgehen:

    du -sh /var/cache/pacman/pkg   # Belegung des Cache-Speicherplatzes prüfen
    paccache -dk2                  # Testdurchlauf; Wieviel Platz kann eingespart werden?
    paccache -vrk2                 # Entfernt Pakete aus dem Cache, behält die jüngsten 2 Versionen
    paccache -ruk0                 # Alle Pakete aus dem Cache entfernen, die nicht (mehr) installiert sind
Zur automatischen Bereinugung gibt es einen Systemd Timer. Bei aktiviertem Timer wird der Cache wöchentlich mit paccache -r bereinigt.

    systemctl enable paccache.timer
