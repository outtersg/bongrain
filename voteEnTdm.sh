#!/bin/sh

set -e

DelieS() { local s2 ; while [ -h "$s" ] ; do s2="`readlink "$s"`" ; case "$s2" in [^/]*) s2="`dirname "$s"`/$s2" ;; esac ; s="$s2" ; done ; } ; SCRIPTS() { local s="`command -v "$0"`" ; [ -x "$s" -o ! -x "$0" ] || s="$0" ; case "$s" in */bin/*sh) case "`basename "$s"`" in *.*) true ;; *sh) s="$1" ;; esac ;; esac ; case "$s" in [^/]*) s="`pwd`/$s" ;; esac ; DelieS ; s="`dirname "$s"`" ; DelieS ; SCRIPTS="$s" ; } ; SCRIPTS

CHANTS="$SCRIPTS/../Chants"
ODS2CSV="php ../../../util-php/tableur/xlsx2csv.php"
TMP=/tmp/temp.$$.voteEnTdm

listerFichiers()
{
	local f t
	( cd "$CHANTS" && find . -name "*.txt" ) | sed -e 's#^\./##' | while read f
	do
		t="`head -1 < "$CHANTS/$f"`"
		printf "%s;%s\n" "$f" "$t"
	done
}

chercherFichiers()
{
	local f t r=0 n
	IFS=\;
	while read f t
	do
		unset IFS
		if [ -n "$f" ]
		then
			# Si un fichier est indiqué, assurons-nous de sa validité.
			if [ ! -e "$CHANTS/$f" ]
			then
				echo "# $f introuvable." >&2
				r=1
			else
				echo "$f"
			fi
		else
			# Sinon voyons si un fichier correspond au titre donné.
			n="`grep -Fi ";$t" < "$TMP.chants" | wc -l | tr -d ' 	'`"
			case "$n" in
				0) echo "# Aucun fichier trouvé pour: $t" >&2 ; r=1 ;;
				1) IFS=\; ; grep -Fi ";$t" < "$TMP.chants" | while read f t ; do echo "$f" ; done ; unset IFS ;;
				*) echo "# $n fichiers trouvés pour: $t" >&2 ; r=1 ;;
			esac
		fi
		IFS=\;
	done > "$TMP.fichiers.vrac"
	unset IFS
	
	[ "$r" -eq 0 ] || return $r
	
	sort -u < "$TMP.fichiers.vrac" | awk '{print NR"\t"$0}' > "$TMP.fichiers"
	
	echo "`wc -l < "$TMP.fichiers" | tr -d ' 	'` chants constitueront le livret."
}

faire()
{
	listerFichiers > $TMP.chants
	
	local source="$1" dest="$2" csv="`echo "$1" | sed -e 's/\.ods$/.csv/'`"
	$ODS2CSV "$source"
	egrep ';"\[O\]|;"?Sélection"?;' < "$csv" | php -r '$l = fgetcsv(STDIN, 0, ";"); foreach($l as $col => $val) if($val == "Titre" && !isset($ct)) $ct = $col; else if($val == "Fichier") $cf = $col; if(!isset($ct)) throw new Exception("Colonne Titre introuvable dans ".implode(";", $l)); while(($l = fgetcsv(STDIN, 0, ";"))) echo (isset($cf) ? $l[$cf] : "").";".$l[$ct]."\n";' | chercherFichiers
	
	cat "$TMP.fichiers" > "$dest"
}

faire "$@"
