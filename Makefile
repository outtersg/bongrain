a_jour:
	f="`find . -type f -not -name a_jour -print0 | xargs -0 ls -tr | tail -1`" ; [ -z "$$f" ] || touch -r "$$f" $@

.PHONY: a_jour
