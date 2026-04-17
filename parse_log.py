import re

def parse_log(filename):
    overfull_hboxes = []
    current_file = "main.tex"
    file_stack = ["main.tex"]
    
    # regex for file opening/closing
    # (./chapter/3_institutional_background.tex
    # or just (filename.tex
    # or )
    file_open_re = re.compile(r'^\s*\(([^ \n\)]+\.tex)')
    file_close_re = re.compile(r'^\s*\)')
    
    # Overfull \hbox (10.2136pt too wide) in paragraph at lines 12--13
    hbox_re = re.compile(r'Overfull \\hbox \(([0-9.]+)pt too wide\) in paragraph at lines ([0-9-]+)')
    
    with open(filename, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            # Check for file changes
            # Note: LaTeX log parsing is tricky because of line wrapping
            # but we'll try basic heuristics
            m_open = file_open_re.search(line)
            if m_open:
                current_file = m_open.group(1)
                file_stack.append(current_file)
            elif ')' in line:
                # Simplistic file stack management
                if file_stack:
                    file_stack.pop()
                    if file_stack:
                        current_file = file_stack[-1]

            m_hbox = hbox_re.search(line)
            if m_hbox:
                width = float(m_hbox.group(1))
                lines = m_hbox.group(2)
                if width > 10.0:
                    overfull_hboxes.append({
                        'file': current_file,
                        'width': width,
                        'lines': lines
                    })
                    
    return overfull_hboxes

results = parse_log('main.log')
for res in results:
    print(f"File: {res['file']}, Width: {res['width']}pt, Lines: {res['lines']}")
