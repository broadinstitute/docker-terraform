.DEFAULT_GOAL := .uptodate

.uptodate: prom-run
	docker build -t quay.io/weaveworks/docker-terraform:$(shell ./tools/image-tag) .

prom-run:
	go build ./vendor/github.com/tomwilkie/prom-run

clean:
	rm -f .uptodate prom-run