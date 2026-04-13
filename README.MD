# University of Jinan LaTeX Thesis Template

This repository contains a fully English LaTeX thesis template for the University of Jinan, translated from the original Chinese version.

## Quick Start

### XeLaTeX (Recommended)

xelatex -shell-escape -interaction=nonstopmode main.tex

```bash
xelatex main.tex
bibtex main
xelatex main.tex
xelatex main.tex
```

### pdfLaTeX (Alternative)

**Recommended:** Use shell-escape to automatically convert SVG files:

```bash
pdflatex --shell-escape main.tex
bibtex main
pdflatex --shell-escape main.tex
pdflatex --shell-escape main.tex
```

**Alternative:** If shell-escape is not available, manually convert SVG files first:

```bash
# Convert SVG files to PDF (requires inkscape)
find images/ -name "*.svg" -exec inkscape {} --export-pdf={}.pdf \;

# Then compile normally
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

## Translation Status

### ✅ Completed

- **All chapter content** translated to English (chapters 1-6, 9, abstract)
- **Class file (`ujn_thesis.cls`)** fully translated with English comments and section names
- **Engine compatibility** added for both XeLaTeX and pdfLaTeX
- **File naming** - all Chinese filenames renamed to English equivalents
- **Image references** updated to use English filenames
- **Font handling** made engine-aware with conditional loading
- **Bibliography references** updated with English entries
- **Comments and metadata** translated throughout all files

## Remove generated files

```bash
rm -f *.aux *.log *.toc *.out *.bbl *.blg *.bcf *.run.xml *.synctex.gz *.fdb_latexmk *.fls *.idx *.ilg *.ind 2>/dev/null || true
```

## Regenerate Chapter 3 Figures

Chapter 3 figure PNG files are generated from CSV stats files using:

```bash
make figures-ch3-check
make figures-ch3
```

`make figures-ch3-check` validates that the CSV statistics are internally consistent (sample shares, confidence interval bounds, and odds-ratio constraints) before any PNG output is written.

This runs [figures/generate_ch3_figures.py](figures/generate_ch3_figures.py), which reads:
- [figures/fig3_1_pre_liberalization_characteristics_stats.csv](figures/fig3_1_pre_liberalization_characteristics_stats.csv)
- [figures/fig3_2_msci_rollout_timeline_stats.csv](figures/fig3_2_msci_rollout_timeline_stats.csv)
- [figures/fig3_3_eligibility_logit_odds_ratios_stats.csv](figures/fig3_3_eligibility_logit_odds_ratios_stats.csv)

and rewrites the matching PNG files in [figures](figures).

## Troubleshooting

### SVG Images with pdfLaTeX

**Problem:** `! Package svg Error: You're not allowed to use '--shell-escape'`

**Solutions:**

1. **Enable shell-escape (recommended):**

   ```bash
   pdflatex --shell-escape main.tex
   ```

2. **Convert SVG to PDF manually:**
   ```bash
   # Install inkscape if needed: brew install inkscape
   find images/ -name "*.svg" -exec inkscape {} --export-pdf={}.pdf \;
   # Then use regular pdflatex without --shell-escape
   ```

### PDF Version Compatibility

**Problem:** `pdfTeX warning: pdflatex: PDF inclusion: found PDF version <1.7>, but at most version <1.5> allowed`

**Solution:** Convert problematic PDFs to version 1.5:

```bash
# For integrity_statement.pdf
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -dNOPAUSE -dQUIET -dBATCH -sOutputFile=res/integrity_statement_v15.pdf res/integrity_statement.pdf
```

### Font Issues

- **XeLaTeX:** Supports Unicode fonts and Chinese characters natively
- **pdfLaTeX:** Uses traditional LaTeX fonts, may have Unicode limitations

### Clean Build

If you encounter persistent errors, clean auxiliary files:

```bash
rm -f *.aux *.log *.toc *.out *.bbl *.blg *.bcf *.run.xml *.synctex.gz *.fdb_latexmk *.fls *.idx *.ilg *.ind 2>/dev/null || true

rm -f *.aux *.log *.toc *.out *.bbl *.blg *.bcf *.run.xml *.synctex.gz *.fdb_latexmk *.fls *.idx *.ilg *.ind chapter/*.aux 2>/dev/null || true

rm -f *.aux *.log *.toc *.out *.bbl  *.bcf *.run.xml  *.fdb_latexmk *.fls *.idx   chapter/*.aux 2>/dev/null || true

rm -f chapter/*.aux *.backup

rm -f chapter/*.aux
```
