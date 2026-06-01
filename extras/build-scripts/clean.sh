#!/bin/bash

# LaTeX cleanup script for MedDef thesis
# Removes all generated/temporary files while preserving source files

echo "=== MedDef Thesis Cleanup Script ==="
echo "This will remove all generated LaTeX files..."

# Main directory cleanup
echo "Cleaning main directory..."
rm -f *.aux *.bbl *.blg *.bcf *.fdb_latexmk *.fls *.log *.out *.toc *.idx *.ind *.ilg *.run.xml *.synctex.gz *.synctex\(busy\) *.nav *.snm *.vrb *.lof *.lot *.xdv

# Chapter directory cleanup
echo "Cleaning chapter directory..."
rm -f chapter/*.aux

# Remove backup files (if any)
echo "Cleaning backup files..."
rm -f *~ *.bak *.backup
rm -f chapter/*~ chapter/*.bak chapter/*.backup

# Remove LaTeX temporary directories (if any)
echo "Cleaning temporary directories..."
rm -rf _minted-* auto/

# Remove OS-specific files
echo "Cleaning OS-specific files..."
rm -f .DS_Store chapter/.DS_Store figures/.DS_Store
rm -f Thumbs.db chapter/Thumbs.db figures/Thumbs.db

echo "✅ Cleanup completed!"
echo ""
echo "Files preserved:"
echo "  ✓ All .tex files"
echo "  ✓ All .cls files" 
echo "  ✓ All .bib files"
echo "  ✓ All images in figures/"
echo "  ✓ All fonts in fonts/"
echo "  ✓ All resources in res/"
echo "  ✓ All markdown files"
echo ""
echo "Files removed:"
echo "  ✗ All .aux files"
echo "  ✗ All .log files"
echo "  ✗ All .out files"
echo "  ✗ All .toc files"
echo "  ✗ All bibliography cache files"
echo "  ✗ All LaTeX temporary files"
echo "  ✗ All backup files"
echo "  ✗ All OS-specific files"
