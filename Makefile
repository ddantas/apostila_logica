
FILENAME = logica


all: $(FILENAME).pdf

dvi: $(FILENAME).dvi

ps: $(FILENAME).ps

$(FILENAME).ps: $(FILENAME).dvi
	dvips -o $(FILENAME).ps $(FILENAME).dvi

$(FILENAME).pdf: *.tex
	pdflatex $(FILENAME).tex
	bibtex $(FILENAME)
	pdflatex $(FILENAME).tex
	pdflatex $(FILENAME).tex
	evince $(FILENAME).pdf

show:
	evince $(FILENAME).pdf

$(FILENAME).dvi: clean $(FILENAME).tex
	echo "Running latex..."
	latex $(FILENAME).tex
	echo "Running makeindex..."
	#makeindex $(FILENAME).idx
	echo "Rerunning latex...."
	latex $(FILENAME).tex
	latex_count=5 ; \
	while egrep -s 'Rerun (LaTeX|to get cross-references right)' refman.log && [ $$latex_count -gt 0 ] ;\
	    do \
	      echo "Rerunning latex...." ;\
	      latex $(FILENAME).tex ;\
	      latex_count=`expr $$latex_count - 1` ;\
	    done

clean:
	rm -f *.ps *.dvi *.aux *.toc *.idx *.ind *.ilg *.log *.out *.brf *.blg *.bbl $(FILENAME).pdf
