build_dev:
	$(MAKE) compile_static

	# empty manifest
	cp src/manifest-dev.appcache docs/manifest.appcache
	echo "# Updated $(shell date +%x_%H:%M:%S:%N)" >> docs/manifest.appcache
	
	# run webpack
	./node_modules/webpack/bin/webpack.js --watch -d --output-public-path ./ --output-path ./docs

compile_static:
	# clear out existing docs folder
	rm -rf ./docs
	mkdir ./docs

	# compile l10n files
	for f in src/l10n/*.ini; do (cat "$${f}"; echo) >> docs/data.ini; done
	
	# copy over static assets
	cp -r src/img src/opensource.htm src/help.htm src/privacy.htm docs/
	cp ./node_modules/jakecache/dist/jakecache.js ./node_modules/jakecache/dist/jakecache-sw.js docs/
	mkdir docs/help
	mv docs/help.htm docs/help/index.html	
	mkdir docs/privacy
	mv docs/privacy.htm docs/privacy/index.html

build_prod:
	$(MAKE) compile_static

	# manifest
	cp -r src/manifest.appcache docs/
	echo "# Updated $(shell date +%x_%H:%M:%S:%N)" >> docs/manifest.appcache
	
	# run webpack
	./node_modules/webpack/bin/webpack.js -p --output-public-path ./ --output-path ./docs