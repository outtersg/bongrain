#!/bin/sh

exit 0

ttx -o /tmp/Lato-Reg.ttx ~/Library/Fonts/Lato-Reg.otf
ttx -o /tmp/Lato-Bol.ttx ~/Library/Fonts/Lato-Bol.otf

gzip ~/Library/Fonts/Lato-Reg.otf
gzip ~/Library/Fonts/Lato-Bol.otf

# On va utiliser le caractère uni00A0 (espace insécable) et en faire notre
# uni202F. On joue sur la width, et on doit juste s'assurer que la somme
# width - CharString reste la même que pour d'autres caractères (1115 sur
# le Reg, 1061 sur le Bol).
vi /tmp/Lato-*.ttx

ttx -o ~/Library/Fonts/Lato-Reg.otf /tmp/Lato-Reg.ttx
ttx -o ~/Library/Fonts/Lato-Bol.otf /tmp/Lato-Bol.ttx

# Pour vérifier, on peut reprendre une feuille.odt générée par ponds, et:

cd /tmp/
mkdir pouet
cd pouet
7za x /tmp/feuille.odt
# Remplacer le contenu par:
# <text:p text:style-name="Strophe">A||<text:line-break/>A|&#x2009;|<text:line-break/>A|&#x202f;|<text:line-break/>A|&#x2005;|<text:line-break/>A|&#x00a0;|<text:line-break/>A| |</text:p>
vi content.xml
# On peut aussi vi styles.xml pour grossir la police.
# Attention, https://bugs.freedesktop.org/show_bug.cgi?id=37531
7za a -tzip ../f.odt . ; /Applications/LibreOffice.app/Contents/MacOS/soffice --headless --convert-to pdf --outdir /tmp/ /tmp/f.odt ; scp /tmp/f.pdf l:/tmp/tmp/z.pdf
