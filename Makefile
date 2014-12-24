all: build

cabal.sandbox.config:
	cabal sandbox init --sandbox=../hakyll-sandbox

build: dist/build/blog/blog
	./dist/build/blog/blog build

dist/build/blog/blog: Main.hs cabal.sandbox.config
	cabal build
	./dist/build/blog/blog clean

new:
	@./new_post.sh

publish: build
	git stash save
	git checkout publish
	mkdir _source
	find . -maxdepth 1 ! -name _source ! -name . ! -name .git -exec mv '{}' _source/ \;
	cp -r _source/_site/* ./
	rm -fr _source
	git add -A . && git commit -m "Publish" || true
	rm -fr ./*
	git push pub publish:master
	git checkout master
	git checkout -- .
	git stash pop || true

preview: hakyll
	./hakyll preview -p 9000

clean: hakyll
	./hakyll clean
