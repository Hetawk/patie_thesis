# MedDef Thesis Compilation Guide

This document provides instructions for compiling the MedDef thesis using either XeLaTeX or pdfLaTeX.

## Quick Start

### Option 1: Use the provided script (Recommended)

```bash
./compile.sh
```

Follow the prompts to choose your preferred compilation method.

### Option 2: Cleanup generated files

```bash
./clean.sh
```

This removes all generated LaTeX files while preserving your source files.

### Option 3: Manual compilation

#### XeLaTeX + Biber (Recommended)

```bash
xelatex main.tex
biber main
xelatex main.tex
xelatex main.tex
```

#### pdfLaTeX + Biber

```bash
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex
```

#### XeLaTeX + BibTeX (Fallback)

```bash
xelatex main.tex
bibtex main
xelatex main.tex
xelatex main.tex
```

#### pdfLaTeX + BibTeX (Traditional)

```bash
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

## Enhanced Class Features

The `ujn_thesis.cls` now supports:

- **Hybrid Chapter/Section Support**: Works with both `\chapter{}` and `\section{}` commands
- **XeLaTeX Optimization**: Better font handling and Unicode support
- **Flexible Bibliography**: Supports both Biber and BibTeX
- **Automatic Numbering**: Figures, tables, and equations are numbered by chapter
- **Proper TOC Generation**: Chapters appear correctly in table of contents

## Class Structure

### Chapter Support

The class now defines a custom `\chapter{}` command that:

- Creates proper chapter numbering
- Resets section, figure, table, and equation counters
- Adds entries to table of contents and PDF bookmarks
- Maintains consistent formatting

### Figure and Table Numbering

- With chapters: `Figure 1-1`, `Table 2-3`, etc.
- Without chapters: `Figure 1-1`, `Table 1-2`, etc.

### Font Configuration

- **XeLaTeX**: Uses system fonts with fallback to bundled fonts
- **pdfLaTeX**: Uses bundled fonts in the `fonts/` directory

## File Organization

```
thesis/
├── main.tex                    # Main document
├── ujn_thesis.cls             # Enhanced thesis class
├── compile.sh                 # Compilation script
├── chapter/                   # Chapter files
│   ├── 0_abstract.tex         # Abstract
│   ├── 1_introduction.tex     # Introduction
│   ├── 2_literature_review.tex
│   ├── 3_methodology_experimental_design.tex
│   ├── 4_exp1_results_analysis.tex
│   ├── 5_exp2_results_analysis.tex
│   ├── 6_exp3_results_analysis.tex
│   ├── 7_conclusion.tex       # Conclusion
│   ├── 8_appendix.tex         # Appendix
│   └── 9_acknowledgement.tex  # Acknowledgments
├── figures/                   # All figures
├── fonts/                     # Font files
├── ref/
│   └── references.bib         # Bibliography
└── res/                       # Resources
```

## Troubleshooting

### Common Issues

1. **Missing fonts (XeLaTeX)**

   - Solution: Use pdfLaTeX or install missing system fonts

2. **Bibliography not appearing**

   - Ensure `ref/references.bib` exists and is properly formatted
   - Try using `biber` instead of `bibtex`

3. **Chapter numbering issues**

   - The class automatically handles chapter vs section numbering
   - Use `\chapter{}` for main chapters, `\section{}` for appendix sections

4. **Figure/Table not found**
   - Check that images are in the `figures/` directory
   - Verify file extensions match exactly

### Log Files

Check these files for detailed error information:

- `main.log` - Main compilation log
- `main.blg` - Bibliography log
- `main.out` - Hyperref warnings

## Customization

### Metadata

Update thesis information in `main.tex`:

```latex
\classificationnum{TN384}
\studentnum{202324100003}
\thesistitle{Your Thesis Title}
\authorname{Your Name}
\supervisor{Supervisor Name}
% ... etc
```

### Adding New Chapters

1. Create new `.tex` file in `chapter/` directory
2. Use `\chapter{Chapter Title}` at the beginning
3. Add `\include{chapter/filename}` to `main.tex`

### Bibliography

Add references to `ref/references.bib` using standard BibTeX format.

## Cleanup Commands

### Automatic Cleanup (Recommended)

```bash
./clean.sh
```

### Manual Cleanup

If you prefer to clean manually, here are the common commands:

```bash
# Remove all LaTeX generated files
rm -f *.aux *.bbl *.blg *.bcf *.fdb_latexmk *.fls *.log *.out *.toc *.idx *.ind *.ilg *.run.xml *.synctex.gz *.synctex\(busy\)

# Remove chapter auxiliary files
rm -f chapter/*.aux

# Remove backup and temporary files
rm -f *~ *.bak chapter/*~ chapter/*.bak

# Remove OS-specific files
rm -f .DS_Store chapter/.DS_Store figures/.DS_Store
```

### What Gets Cleaned

**Removed files:**

- `*.aux` - Auxiliary files
- `*.log` - Compilation logs
- `*.out` - Hyperref output
- `*.toc` - Table of contents
- `*.bbl, *.blg` - Bibliography files
- `*.bcf, *.run.xml` - Biber cache files
- `*.fdb_latexmk, *.fls` - Latexmk files
- `*.synctex.gz` - SyncTeX files
- `*~, *.bak` - Backup files
- `.DS_Store` - macOS system files

**Preserved files:**

- All `.tex` source files
- All `.cls` class files
- All `.bib` bibliography source files
- All images in `figures/`
- All fonts in `fonts/`
- All resources in `res/`
- All documentation files

## Class Compatibility

The enhanced `ujn_thesis.cls` is compatible with:

- TeX Live 2020+
- MiKTeX 2020+
- Both XeLaTeX and pdfLaTeX engines
- Both Biber and BibTeX bibliography processors
