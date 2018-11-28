PREFIX=3838_ex_18_8988699_eric
LATEX=$(PREFIX).tex
ARCHIVE=$(PREFIX).zip
REPORT=$(PREFIX).pdf

all: $(ARCHIVE) $(REPORT)

clean:
	rm -f $(ARCHIVE) $(REPORT)

$(ARCHIVE): *.pl *.txt
	zip -FS $(ARCHIVE) $^

$(REPORT): $(LATEX)
	latexmk -pdf $(LATEX)

.PHONY: all clean
