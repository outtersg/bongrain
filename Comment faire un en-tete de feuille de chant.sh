#!/bin/sh

exit 0

Coins arrondis

Image sous Gimp.
Tout sélectionner.
Sélection -> Rectangle arrondi. 20 px pour une image en 1024 par exemple.
Ajouter à la sélection (Maj-sélection rectangle) les deux coins du bas.
Copier.
Nouveau calque (à fond transparent).
Coller.
Supprimer le calquer initial.
Exporter PNG.

Dégradé blanc.

Importer sous LO Draw.
Faire un rectangle blanc, traits blancs.
Propriétés -> Transparence -> dégradé linéaire -> 100 à 0%.
Le caler en taille et position sur le bas de l'image.
Ajouter 0,02 cm (1/5 de mm) de part et d'autre pour être sûr qu'on n'a pas 1/2 pixel qui déborde.

Mentions écrites

n=0
cat patronbis/en-tetes.txt | grep -v '^#' | while read taille x y texte
do
	n=`expr $n + 1`
	sed -e "s/@texte@/$texte/g" -e "s/@taille@/$taille/g" < texte.svg > /tmp/texte.svg
	f="Pictures/en-tete.$n.png"
	/Applications/Inkscape.app/Contents/Resources/bin/inkscape -f /tmp/texte.svg -D -d 300 -e "patron/$f"
done
