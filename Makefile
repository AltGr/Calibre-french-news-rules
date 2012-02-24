# Tests a recipe
# For rules needing args, set them in ARGS_<recipe_name> (for
# example, Mediapart needs a username/password, use
# export ARGS_mediapart="--username=Xxx --password=Yyy")
.PHONY: %-test
%-test: %.recipe
	if [ -e tests/$* ]; then \
	  mv tests/$* tests/$*-$(shell date -r tests/$* +"%F-%T"); \
	fi
	mkdir -p tests/$*
	ebook-convert $< tests/$* --test -vvvv --debug-pipeline tests/$*/debug $(ARGS_$*)
	if [ -f tests/$*/index.html ]; then firefox tests/$*/index.html; fi

%.mobi: %.recipe
	ebook-convert $< $@ -v $(ARGS_$*)

.PHONY: clean
clean:
	rm -rf tests/*
