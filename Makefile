a_jour:
	f="`find . -type f -not -name a_jour -print0 | xargs -0 ls -tr | tail -1`" ; [ -z "$$f" ] || touch -r "$$f" $@

patronbis/Pictures/rien.png:
	# png32: https://www.imagemagick.org/discourse-server/viewtopic.php?p=70078&sid=59cbe08579f0f308932d9eae4b9d58e7#p70078
	convert -size 1x1 xc:none -strip png32:$@

.PHONY: a_jour
