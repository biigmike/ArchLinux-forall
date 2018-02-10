# Snapper-Rollback unter Arch-linux

## Anzeige von Snapshots

`sudo snapper list`

zeigt die Liste aller Snapshots

## Snapshots vergleichen
`sudo snapper diff 3..4`

listet die Unterschiede zwischen Snapshots (3 und 4) auf.

## Unterschiede rückgängig machen
`sudo snapper undochange 3..4`
