# XFCE=Win-win-Situation

Rechtsklick auf Hintergrund → Schreibtischeinstellungen

Auf Reiter „Symbole“ kann man unten einstellen, welche Icons man auf dem Desktop sehen will.

Rechtsklick auf die obere Leiste → Leiste → Leisteneinstellungen…

Im Reiter „Erscheinungsbild“ die Einstellungen Alpha auf 90, Betreten auf 95 und Verlassen auf 60 stellen. Das Gleiche auch für die 2. Leiste (Pulldownmenu oben)

Leiste 2 → bei „Leiste automatisch verbergen“ auf „Intelligent stellen“

Im Reiter „Objekte“ der Leiste 1 aufs „+“ klicken und das Whisker-Menu hinzu fügen und in der Liste ganz nach oben schieben (erscheint dann auf der Leiste ganz links)
Das Standardmenu kann man löschen („-“)

Dann Rechtsklick auf Menu → Einstellungen. Im 2. Reiter „Verhalten“ unter Menu (oben) alle Checkboxen aktivieren

Im 1. Reiter „Aussehen“ den Regler der Deckkraft (ganz unten) auf 90.

Im 3. Reiter „Befehle“ alles raus nehmen, was nicht installiert ist (Alles bis auf „Alle Einstellungen“ und „Abmelden“).

Rechtsklick auf Name (Aktionsknöpfe) → Eigenschaften, die Aktionen, nur die Aktionen anhaken, die man braucht

Im Whiskermenu links neben der Suchleiste (oben) kommt man direkt in die Einstellungen.

In den „Feineinstellungen der Fensterverwaltung“ auf dem Reiter „Komposit“ (ganz rechts) den Punkt „Zeichnen mit der vertikalen Austastlücke synchronisieren“ anhaken (V-Sync).

Vom Whiskermenu das Terminal auf die obere Leiste schieben und Starter anlegen. Dann Rechtsklick auf den Starter → Eigenschaften und dann auf den Bleistift unten rechts. Unter „Befehl“ den Befehl „xfce4-terminal –drop-down“ eingeben.

In den Leisteneinstellungen im Reiter „Objekte“ 2 weitere Starter anlegen und in der Liste nach oben schieben (auf der Leiste wandern die Icons nach links). Dann den ersten Starter mit dem „+“ den Thunar Dateimanager und auf den 2. Starter den Internetbrowser seiner Wahl einstellen (Chrome, Chromium o.a.)

Rechtsklick auf Arbeitsflächen, 9 Arbeitsflächen in 3 Zeilen anordnen

Im Dropdown Terminal (Icon links neben dem Amwendungen Button) rechts unten auf den Button für die Einstllungen gehen.
Im Reiter Aufklapp die Breite auf 100% und die Deckkraft runter, damit man die Anwendungen im Hintergrund sehen kann (ca. 80%) Die oberen Punkte Fenster offen lassen…, Fenster immer im Vordergrund… und Sichtbares Fenster… angehakt lassen und den letzten Punkt Statussymbol… abwählen.

In den allgemeinen Einstellungen unter „Tastatur“ auswählen. Im Reiter „Tastaturbelegung“ sollte (falls noch nicht geschehen) die deutsche Tastatur angewählt sein.

Im Reiter „Tastenkürzel für Anwendungen“ den xfce4-appfinder auf das Tastaturkürzel Super+Alt (links) setzen.

Ein neuen Befehl mit Hinzufügen einfügen und dort xfce4-terminal –drop-down auf F12 legen.
Das selbe mit xfce4-terminal auf Strg+Alt+t legen

Im Terminal (Strg+Alt+t) auf Bearbeiten → Einstellungen gehen und im Reiter „Aussehen“ Den Hintergrund auf „Transparenter Hintergrund“ setzen und den Regler auf 0,80 schieben.

Noch ein neuer Befehl hinzufügen und unter Öffnen das Programm „Thunar“ (mit dem großen T) auswählen und auf Super+E

Nun in der Fensterverwaltung um Reiter Tastatur Fenster … kacheln auf Super+<Cursortaste> legen.

In den Leisteneinstellungen unter Leiste 2 alles löschen, was man nicht braucht (Verzeichnis Menu, Schreibtisch anzeigen, Trennelemente). Starter mit Aktionsknöpfe anlegen und editieren.

Neuen Starter -> Aktionsknöpfe in der untersten Leiste anlegen und editieren. Häkchen wegmachen, was man nicht braucht (mit den Aktionsknöpfen der oberen Leiste vergleichen)

In der oberen Leiste bei Benachrichtigungen den Haken bei Rahmen anzeigen entfernen. ggf. bei Uhr das Format ändern. Fensterknöpfe flach rein und Griff anzeigen raus. Fenster gruppert.

Software installieren: trizen vibrancy-colors arc-gtk-theme noto-fonts noto-emoji xfce4-pulseaudio-plugin pavucontrol

Unter Einstellungen->Erscheinungsbild das Thema Arc-Dark auswählen. Im Reiter Symbole Vibrancy-NonMono-Dark-Graphite auswählen. Im Reiter Schriften die Vorgabeschrift auf Noto Sans stellen und die Farbreihenfolge auf RGB und die Kantenglättung (Hint) auf Stark stellen. Dann zurück auf die Einstellungen.

Unter Fensterverwaltung die Titelschrift auf Noto Sans Bold setzen und die Anordnung der Knöpfe kontrollieren (Einrollen runter schieben). Und die Fensterdekoration (Thema) auf Arc-Dark. Dann wieder zurück auf alle Einstellungen.

In Feineinstellungen der Fesnterverwaltung den Reiter Platzierung öffnen und den oberen Regler ganz nach rechts schieben.

Terminal öffnen und in den Einstellungen die Schrift auf Noto Mono Regular ändern.

In der oberen Leiste bei den Einstellungen das Objekt PulseAudio Plugin hinzufügen 

Wallpaper einstellen/herunterladen

Um Netzwerkgeräte, Handys u.s.w. mounten zu können, folgende Software installieren:
trizen -S gvfs gvfs-smb gvfs-nfs gvfs-mtp gvfs-gphoto2 gvfs-afc mtpfs ifuse exfat-utils ntfs-3g f2fs-tools

In Einstellungen auf Wechseldatenträger- und Medieneinstellungen gehen. Im Reiter Datenträger die Häkchen bei Hotplug-Wechsellaufwerke automatisch einhängen, Wechselmedien beim Einlegen einhängen und Wechselmedien beim Einhängen öffnen anhaken.

Danach unter Einstellungen die Benachrichtigungen öffnen Ausblenden nach auf 5 sek setzen.

Im Thunar Dateimanager auf Bearbeiten->Benutzerdefinierte Aktionen... 




Arch Linux + Xfce = Win-win-Situation 30:33
