#!/bin/bash

# LaTeX compilation script for MedDef thesis
# Supports both pdflatex and xelatex compilation

echo "=== MedDef Thesis Compilation Script ==="
echo "Choose compilation method:"
echo "1) XeLaTeX + Biber (Recommended for best font and bibliography support)"
echo "2) pdfLaTeX + Biber (Good compatibility)"
echo "3) XeLaTeX + BibTeX (Fallback option)"
echo "4) pdfLaTeX + BibTeX (Traditional LaTeX)"
read -p "Enter choice (1-4): " choice

case $choice in
    1)
        echo "Compiling with XeLaTeX + Biber..."
        ENGINE="xelatex"
        BIBENGINE="biber"
        ;;
    2)
        echo "Compiling with pdfLaTeX + Biber..."
        ENGINE="pdflatex"
        BIBENGINE="biber"
        ;;
    3)
        echo "Compiling with XeLaTeX + BibTeX..."
        ENGINE="xelatex"
        BIBENGINE="bibtex"
        ;;
    4)
        echo "Compiling with pdfLaTeX + BibTeX..."
        ENGINE="pdflatex"
        BIBENGINE="bibtex"
        ;;
    *)
        echo "Invalid choice. Using XeLaTeX + Biber as default..."
        ENGINE="xelatex"
        BIBENGINE="biber"
        ;;
esac

echo "Starting compilation with $ENGINE + $BIBENGINE..."

# Clean previous builds
echo "Cleaning previous builds..."
rm -f *.aux *.bbl *.blg *.fdb_latexmk *.fls *.log *.out *.toc *.idx *.ind *.ilg *.bcf *.run.xml

# First pass
echo "First pass..."
$ENGINE main.tex

# Check if first pass was successful
if [ $? -ne 0 ]; then
    echo "❌ First pass failed. Check the log file for errors."
    exit 1
fi

# Bibliography
echo "Processing bibliography with $BIBENGINE..."
if [ "$BIBENGINE" = "biber" ]; then
    biber main
else
    bibtex main
fi

# Check if bibliography processing was successful
if [ $? -ne 0 ]; then
    echo "❌ Bibliography processing failed. Check for bibliography errors."
    exit 1
fi

# Second pass
echo "Second pass..."
$ENGINE main.tex

# Third pass (for cross-references)
echo "Third pass..."
$ENGINE main.tex

echo "Compilation completed!"
echo "Output file: main.pdf"

# Check if PDF was created successfully
if [ -f "main.pdf" ]; then
    echo "✅ PDF generated successfully!"
    echo "File size: $(ls -lh main.pdf | awk '{print $5}')"
    
    # Optional: Open PDF if on macOS
    read -p "Open PDF? (y/n): " open_pdf
    if [ "$open_pdf" = "y" ] || [ "$open_pdf" = "Y" ]; then
        if command -v open &> /dev/null; then
            open main.pdf
        fi
    fi
else
    echo "❌ PDF generation failed. Check the log files for errors."
    echo "Common issues:"
    echo "- Missing fonts (try pdfLaTeX if using XeLaTeX)"
    echo "- Bibliography errors (check references.bib)"
    echo "- Missing packages (install required LaTeX packages)"
fi
