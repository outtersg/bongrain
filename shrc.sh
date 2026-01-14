case `uname` in
# À FAIRE: Darwin
*)
copier()
{
	wl-copy "$@"
}
;;
esac

# Cherche parmi les .txt ceux contenant certains termes.
# Utilisation:
#   chercher [xxx.tdm] <regex>
#     xxx.tdm
#       Si précisé, les résultats sont collés comme commentaires à la fin du fichier .tdm (Table Des Matières) mentionné, sous forme "# .txt Titre: " (les : pour permettre ensuite de commenter le choix du chant).
#     <regex>
#       Expression régulière à retrouver dans les fichiers.
chercher()
{
	# À FAIRE: on pourrait carrément mettre les extraits trouvés dans la .tdm.
	local tdm chant
	case "$1" in *.tdm) tdm="$1" ; shift ;; esac
	local rech="$1"
	[ -z "$tdm" ] || ugrep -il "$rech" *.txt 2> /dev/null | while read chant
	do
		echo "#   $chant `head -1 < "$chant"`: "
	done | sort >> "$tdm"
	ugrep -i --pretty=always "$rech" *.txt 2> /dev/null | LESSCHARDEF=8bcccbcc18b. less
}

# Inspecter plusieurs chants
# Voir leur contenu, après en avoir copié chemin et titre qui pourront être collés dans une pré-table des matières (liste de chants candidats).
v()
{
	local f
	for f in "$@"
	do
		printf "%s %s: \n" "$1" "`head -1 < "$1"`" | copier # copier -p?
		vim "$1"
	done
}

# .tdm → liste HTML
html2tdm()
{
	# pandoc -f markdown -t html # https://www.reddit.com/r/linuxquestions/comments/gzoxy5/markdown_to_clipboard_rich_text_wwayland/
	sed -E -e '/^#  *[^ ]*\.txt /!d' -e 's//- **/' -e 's/:|$/**/' < 2026-01-08.tdm | pandoc -f markdown -t html | copier -t text/html
}
