HTML := $(shell find bower_components components -name \*.html -print)
JS := $(shell find bower_components components -name \*.js -print)

build: docs/index.html

build/: bower_components components index.html $(JS) $(HTML) polymer.json
	rm -r build; polymer build

docs/index.html: build/
	rm -r docs; cp -R build/bundled/ docs

docs/favicon.png: favicon.png
	cp favicon.png docs/

deps:
	bower install
	sudo npm install -g polymer-cli

watch:
	while true; do \
		make build; \
		inotifywait -qre close_write .; \
	done

clean:
	rm -r build/ docs/

.PHONY: build deps watch clean
