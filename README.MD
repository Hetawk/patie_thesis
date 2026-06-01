# ZSTU Master's Thesis — Patience Fero

LaTeX source for the master's thesis:

> **Does Capital Market Liberalization Drive Digital Transformation?
> Evidence from Chinese A-Shares' Inclusion in the MSCI Emerging Markets Index**

- Author: Patience Fero
- Program: Applied Economics (全英文授课), 经济管理学院
- Institution: Zhejiang Sci-Tech University (ZSTU, 浙江理工大学)
- Class file: `zstu_thesis.cls`

## Build

XeLaTeX + Biber. From the repo root:

```bash
make clean && make pdf && make clean
```

Output: `main.pdf` (~97 pages). Other targets:

- `make pdf` — build only
- `make clean` — remove auxiliary files
- `make figures-ch3-check` / `make figures-ch3` — validate and regenerate Chapter 3 figures from CSVs in `figures/`

## Repository layout

```
main.tex            Top-level LaTeX entry point
zstu_thesis.cls     ZSTU thesis class (cover, declarations, headers, TOC)
reference.bib       BibLaTeX bibliography
cover.pdf           Signed official cover page (included via \includepdf)
chapter/            All chapter sources (.tex)
figures/            Figures + CSV stats + Chapter 3 figure generator
Makefile            Build / clean / figure targets
README.MD           This file
extras/             Everything not needed for the build:
  build-scripts/      compile.sh, clean.sh (legacy wrappers)
  docs/               COMPILATION_GUIDE.md
  legacy-classes/     ujn_thesis.cls (unused)
  legacy-images/      Unused cover decoration assets
  legacy-pdfs/        Older PDF snapshots
  cover-templates/    ZSTU defense cover Word template
  scripts/            chapter3_characteristics_charts.py, parse_log*.py
  notes/              md/ working notes, final-submission/ signed forms
```

## Submission text files

All text needed for the ZSTU graduate-school online submission lives in
`extras/notes/md/last/`:

- `thesis_abstract.txt` — Chinese 摘要 + English Abstract (no line breaks)
- `innovative_achievements.txt` — innovation points and main field text
- `graduate_registration_and_revision_forms.txt` — 毕业研究生登记表 + 修改及定稿表
- `submission_checklist.txt` — upload checklist with official template links

## Notes

- Cover page is the external `cover.pdf` (signed scan), embedded via `\includepdf[pages=1]{cover.pdf}`.
- Originality declaration and copyright-use authorization pages are rendered by `\makeintegritydeclaration` and `\makeusageauthorization` in `zstu_thesis.cls`, with signature dates `2026 年 05 月 21 日` and `2026 年 05 月 26 日` respectively.
- For Chapter 3 figures, always run `make figures-ch3-check` before `make figures-ch3` so CSV statistics are validated before PNG regeneration.
