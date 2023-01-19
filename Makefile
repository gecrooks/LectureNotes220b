
.DEFAULT_GOAL := help


# Kudos: Adapted from Auto-documenting default target
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-12s\033[0m %s\n", $$1, $$2}'


version: ## Extract version from git tag and write to version.tex
	git describe --tags > version.txt
	@git describe --tags


build:  version ## Build latex
	latexmk -xelatex  Lectures.tex


edit:  ## Open all tex documents
	open Lectures.tex
	open *.tex


bib: ## Copy citations from master bibliogrpahy to local bib file
	bibtool -s -d -x Lectures.aux ../../write/gec_bibliography/gec_bibliography.bib > Lectures_no_edit.bib


clean:	## Clean
	latexmk -C


.PHONY: help
