GIT_COMMIT := $(shell git show -s --format=%s)

install:
	pip install -r requirements.txt
start:
	mkdocs serve
build:
	mkdocs build
upload:
	git --git-dir=site/.git/ --work-tree=site/ add .
	git --git-dir=site/.git/ --work-tree=site/ commit -m "$(GIT_COMMIT)"
	git --git-dir=site/.git/ --work-tree=site/ push
	sleep 30
invalidate:
	aws cloudfront create-invalidation \
		--distribution-id E2SEWKKU6DXU4A \
		--paths "/*"
deploy: build upload invalidate
