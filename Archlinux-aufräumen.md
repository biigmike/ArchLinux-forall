# Archlinux aufräumen
Diese Datei dient dazu, Informationen bereit zu stellen um ein Arch linux aufzuräumen und zu entschlacken.
(unnötige Pakete entfernen, Dateileichen zu entfernen die keiner mehr braucht,...)

## [Paccache](https://wiki.archlinux.de/title/Pacman#Paccache)
Paccache ist ein Werkzeug zur Bereinigung des Pacman-Cache /var/cache/pacman/pkg.

Archivierte Pakete können hiermit differenzierter als mit pacman -Scc bereinigt werden. Eine Übersicht der Möglichkeiten erhält man mit dem Befehl paccache -h. Zur Bereinigung des Paket-Cache kann man beispielsweise so vorgehen:

    du -sh /var/cache/pacman/pkg   # Belegung des Cache-Speicherplatzes prüfen
    paccache -dk2                  # Testdurchlauf; Wieviel Platz kann eingespart werden?
    paccache -vrk2                 # Entfernt Pakete aus dem Cache, behält die jüngsten 2 Versionen
    paccache -ruk0                 # Alle Pakete aus dem Cache entfernen, die nicht (mehr) installiert sind
Zur automatischen Bereinugung gibt es einen Systemd Timer. Bei aktiviertem Timer wird der Cache wöchentlich mit paccache -r bereinigt.

    systemctl enable paccache.timer
## Aus einem anderen [Blog](https://luyinsblog.wordpress.com/2018/01/30/arch-linux-aufraeumen/)
    pacman -Qet # zeigt explizit installierte (-e) Pakete, die von keinem anderen Paket gebraucht werden (-t); effektiv sind das alle vom User installierte Pakete
    pacman -Rs paketname    # deinstalliert das Paket  zusammen mit all seinen Abhängigkeiten, sofern diese ebenfalls nicht mehr benötigt werden
    pacman -Sc  # entfernt Pakete aus dem Package Cache ebenso wie nicht in Gebrauch befindliche Sync Datenbanken (falls man z. B. testing in pacman.conf aktiviert hatte und es inzwischen wieder deaktiviert hat, wird dadurch die Datenbank für testing entfernt)
    pacman -Rs $(pacman -Qdttq) # entfernt Pakete und ihre Abhängigkeiten, die als Abhängigkeiten installiert wurden (-d) und von keinem Paket benötigt werden; der doppelte Aufruf von -t bewirkt, dass optionale Abhängigkeiten nicht aufgeführt werden, sodass diese installiert bleiben
