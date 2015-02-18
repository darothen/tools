
.PHONY: hudson2014 view clean

hudson2014: hudson2014.tex
	latexmk -xelatex -use-make hudson2014.tex
	open hudson2014.pdf

hudson2014.tex: hudson2014.md
	pandoc -s -S --template=latex.template -o hudson2014.tex hudson2014.md

view:
	open hudson2014.pdf

clean:
	latexmk -CA