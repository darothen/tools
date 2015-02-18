
## This Makefile is based on the one developed by Kieran Healy
## (https://github.com/kjhealy/pandoc-templates/blob/master/examples/Makefile)
## for expediting generation of HTML, LaTeX, and PDF output of articles.
## Be sure to edit, below -
## 	  1) whether to use a bib, and the path to the bibliography and CSL file
##    2) the path to the latex template you wish to use

## Location of Pandoc support files.
PREFIX = /Users/daniel/tools/pandoc

## LaTeX template to use
LATEX_TEMPLATE = xelatex_simple.template

## LaTeX engine (be sure to match it with TEMPLATE)
LATEX_ENGINE = xelatex
 
## Markdown extension (e.g. md, markdown, mdown)
MEXT = md

## Location of your working bibliography file
#BIB =
BIB = "/Users/daniel/Documents/General Exam.bib"

## CSL stylesheet (located in the csl folder of the PREFIX directory).
CSL = ams

## Template for HTML output
HTML_TEMPLATE = html_kjh.template

## CSS for HTML output (as of now, paper/kultiad/kultiad-serif)
CSS = kultiad

#######################################

## Enable the bibliography options (citeproc) if a bibliography file was
## specified
ifndef BIB
	BIB_OPTS = 
else
	BIB_OPTS = --filter pandoc-citeproc --csl=$(CSL).csl --bibliography=$(BIB)
endif 

## All markdown files in the working directory
SRC = $(wildcard *.$(MEXT))

PDFS=$(SRC:.md=.pdf)
HTML=$(SRC:.md=.html)
TEX=$(SRC:.md=.tex)

.PHONY: clean

all:	$(PDFS) $(HTML) $(TEX)
pdf:	clean $(PDFS)
html:	clean $(HTML)
tex:	clean $(TEX)
ifdef BIB
	@echo Using bibliography file $(BIB) with style $(CSL).csl
endif

%.html:	%.md
#@echo Generating HTML output
	pandoc \
		-r markdown+simple_tables+table_captions+yaml_metadata_block \
		-w html \
		-S \
		--template=$(PREFIX)/templates/$(HTML_TEMPLATE) --css=$(PREFIX)/templates/$(CSS).css \
		$(BIB_OPTS) \
		-o $@ $<

%.tex:	%.md
#@echo Converting from Markdown to LaTeX
	pandoc \
		-r markdown+simple_tables+table_captions+yaml_metadata_block \
		-w latex \
		-s -S \
		--latex-engine=$(LATEX_ENGINE) \
		--template=$(PREFIX)/templates/$(LATEX_TEMPLATE) \
		$(BIB_OPTS) \
		-o $@ $<

%.pdf:	%.md
#@echo Generating PDF from LaTeX (via $(LATEX_ENGINE))
	pandoc \
		-r markdown+simple_tables+table_captions+yaml_metadata_block \
		-s -S \
		--latex-engine=$(LATEX_ENGINE) \
		--template=$(PREFIX)/templates/$(LATEX_TEMPLATE) \
		$(BIB_OPTS) \
		-o $@ $<

clean:
#	latexmk -CA
	rm -f *.html *.pdf *.tex