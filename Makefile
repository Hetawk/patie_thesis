# Makefile for UJN Thesis Project
# Simple build system for LaTeX thesis compilation

# Configuration
MAIN = main
BIB = reference
LATEX = /Library/TeX/texbin/xelatex -interaction=nonstopmode
BIBER = /Library/TeX/texbin/biber

# Default target - build main thesis
all: main

# Build main thesis - force rebuild
main:
	@echo "Building UJN thesis (forced rebuild)..."
	-$(LATEX) $(MAIN)
	-$(BIBER) $(MAIN)
	-$(LATEX) $(MAIN)
	-$(LATEX) $(MAIN)
	@echo "Thesis built: $(MAIN).pdf"

# Build PDF (alias for main target)
pdf: main

# Build main thesis with dependency checking (only rebuild if needed)
main-check: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex chapter/*.tex $(BIB).bib
	@echo "Building UJN thesis (dependency-based)..."
	-$(LATEX) $(MAIN)
	-$(BIBER) $(MAIN)
	-$(LATEX) $(MAIN)
	-$(LATEX) $(MAIN)
	@echo "Thesis built: $(MAIN).pdf"

# Quick compile without bibliography
quick:
	@echo "Quick compile of thesis..."
	$(LATEX) $(MAIN)

# View PDF (macOS)
view: $(MAIN).pdf
	open $(MAIN).pdf

view-main: $(MAIN).pdf
	open $(MAIN).pdf

# Check thesis status
status:
	@echo "=== UJN Thesis Status ==="
	@echo "Main file: $(MAIN).tex"
	@echo "Bibliography: $(BIB).bib"
	@echo "Chapters directory: chapter/"
	@echo
	@echo "Files:"
	@ls -la *.pdf 2>/dev/null || echo "No PDF files found"
	@echo
	@echo "Chapters:"
	@ls -la chapter/*.tex 2>/dev/null || echo "No chapter files found"

# Count pages in PDF
pages:
	@echo "=== Page Count ==="
	@if [ -f "$(MAIN).pdf" ]; then \
		if command -v pdfinfo > /dev/null 2>&1; then \
			pages=$$(pdfinfo "$(MAIN).pdf" 2>/dev/null | grep Pages | awk '{print $$2}'); \
		elif command -v mdls > /dev/null 2>&1; then \
			pages=$$(mdls -name kMDItemNumberOfPages "$(MAIN).pdf" 2>/dev/null | awk '{print $$3}'); \
		else \
			pages="unknown"; \
		fi; \
		echo "$(MAIN).pdf: $$pages pages"; \
	else \
		echo "No PDF found. Run 'make main' first."; \
	fi

# Validate thesis structure
validate:
	@echo "=== UJN Thesis Validation ==="
	@if [ -f "$(MAIN).pdf" ]; then \
		if command -v pdfinfo > /dev/null 2>&1; then \
			pages=$$(pdfinfo "$(MAIN).pdf" 2>/dev/null | grep Pages | awk '{print $$2}'); \
		elif command -v mdls > /dev/null 2>&1; then \
			pages=$$(mdls -name kMDItemNumberOfPages "$(MAIN).pdf" 2>/dev/null | awk '{print $$3}'); \
		else \
			pages="unknown"; \
		fi; \
		echo "✓ Thesis: $(MAIN).pdf ($$pages pages)"; \
	else \
		echo "✗ No thesis PDF found. Run 'make main' first."; \
	fi
	@echo
	@if [ -f "$(MAIN).tex" ]; then \
		grep -q "begin{document}" $(MAIN).tex 2>/dev/null && echo "✓ Document structure found" || echo "✗ Document structure missing"; \
		grep -q "bibliography" $(MAIN).tex 2>/dev/null && echo "✓ Bibliography reference found" || echo "✗ Bibliography reference missing"; \
	fi
	@if [ -d "chapter" ]; then \
		chapter_count=$$(ls chapter/*.tex 2>/dev/null | wc -l); \
		echo "✓ Chapters directory found ($$chapter_count chapter files)"; \
	else \
		echo "✗ Chapters directory missing"; \
	fi

# Clean auxiliary files
clean:
	@echo "Cleaning LaTeX auxiliary files..."
	rm -f *.aux *.bbl *.blg *.log *.out *.toc *.lof *.lot
	rm -f *.fls *.fdb_latexmk *.synctex.gz *.nav *.snm *.vrb
	rm -f *.spl *.figlist *.makefile *.fls *.fdb_latexmk
	rm -f *.bcf *.idx *.ilg *.ind *.run.xml
	rm -f chapter/*.aux
	rm -f .DS_Store
	find . -name "*.aux" -type f -delete
	find . -name "*.log" -type f -delete
	find . -name "*.fls" -type f -delete
	find . -name "*.fdb_latexmk" -type f -delete
	find . -name "*.synctex.gz" -type f -delete
	@echo "Cleaning complete"

# Force clean - kills VS Code auto-build and cleans thoroughly
clean-force:
	@echo "🚫 Force cleaning - stopping auto-build and cleaning all files..."
	@echo "Killing any running LaTeX processes..."
	-pkill -f "$(LATEX).*main" 2>/dev/null || true
	-pkill -f "$(BIBTEX).*main" 2>/dev/null || true
	@echo "Removing all auxiliary files..."
	rm -f *.aux *.bbl *.blg *.log *.out *.toc *.lof *.lot
	rm -f *.fls *.fdb_latexmk *.synctex.gz *.nav *.snm *.vrb
	rm -f *.spl *.figlist *.makefile *.fls *.fdb_latexmk
	rm -f *.bcf *.idx *.ilg *.ind *.run.xml
	rm -f chapter/*.aux
	rm -f .DS_Store
	find . -name "*.aux" -type f -delete
	find . -name "*.log" -type f -delete
	find . -name "*.fls" -type f -delete
	find . -name "*.fdb_latexmk" -type f -delete
	find . -name "*.synctex.gz" -type f -delete
	find . -name "*.out" -type f -delete
	find . -name "*.toc" -type f -delete
	@echo "✅ Force clean complete - LaTeX Workshop auto-build should be disabled"
	@echo "💡 If files regenerate, close VS Code or disable LaTeX Workshop auto-build"

# Clean all generated files except source
clean-all: clean
	@echo "Cleaning all generated files..."
	rm -f *.pdf

# Help
help:
	@echo "UJN Thesis Build System"
	@echo "======================"
	@echo
	@echo "Main Targets:"
	@echo "  all, main       - Build main thesis (forced rebuild)"
	@echo "  pdf             - Build main thesis (alias for main)"
	@echo "  main-check      - Build main thesis (only if needed)"
	@echo
	@echo "Development:"
	@echo "  quick           - Quick compile thesis (no bibliography)"
	@echo
	@echo "Utilities:"
	@echo "  status          - Show thesis status and files"
	@echo "  pages           - Count pages in thesis PDF"
	@echo "  validate        - Check thesis structure and requirements"
	@echo "  view, view-main - Open thesis PDF"
	@echo
	@echo "Cleaning:"
	@echo "  clean           - Remove auxiliary files"
	@echo "  clean-force     - Force clean + stop auto-build processes"
	@echo "  clean-all       - Remove all generated files"
	@echo
	@echo "Files:"
	@echo "  Main: $(MAIN).tex"
	@echo "  Bibliography: $(BIB).bib"
	@echo "  Chapters: chapter/*.tex"

# Declare phony targets
.PHONY: all main pdf main-check quick view view-main status pages validate clean clean-force clean-all help
