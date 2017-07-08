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

true <<TERMINE
--- /tmp/Lato-Reg1.ttx	2017-07-08 02:27:47.000000000 +0200
+++ /tmp/Lato-Regm.ttx	2017-07-08 02:28:43.000000000 +0200
@@ -102,6 +102,7 @@
     <GlyphID id="274" name="tilde.case"/>
     <GlyphID id="275" name="hungarumlaut.case"/>
     <GlyphID id="276" name="caron.salt"/>
+    <GlyphID id="277" name="uni202F"/>
   </GlyphOrder>
 
   <head>
@@ -320,12 +321,12 @@
     <reserved2 value="0"/>
     <reserved3 value="0"/>
     <metricDataFormat value="0"/>
-    <numberOfHMetrics value="265"/>
+    <numberOfHMetrics value="266"/>
   </hhea>
 
   <maxp>
     <tableVersion value="0x5000"/>
-    <numGlyphs value="277"/>
+    <numGlyphs value="278"/>
   </maxp>
 
   <OS_2>
@@ -715,6 +716,7 @@
       <map code="0x2021" name="daggerdbl"/><!-- DOUBLE DAGGER -->
       <map code="0x2022" name="bullet"/><!-- BULLET -->
       <map code="0x2026" name="ellipsis"/><!-- HORIZONTAL ELLIPSIS -->
+      <map code="0x202f" name="uni202F"/><!-- NARROW NO-BREAK SPACE -->
       <map code="0x2030" name="perthousand"/><!-- PER MILLE SIGN -->
       <map code="0x2039" name="guilsinglleft"/><!-- SINGLE LEFT-POINTING ANGLE QUOTATION MARK -->
       <map code="0x203a" name="guilsinglright"/><!-- SINGLE RIGHT-POINTING ANGLE QUOTATION MARK -->
@@ -1109,6 +1111,7 @@
       <map code="0x2021" name="daggerdbl"/><!-- DOUBLE DAGGER -->
       <map code="0x2022" name="bullet"/><!-- BULLET -->
       <map code="0x2026" name="ellipsis"/><!-- HORIZONTAL ELLIPSIS -->
+      <map code="0x202f" name="uni202F"/><!-- NARROW NO-BREAK SPACE -->
       <map code="0x2030" name="perthousand"/><!-- PER MILLE SIGN -->
       <map code="0x2039" name="guilsinglleft"/><!-- SINGLE LEFT-POINTING ANGLE QUOTATION MARK -->
       <map code="0x203a" name="guilsinglright"/><!-- SINGLE RIGHT-POINTING ANGLE QUOTATION MARK -->
@@ -4803,6 +4806,9 @@
         <CharString name="uni02C9">
           -42 callgsubr
         </CharString>
+        <CharString name="uni202F">
+          -922 endchar
+        </CharString>
         <CharString name="uni2669">
           -1115 -18 callgsubr
           hstem
@@ -25090,6 +25096,7 @@
     <mtx name="uni00A0" width="386" lsb="0"/>
     <mtx name="uni00AD" width="694" lsb="100"/>
     <mtx name="uni02C9" width="614" lsb="20"/>
+    <mtx name="uni202F" width="193" lsb="0"/>
     <mtx name="uni2669" width="0" lsb="-2"/>
     <mtx name="v" width="1024" lsb="18"/>
     <mtx name="w" width="1532" lsb="14"/>
TERMINE
