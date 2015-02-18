---
header-includes:
    - \usepackage{booktabs}
    - \usepackage{graphicx}
    - \usepackage{titlesec}
---

# A template for writing simple documents in Markdown for later conversion to $\LaTeX$

**February 15, 2015**

## How To Use

1. Copy this markdown file with a descriptive name, i.e. `my_doc.md`

2. In `my_doc.md`, modify the YAML headers to include a title, author name, additional latex includes, etc.

3. Modify the `latex.template` file to setup any specific document features. Future commits may include additional sample templates.

4. Modify `Makefile` with references to `my_doc.md`

5. Once you have written the body of your text, you can compile a PDF using xelatex by executing the `Makefile`.