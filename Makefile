# To make the document with the default settings:
# > make
#
# To make with a specific format:
# > make <format>
#
# To tar up a flat version of a specific format:
# > make <format> tar
#
# Alex Drlica-Wagner: https://github.com/DarkEnergyScienceCollaboration/start_paper/issues/new?body=@kadrlica

# Primary file names - avoid cookiecutter variables, to enable `make
# upgrade` to cleanly over-write this Makefile...

main=main
default=$(shell cat .metadata.json | grep 'default_format' | cut -d'"' -f4)
outname=$(notdir $(shell pwd))

# LATEX environment variables
export TEXINPUTS:=./texmf/styles/:./tables/:
export BSTINPUTS:=./texmf/bib/:

# Files to copy when making tarball

tardir=tmp
figdir=./figures
figures=$(figdir)/*.{png,jpg,pdf}
tabdir=./tables
tables=$(tabdir)/*.tex
styles=./texmf/styles/*.{sty,cls}
bibs=./texmf/bib/*.bst
source=$(main).{tex,bbl,bib} lsstdesc.bib authors.tex acknowledgments.tex
arxiv=\def\flag{mnras}
tarfiles=$(figures) $(tables) $(styles) $(bibs) $(source)

all: export flag=\def\flag{$(default)}
all: main copy

copy:
	cp ${main}.pdf ${outname}.pdf
touch:
	touch ${main}.tex
main :
	latexmk -g -pdf  \
	-pdflatex='openout_any=a pdflatex %O -interaction=nonstopmode "${flag}\input{%S}"'  \
	${main}

#tar : main
#	mkdir -p ${tardir}
#	cp ${tarfiles} ${tardir} | true
#	cp ${outname}.pdf ${tardir}/${outname}.pdf
#	cd ${tardir} && tar -czf ../${outname}.tar.gz . && cd ..
#	rm -rf ${tardir}

TARGETS=aastex62 apj apjl aj prd prl mnras tex jcappub
$(TARGETS): export flag = \def\flag{$(@)}
$(TARGETS):
	$(MAKE) -e main
	$(MAKE) -e copy
	$(MAKE) -e tar
tidy:
	rm -f *.log *.aux *.out *.dvi *.synctex.gz *.fdb_latexmk *.fls
	rm -f *.bbl *.blg *Notes.bib ${main}.pdf

clean: tidy
	rm -f ${outname}.pdf ${outname}.tar.gz

