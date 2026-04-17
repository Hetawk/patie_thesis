import re
import sys

def parse_log(filename):
    overfull_hboxes = []
    # Simplified tracking: we just look for patterns
    # LaTeX logs are notorious for being hard to parse exactly for filenames
    # but we can look for the Overfull lines and context
    
    overfull_re = re.compile(r'Overfull \\hbox \(([0-9.]+)pt too wide\) in paragraph at lines ([0-9-]+)')
    
    # Also check for hyperref PDF-string warnings
    pdf_string_warning = False
    pdf_string_re = re.compile(r'Package hyperref Warning: Token not allowed in a PDF string')

    current_file = "unknown"
    # To get a better idea of the file, we look for (filename.tex
    file_ptrn = re.compile(r'\(([^)]+\.tex)')

    with open(filename, 'r', encoding='utf-8', errors='ignore') as f:
        lines = f.readlines()
        
    for i, line in enumerate(lines):
        if pdf_string_re.search(line):
            pdf_string_warning = True
            
        m_hbox = overfull_re.search(line)
        if m_hbox:
            width = float(m_hbox.group(1))
            line_range = m_hbox.group(2)
            if width > 10.0:
                # Look backwards for the most recent file opening
                # This is heuristic
                found_file = "unknown"
                for j in range(i, -1, -1):
                    m_file = file_ptrn.search(lines[j])
                    if m_file:
                        found_file = m_file.group(1)
                        break
                overfull_hboxes.append((found_file, width, line_range))
                    
    return overfull_hboxes, pdf_string_warning

hboxes, pdf_warn = parse_log('main.log')
print("--- Overfull Hboxes (> 10pt) ---")
for f, w, l in hboxes:
    print(f"File: {f}, Width: {w}pt, Lines: {l}")
print("\n--- Hyperref Warning ---")
print(f"PDF-string warnings found: {pdf_warn}")
