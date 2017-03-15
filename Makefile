.DEFAULT_GOAL := .uptodate

.uptodate: prom-run
	docker build -t quay.io/weaveworks/docker-terraform:$(shell ./tools/image-tag) .

prom-run:
	go version
	git submodule update --init
	go build ./src/prom-run

clean:
	rm -f .uptodate prom-run