case `uname` in
# À FAIRE: Darwin
*)
copier()
{
	wl-copy "$@"
}
;;
esac

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
