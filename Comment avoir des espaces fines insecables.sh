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
--- /tmp/Lato-Reg1.ttx	2017-07-08 02:27:47.000000000 +0200
+++ /tmp/Lato-Regm.ttx	2017-07-08 02:28:43.000000000 +0200
@@ -102,196 +102,197 @@
     <GlyphID id="96" name="braceright"/>
     <GlyphID id="97" name="asciitilde"/>
     <GlyphID id="98" name="uni00A0"/>
-    <GlyphID id="99" name="exclamdown"/>
-    <GlyphID id="100" name="cent"/>
-    <GlyphID id="101" name="sterling"/>
-    <GlyphID id="102" name="currency"/>
-    <GlyphID id="103" name="yen"/>
-    <GlyphID id="104" name="brokenbar"/>
-    <GlyphID id="105" name="section"/>
-    <GlyphID id="106" name="dieresis"/>
-    <GlyphID id="107" name="copyright"/>
-    <GlyphID id="108" name="ordfeminine"/>
-    <GlyphID id="109" name="guillemotleft"/>
-    <GlyphID id="110" name="logicalnot"/>
-    <GlyphID id="111" name="uni00AD"/>
-    <GlyphID id="112" name="registered"/>
-    <GlyphID id="113" name="macron"/>
-    <GlyphID id="114" name="degree"/>
-    <GlyphID id="115" name="plusminus"/>
-    <GlyphID id="116" name="twosuperior"/>
-    <GlyphID id="117" name="threesuperior"/>
-    <GlyphID id="118" name="acute"/>
-    <GlyphID id="119" name="mu"/>
-    <GlyphID id="120" name="paragraph"/>
-    <GlyphID id="121" name="periodcentered"/>
-    <GlyphID id="122" name="cedilla"/>
-    <GlyphID id="123" name="onesuperior"/>
-    <GlyphID id="124" name="ordmasculine"/>
-    <GlyphID id="125" name="guillemotright"/>
-    <GlyphID id="126" name="onequarter"/>
-    <GlyphID id="127" name="onehalf"/>
-    <GlyphID id="128" name="threequarters"/>
-    <GlyphID id="129" name="questiondown"/>
-    <GlyphID id="130" name="Agrave"/>
-    <GlyphID id="131" name="Aacute"/>
-    <GlyphID id="132" name="Acircumflex"/>
-    <GlyphID id="133" name="Atilde"/>
-    <GlyphID id="134" name="Adieresis"/>
-    <GlyphID id="135" name="Aring"/>
-    <GlyphID id="136" name="AE"/>
-    <GlyphID id="137" name="Ccedilla"/>
-    <GlyphID id="138" name="Egrave"/>
-    <GlyphID id="139" name="Eacute"/>
-    <GlyphID id="140" name="Ecircumflex"/>
-    <GlyphID id="141" name="Edieresis"/>
-    <GlyphID id="142" name="Igrave"/>
-    <GlyphID id="143" name="Iacute"/>
-    <GlyphID id="144" name="Icircumflex"/>
-    <GlyphID id="145" name="Idieresis"/>
-    <GlyphID id="146" name="Eth"/>
-    <GlyphID id="147" name="Ntilde"/>
-    <GlyphID id="148" name="Ograve"/>
-    <GlyphID id="149" name="Oacute"/>
-    <GlyphID id="150" name="Ocircumflex"/>
-    <GlyphID id="151" name="Otilde"/>
-    <GlyphID id="152" name="Odieresis"/>
-    <GlyphID id="153" name="multiply"/>
-    <GlyphID id="154" name="Oslash"/>
-    <GlyphID id="155" name="Ugrave"/>
-    <GlyphID id="156" name="Uacute"/>
-    <GlyphID id="157" name="Ucircumflex"/>
-    <GlyphID id="158" name="Udieresis"/>
-    <GlyphID id="159" name="Yacute"/>
-    <GlyphID id="160" name="Thorn"/>
-    <GlyphID id="161" name="germandbls"/>
-    <GlyphID id="162" name="agrave"/>
-    <GlyphID id="163" name="aacute"/>
-    <GlyphID id="164" name="acircumflex"/>
-    <GlyphID id="165" name="atilde"/>
-    <GlyphID id="166" name="adieresis"/>
-    <GlyphID id="167" name="aring"/>
-    <GlyphID id="168" name="ae"/>
-    <GlyphID id="169" name="ccedilla"/>
-    <GlyphID id="170" name="egrave"/>
-    <GlyphID id="171" name="eacute"/>
-    <GlyphID id="172" name="ecircumflex"/>
-    <GlyphID id="173" name="edieresis"/>
-    <GlyphID id="174" name="igrave"/>
-    <GlyphID id="175" name="iacute"/>
-    <GlyphID id="176" name="icircumflex"/>
-    <GlyphID id="177" name="idieresis"/>
-    <GlyphID id="178" name="eth"/>
-    <GlyphID id="179" name="ntilde"/>
-    <GlyphID id="180" name="ograve"/>
-    <GlyphID id="181" name="oacute"/>
-    <GlyphID id="182" name="ocircumflex"/>
-    <GlyphID id="183" name="otilde"/>
-    <GlyphID id="184" name="odieresis"/>
-    <GlyphID id="185" name="divide"/>
-    <GlyphID id="186" name="oslash"/>
-    <GlyphID id="187" name="ugrave"/>
-    <GlyphID id="188" name="uacute"/>
-    <GlyphID id="189" name="ucircumflex"/>
-    <GlyphID id="190" name="udieresis"/>
-    <GlyphID id="191" name="yacute"/>
-    <GlyphID id="192" name="thorn"/>
-    <GlyphID id="193" name="ydieresis"/>
-    <GlyphID id="194" name="Aogonek"/>
-    <GlyphID id="195" name="aogonek"/>
-    <GlyphID id="196" name="Cacute"/>
-    <GlyphID id="197" name="cacute"/>
-    <GlyphID id="198" name="Eogonek"/>
-    <GlyphID id="199" name="eogonek"/>
-    <GlyphID id="200" name="dotlessi"/>
-    <GlyphID id="201" name="Lslash"/>
-    <GlyphID id="202" name="lslash"/>
-    <GlyphID id="203" name="Nacute"/>
-    <GlyphID id="204" name="nacute"/>
-    <GlyphID id="205" name="OE"/>
-    <GlyphID id="206" name="oe"/>
-    <GlyphID id="207" name="Sacute"/>
-    <GlyphID id="208" name="sacute"/>
-    <GlyphID id="209" name="Scaron"/>
-    <GlyphID id="210" name="scaron"/>
-    <GlyphID id="211" name="Ydieresis"/>
-    <GlyphID id="212" name="Zacute"/>
-    <GlyphID id="213" name="zacute"/>
-    <GlyphID id="214" name="Zdotaccent"/>
-    <GlyphID id="215" name="zdotaccent"/>
-    <GlyphID id="216" name="Zcaron"/>
-    <GlyphID id="217" name="zcaron"/>
-    <GlyphID id="218" name="florin"/>
-    <GlyphID id="219" name="circumflex"/>
-    <GlyphID id="220" name="caron"/>
-    <GlyphID id="221" name="uni02C9"/>
-    <GlyphID id="222" name="breve"/>
-    <GlyphID id="223" name="dotaccent"/>
-    <GlyphID id="224" name="ring"/>
-    <GlyphID id="225" name="ogonek"/>
-    <GlyphID id="226" name="tilde"/>
-    <GlyphID id="227" name="hungarumlaut"/>
-    <GlyphID id="228" name="pi"/>
-    <GlyphID id="229" name="endash"/>
-    <GlyphID id="230" name="emdash"/>
-    <GlyphID id="231" name="quoteleft"/>
-    <GlyphID id="232" name="quoteright"/>
-    <GlyphID id="233" name="quotesinglbase"/>
-    <GlyphID id="234" name="quotedblleft"/>
-    <GlyphID id="235" name="quotedblright"/>
-    <GlyphID id="236" name="quotedblbase"/>
-    <GlyphID id="237" name="dagger"/>
-    <GlyphID id="238" name="daggerdbl"/>
-    <GlyphID id="239" name="bullet"/>
-    <GlyphID id="240" name="ellipsis"/>
-    <GlyphID id="241" name="perthousand"/>
-    <GlyphID id="242" name="guilsinglleft"/>
-    <GlyphID id="243" name="guilsinglright"/>
-    <GlyphID id="244" name="fraction"/>
-    <GlyphID id="245" name="Euro"/>
-    <GlyphID id="246" name="trademark"/>
-    <GlyphID id="247" name="Omega"/>
-    <GlyphID id="248" name="partialdiff"/>
-    <GlyphID id="249" name="Delta"/>
-    <GlyphID id="250" name="product"/>
-    <GlyphID id="251" name="summation"/>
-    <GlyphID id="252" name="minus"/>
-    <GlyphID id="253" name="radical"/>
-    <GlyphID id="254" name="infinity"/>
-    <GlyphID id="255" name="integral"/>
-    <GlyphID id="256" name="approxequal"/>
-    <GlyphID id="257" name="notequal"/>
-    <GlyphID id="258" name="lessequal"/>
-    <GlyphID id="259" name="greaterequal"/>
-    <GlyphID id="260" name="lozenge"/>
-    <GlyphID id="261" name="uni2669"/>
-    <GlyphID id="262" name="fi"/>
-    <GlyphID id="263" name="fl"/>
-    <GlyphID id="264" name="undercommaaccent"/>
-    <GlyphID id="265" name="grave.case"/>
-    <GlyphID id="266" name="dieresis.case"/>
-    <GlyphID id="267" name="macron.case"/>
-    <GlyphID id="268" name="acute.case"/>
-    <GlyphID id="269" name="circumflex.case"/>
-    <GlyphID id="270" name="caron.case"/>
-    <GlyphID id="271" name="breve.case"/>
-    <GlyphID id="272" name="dotaccent.case"/>
-    <GlyphID id="273" name="ring.case"/>
-    <GlyphID id="274" name="tilde.case"/>
-    <GlyphID id="275" name="hungarumlaut.case"/>
-    <GlyphID id="276" name="caron.salt"/>
+    <GlyphID id="99" name="uni202F"/>
+    <GlyphID id="100" name="exclamdown"/>
+    <GlyphID id="101" name="cent"/>
+    <GlyphID id="102" name="sterling"/>
+    <GlyphID id="103" name="currency"/>
+    <GlyphID id="104" name="yen"/>
+    <GlyphID id="105" name="brokenbar"/>
+    <GlyphID id="106" name="section"/>
+    <GlyphID id="107" name="dieresis"/>
+    <GlyphID id="108" name="copyright"/>
+    <GlyphID id="109" name="ordfeminine"/>
+    <GlyphID id="110" name="guillemotleft"/>
+    <GlyphID id="111" name="logicalnot"/>
+    <GlyphID id="112" name="uni00AD"/>
+    <GlyphID id="113" name="registered"/>
+    <GlyphID id="114" name="macron"/>
+    <GlyphID id="115" name="degree"/>
+    <GlyphID id="116" name="plusminus"/>
+    <GlyphID id="117" name="twosuperior"/>
+    <GlyphID id="118" name="threesuperior"/>
+    <GlyphID id="119" name="acute"/>
+    <GlyphID id="120" name="mu"/>
+    <GlyphID id="121" name="paragraph"/>
+    <GlyphID id="122" name="periodcentered"/>
+    <GlyphID id="123" name="cedilla"/>
+    <GlyphID id="124" name="onesuperior"/>
+    <GlyphID id="125" name="ordmasculine"/>
+    <GlyphID id="126" name="guillemotright"/>
+    <GlyphID id="127" name="onequarter"/>
+    <GlyphID id="128" name="onehalf"/>
+    <GlyphID id="129" name="threequarters"/>
+    <GlyphID id="130" name="questiondown"/>
+    <GlyphID id="131" name="Agrave"/>
+    <GlyphID id="132" name="Aacute"/>
+    <GlyphID id="133" name="Acircumflex"/>
+    <GlyphID id="134" name="Atilde"/>
+    <GlyphID id="135" name="Adieresis"/>
+    <GlyphID id="136" name="Aring"/>
+    <GlyphID id="137" name="AE"/>
+    <GlyphID id="138" name="Ccedilla"/>
+    <GlyphID id="139" name="Egrave"/>
+    <GlyphID id="140" name="Eacute"/>
+    <GlyphID id="141" name="Ecircumflex"/>
+    <GlyphID id="142" name="Edieresis"/>
+    <GlyphID id="143" name="Igrave"/>
+    <GlyphID id="144" name="Iacute"/>
+    <GlyphID id="145" name="Icircumflex"/>
+    <GlyphID id="146" name="Idieresis"/>
+    <GlyphID id="147" name="Eth"/>
+    <GlyphID id="148" name="Ntilde"/>
+    <GlyphID id="149" name="Ograve"/>
+    <GlyphID id="150" name="Oacute"/>
+    <GlyphID id="151" name="Ocircumflex"/>
+    <GlyphID id="152" name="Otilde"/>
+    <GlyphID id="153" name="Odieresis"/>
+    <GlyphID id="154" name="multiply"/>
+    <GlyphID id="155" name="Oslash"/>
+    <GlyphID id="156" name="Ugrave"/>
+    <GlyphID id="157" name="Uacute"/>
+    <GlyphID id="158" name="Ucircumflex"/>
+    <GlyphID id="159" name="Udieresis"/>
+    <GlyphID id="160" name="Yacute"/>
+    <GlyphID id="161" name="Thorn"/>
+    <GlyphID id="162" name="germandbls"/>
+    <GlyphID id="163" name="agrave"/>
+    <GlyphID id="164" name="aacute"/>
+    <GlyphID id="165" name="acircumflex"/>
+    <GlyphID id="166" name="atilde"/>
+    <GlyphID id="167" name="adieresis"/>
+    <GlyphID id="168" name="aring"/>
+    <GlyphID id="169" name="ae"/>
+    <GlyphID id="170" name="ccedilla"/>
+    <GlyphID id="171" name="egrave"/>
+    <GlyphID id="172" name="eacute"/>
+    <GlyphID id="173" name="ecircumflex"/>
+    <GlyphID id="174" name="edieresis"/>
+    <GlyphID id="175" name="igrave"/>
+    <GlyphID id="176" name="iacute"/>
+    <GlyphID id="177" name="icircumflex"/>
+    <GlyphID id="178" name="idieresis"/>
+    <GlyphID id="179" name="eth"/>
+    <GlyphID id="180" name="ntilde"/>
+    <GlyphID id="181" name="ograve"/>
+    <GlyphID id="182" name="oacute"/>
+    <GlyphID id="183" name="ocircumflex"/>
+    <GlyphID id="184" name="otilde"/>
+    <GlyphID id="185" name="odieresis"/>
+    <GlyphID id="186" name="divide"/>
+    <GlyphID id="187" name="oslash"/>
+    <GlyphID id="188" name="ugrave"/>
+    <GlyphID id="189" name="uacute"/>
+    <GlyphID id="190" name="ucircumflex"/>
+    <GlyphID id="191" name="udieresis"/>
+    <GlyphID id="192" name="yacute"/>
+    <GlyphID id="193" name="thorn"/>
+    <GlyphID id="194" name="ydieresis"/>
+    <GlyphID id="195" name="Aogonek"/>
+    <GlyphID id="196" name="aogonek"/>
+    <GlyphID id="197" name="Cacute"/>
+    <GlyphID id="198" name="cacute"/>
+    <GlyphID id="199" name="Eogonek"/>
+    <GlyphID id="200" name="eogonek"/>
+    <GlyphID id="201" name="dotlessi"/>
+    <GlyphID id="202" name="Lslash"/>
+    <GlyphID id="203" name="lslash"/>
+    <GlyphID id="204" name="Nacute"/>
+    <GlyphID id="205" name="nacute"/>
+    <GlyphID id="206" name="OE"/>
+    <GlyphID id="207" name="oe"/>
+    <GlyphID id="208" name="Sacute"/>
+    <GlyphID id="209" name="sacute"/>
+    <GlyphID id="210" name="Scaron"/>
+    <GlyphID id="211" name="scaron"/>
+    <GlyphID id="212" name="Ydieresis"/>
+    <GlyphID id="213" name="Zacute"/>
+    <GlyphID id="214" name="zacute"/>
+    <GlyphID id="215" name="Zdotaccent"/>
+    <GlyphID id="216" name="zdotaccent"/>
+    <GlyphID id="217" name="Zcaron"/>
+    <GlyphID id="218" name="zcaron"/>
+    <GlyphID id="219" name="florin"/>
+    <GlyphID id="220" name="circumflex"/>
+    <GlyphID id="221" name="caron"/>
+    <GlyphID id="222" name="uni02C9"/>
+    <GlyphID id="223" name="breve"/>
+    <GlyphID id="224" name="dotaccent"/>
+    <GlyphID id="225" name="ring"/>
+    <GlyphID id="226" name="ogonek"/>
+    <GlyphID id="227" name="tilde"/>
+    <GlyphID id="228" name="hungarumlaut"/>
+    <GlyphID id="229" name="pi"/>
+    <GlyphID id="230" name="endash"/>
+    <GlyphID id="231" name="emdash"/>
+    <GlyphID id="232" name="quoteleft"/>
+    <GlyphID id="233" name="quoteright"/>
+    <GlyphID id="234" name="quotesinglbase"/>
+    <GlyphID id="235" name="quotedblleft"/>
+    <GlyphID id="236" name="quotedblright"/>
+    <GlyphID id="237" name="quotedblbase"/>
+    <GlyphID id="238" name="dagger"/>
+    <GlyphID id="239" name="daggerdbl"/>
+    <GlyphID id="240" name="bullet"/>
+    <GlyphID id="241" name="ellipsis"/>
+    <GlyphID id="242" name="perthousand"/>
+    <GlyphID id="243" name="guilsinglleft"/>
+    <GlyphID id="244" name="guilsinglright"/>
+    <GlyphID id="245" name="fraction"/>
+    <GlyphID id="246" name="Euro"/>
+    <GlyphID id="247" name="trademark"/>
+    <GlyphID id="248" name="Omega"/>
+    <GlyphID id="249" name="partialdiff"/>
+    <GlyphID id="250" name="Delta"/>
+    <GlyphID id="251" name="product"/>
+    <GlyphID id="252" name="summation"/>
+    <GlyphID id="253" name="minus"/>
+    <GlyphID id="254" name="radical"/>
+    <GlyphID id="255" name="infinity"/>
+    <GlyphID id="256" name="integral"/>
+    <GlyphID id="257" name="approxequal"/>
+    <GlyphID id="258" name="notequal"/>
+    <GlyphID id="259" name="lessequal"/>
+    <GlyphID id="260" name="greaterequal"/>
+    <GlyphID id="261" name="lozenge"/>
+    <GlyphID id="262" name="uni2669"/>
+    <GlyphID id="263" name="fi"/>
+    <GlyphID id="264" name="fl"/>
+    <GlyphID id="265" name="undercommaaccent"/>
+    <GlyphID id="266" name="grave.case"/>
+    <GlyphID id="267" name="dieresis.case"/>
+    <GlyphID id="268" name="macron.case"/>
+    <GlyphID id="269" name="acute.case"/>
+    <GlyphID id="270" name="circumflex.case"/>
+    <GlyphID id="271" name="caron.case"/>
+    <GlyphID id="272" name="breve.case"/>
+    <GlyphID id="273" name="dotaccent.case"/>
+    <GlyphID id="274" name="ring.case"/>
+    <GlyphID id="275" name="tilde.case"/>
+    <GlyphID id="276" name="hungarumlaut.case"/>
+    <GlyphID id="277" name="caron.salt"/>
   </GlyphOrder>
 
   <head>
     <!-- Most of this table will be recalculated by the compiler -->
     <tableVersion value="1.0"/>
     <fontRevision value="1.10400390625"/>
-    <checkSumAdjustment value="0xcb52cd16"/>
+    <checkSumAdjustment value="0xfb4d7e26"/>
     <magicNumber value="0x5f0f3cf5"/>
     <flags value="00000000 00000000"/>
     <unitsPerEm value="2000"/>
     <created value="Mon Sep 12 06:00:00 2011"/>
-    <modified value="Mon Sep 12 06:00:00 2011"/>
+    <modified value="Tue Dec 10 14:31:29 2013"/>
     <xMin value="-188"/>
     <yMin value="-365"/>
     <xMax value="2233"/>
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
