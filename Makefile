a_jour:
	f="`find . -type f -not -name a_jour -print0 | xargs -0 ls -tr | tail -1`" ; [ -z "$$f" ] || touch -r "$$f" $@

patronbis/Pictures/rien.png:
	convert -size 1x1 xc:none -alpha Transparent $@

.PHONY: a_jour
