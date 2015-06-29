##
## This Makefile is based on the one developed by Kieran Healy
## (https://github.com/kjhealy/pandoc-templates/blob/master/examples/Makefile)
## for expediting generation of HTML, LaTeX, and PDF output of articles.
##
## Be sure to edit, below -
## 	  1) whether to use a bib, and the path to the bibliography and CSL file
##    2) the path to the latex template you wish to use
##
## This script will generate a special latex file processed with pandoc-citeproc
## for conversion to docx; else, it'll use natbib to preserve all the citation
## data
##
## Author: Daniel Rothenberg
## Version: March 19, 2015

## Location of Pandoc support files.
PREFIX = /Users/daniel/tools/pandoc

## LaTeX template to use
LATEX_TEMPLATE = schwilk-ms-draft.latex

## LaTeX engine (be sure to match it with TEMPLATE)
LATEX_ENGINE = pdflatex

## Markdown extension (e.g. md, markdown, mdown)
MEXT = md

## Markdown format (for pandoc; e.g. markdown, markdown_strict, markdown_mmd, etc)
MD_FLAVOR = markdown

## Location of your working bibliography file
#BIB =
#BIB = /Users/daniel/Desktop/mendeley_bib.bib
BIB = example.bib

## CSL stylesheet (located in the csl folder of the PREFIX directory).
CSL = american-geophysical-union.csl

## Template for HTML output
HTML_TEMPLATE = healy-ms.html

## CSS for HTML output (as of now, paper/kultiad/kultiad-serif)
CSS = kultiad.css

###############################################################################

## Enable the bibliography options (citeproc) if a bibliography file was
## specified
ifndef BIB
	BIB_OPTS_PANDOC =
	BIB_OPTS_NATBIB = 
else
	BIB_OPTS_PANDOC = --filter pandoc-citeproc --csl=$(PREFIX)/csl/$(CSL) --bibliography=$(BIB)
	BIB_OPTS_NATBIB = --natbib --csl=$(PREFIX)/csl/$(CSL) --bibliography=$(BIB)
endif 

## Choose PDF options for latexmk
ifeq ($(LATEX_ENGINE), xelatex)
	PDF_OPTS = -xelatex
else
	PDF_OPTS = 
endif

## All markdown files in the working directory
SRC = $(wildcard *.$(MEXT))

PDFS=$(SRC:.$(MEXT)=.pdf)
HTML=$(SRC:.$(MEXT)=.html)
TEX=$(SRC:.$(MEXT)=.tex)
DOCX=$(SRC:.$(MEXT)=.docx)
TEX_DOCX=$(SRC:.$(MEXT)=.tex_docx)

.PHONY: clean

all:	$(PDFS) $(HTML) $(TEX)
pdf:	clean $(PDFS)
html:	clean $(HTML)
tex:	clean $(TEX)

docx:   clean $(TEX_DOCX) $(DOCX) 

ifdef BIB
	@echo Using bibliography file $(BIB) with style $(CSL)
endif

%.html:	%.$(MEXT)
	pandoc \
		-r $(MD_FLAVOR)+simple_tables+table_captions+yaml_metadata_block+tex_math_single_backslash \
		-w html \
		-S \
		--template=$(PREFIX)/templates/$(HTML_TEMPLATE) \
		--css=$(PREFIX)/css/$(CSS) \
		$(BIB_OPTS_PANDOC) \
		-o $@ $<

%.docx: %.tex_docx
	pandoc \
		-w docx -f latex -S -o $@ $<

%.tex_docx:	%.$(MEXT)
	pandoc \
		-r $(MD_FLAVOR)+simple_tables+table_captions+yaml_metadata_block+tex_math_single_backslash \
		-w latex \
		-s -S \
		--template=$(PREFIX)/templates/$(LATEX_TEMPLATE) \
		$(BIB_OPTS_PANDOC) \
		-o $@ $<

%.tex:	%.$(MEXT)
	pandoc \
		-r $(MD_FLAVOR)+simple_tables+table_captions+yaml_metadata_block+tex_math_single_backslash \
		-w latex \
		-s -S \
		--template=$(PREFIX)/templates/$(LATEX_TEMPLATE) \
		$(BIB_OPTS_NATBIB) \
		-o $@ $<

%.pdf:	%.tex
	latexmk -pdf $(PDF_OPTS) $<
	latexmk -c

clean:
	rm -f *.html *.pdf *.tex *.docx *.tex_docx *.fls
