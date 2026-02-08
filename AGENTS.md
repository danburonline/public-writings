# AGENTS.md — Writings Workspace

> Knowledge base for AI agents (Cursor, OpenCode) working in this scientific writings repository.

## Workspace Overview

This repository contains all public writings by Daniel Burger: essays, papers, patents, and future books. Everything is written in LaTeX using a unified template system, with source code and compiled outputs version-controlled together.

### Repository Structure

```txt
Writings/
├── 01_patents/                   # Patent applications (see Legal section)
│   └── YYYY/NNN_patent/          # Year/sequence organisation
│       ├── patent.tex            # Main LaTeX source
│       ├── figures/              # Images and diagrams
│       └── references/           # bibliography.bib
├── 02_papers/                    # Academic papers
│   └── YYYY/NNN_paper/           # Year/sequence organisation
│       ├── paper.tex             # Main LaTeX source
│       ├── figures/
│       └── references/
├── 03_books/                     # Book projects
│   └── book_slug/
│       ├── main.tex
│       └── chapters/
├── 04_essays/                    # Long-form essays
│   └── YYYY/NNN_essay/           # Year/sequence organisation
│       ├── essay.tex             # Main LaTeX source
│       ├── figures/
│       └── references/
├── _templates/                   # Shared LaTeX templates
│   ├── essay-preamble.tex        # Essays (single-column, 11pt)
│   ├── paper-preamble.tex        # Papers (two-column ready, 10pt)
│   ├── book-preamble.tex         # Books (memoir class, chapters)
│   ├── patent-preamble.tex       # Patents (double-spaced, numbered paras)
│   ├── preamble.tex              # Legacy (backwards compatibility)
│   ├── apa.bst                   # APA citation style
│   └── README.md                 # Template documentation
├── .agents/skills/               # Shared agent skills (Cursor + OpenCode)
├── .cursor/skills/               # Symlink → .agents/skills/ (Cursor compatibility)
├── .editorconfig                 # Editor formatting
└── AGENTS.md                     # This file
```

### Content Types

| Type        | Template Variant | Purpose                                    | Status |
| ----------- | ---------------- | ------------------------------------------ | ------ |
| **Patents** | `patent`         | Technical inventions                       | Active |
| **Papers**  | `paper`          | Academic papers, preprints                 | Active |
| **Books**   | `book`           | Extended works with chapter structure      | Active |
| **Essays**  | `essay`          | Long-form scientific/philosophical writing | Active |

---

## Language & Style Guidelines

### British English (Mandatory)

All content uses British English spelling, punctuation, and conventions:

| American       | British (Use This)           |
| -------------- | ---------------------------- |
| organize       | organise                     |
| color          | colour                       |
| center         | centre                       |
| analyze        | analyse                      |
| defense        | defence                      |
| program        | programme (except computing) |
| aluminum       | aluminium                    |
| acknowledgment | acknowledgement              |

**Punctuation:**

- Single quotes for emphasis: 'consciousness'
- Double quotes for direct quotations: "Death is an engineering challenge"
- Full stops inside quotation marks only when quoting complete sentences
- Oxford comma: "neurons, synapses, and glia"

### Academic Tone

- Formal, precise, scholarly language
- Active voice preferred when appropriate
- First-person plural ("we propose") for collaborative works
- Avoid hedging language when making strong claims backed by evidence
- Technical terminology with clear definitions

### Writing Philosophy

The author's writings are characterised by:

1. **First-principles thinking** — Build arguments from foundational definitions
2. **Engineering pragmatism** — Focus on tractable, testable approaches
3. **Interdisciplinary synthesis** — Bridge neuroscience, physics, philosophy, engineering
4. **Intellectual boldness** — Challenge conventional paradigms with rigorous alternatives

---

## LaTeX Conventions

### Template System

#### Personal Templates (for Drafting)

Separate preamble files for each document type:

```latex
% For essays (single-column, generous margins, 11pt)
\documentclass[11pt]{article}
\input{../../../_templates/essay-preamble.tex}

% For papers (two-column support, compact margins, 10pt)
\documentclass[10pt]{article}
\input{../../../_templates/paper-preamble.tex}
```

| Template             | Layout                 | Margins           | Use Case                |
| -------------------- | ---------------------- | ----------------- | ----------------------- |
| `essay-preamble.tex` | Single-column, 11pt    | 4cm L/R, generous | Essays, thought pieces  |
| `paper-preamble.tex` | Two-column ready, 10pt | 3cm L/R, compact  | Papers, preprints       |
| `preamble.tex`       | Legacy unified         | Conditional       | Backwards compatibility |

#### Submission Templates (for Journals/Conferences)

When submitting to journals or conferences, **use their official templates**:

| Venue              | Template                                                                                            | Notes                         |
| ------------------ | --------------------------------------------------------------------------------------------------- | ----------------------------- |
| **Springer LNCS**  | [splncs04.cls](https://www.springer.com/gp/computer-science/lncs/conference-proceedings-guidelines) | HCII, HCI conferences         |
| **IEEE**           | [IEEEtran.cls](https://www.ieee.org/conferences/publishing/templates.html)                          | IEEE conferences/journals     |
| **ACM**            | [acmart.cls](https://www.acm.org/publications/proceedings-template)                                 | CHI, UIST, etc.               |
| **Elsevier**       | [elsarticle.cls](https://www.elsevier.com/authors/policies-and-guidelines/latex-instructions)       | Elsevier journals             |
| **Nature/Science** | Word templates                                                                                      | Often require Word submission |

**Workflow:**

1. **Draft** using personal templates (`essay` or `paper` variant)
2. **Finalise** content and structure
3. **Convert** to venue-specific template before submission (AI agents can assist)
4. **Verify** compliance with venue guidelines (page limits, formatting)

### Document Structure

Standard LaTeX document organisation:

```latex
\begin{document}
\pagenumbering{roman}

% Frontmatter
\title{\textbf{Title Here}}
\author[1]{Author Name}
\affil[1]{\textbf{Institution}}
\date{\textit{Month DD, YYYY}}
\maketitle

% Abstract
\begin{abstract}
  Abstract text here.
\end{abstract}

% Preliminaries
\tableofcontents
\listoffigures
\pagenumbering{arabic}

% Main content
\section{Introduction}
\label{sec:introduction}

% Back matter
\bibliography{references/bibliography}
\bibliographystyle{../../../_templates/apa}
\end{document}
```

### Section Markers

Use semantic markers for navigation:

```latex
% ! =====================
% ! # MARK: Section Name
% ! =====================
```

### Custom Commands

| Command                             | Usage             | Output                  |
| ----------------------------------- | ----------------- | ----------------------- |
| `\floatcaption{title}{description}` | Enhanced captions | **Title** Description.  |
| `\autoref{label}`                   | Smart references  | "Figure 1", "Section 2" |
| `\cite{key}`                        | natbib citations  | (Author, Year)          |
| `\citet{key}`                       | Textual citation  | Author (Year)           |

### Figures

```latex
\begin{figure}[ht]
  \centering
  \includegraphics[width=\textwidth]{figures/filename.png}
  \floatcaption{Figure title}{Detailed description of what the figure shows.}
  \label{fig:descriptive-label}
\end{figure}
```

### Tables

```latex
\begin{table}[ht]
  \centering
  \begin{tabular}{p{0.3\textwidth}p{0.6\textwidth}}
    \toprule
    \textbf{Column 1} & \textbf{Column 2} \\
    \midrule
    Content & Content \\
    \bottomrule
  \end{tabular}
  \caption{\textbf{Table title.} Description.}
  \label{tab:descriptive-label}
\end{table}
```

### Code Listings

```latex
\begin{lstlisting}[language=Python, caption={Description.}, label={lst:example}]
def function():
    return "Hello, World!"
\end{lstlisting}
```

### Mathematics

Use `amsmath` environments:

```latex
% Numbered equation
\begin{equation}
  \mathcal{C}(\mathcal{I}, [t_0, t_1]) \iff \forall t \in [t_0, t_1] : \left\| \frac{dS_{\text{crit}}}{dt}(t) \right\|_{\mathcal{S}} \le \Lambda_{\text{adapt}}(S_{\text{crit}}(t))
  \label{eq:continuity}
\end{equation}

% Inline: $S_{\text{crit}}(t) \in \mathcal{S}$
```

**Convention:** Use `\text{}` for subscript descriptors (e.g., `S_{\text{crit}}`).

### Bibliography

BibTeX entries in `references/bibliography.bib`:

```bibtex
@article{author_keyword_year,
  title = {Article Title},
  author = {Last, First and Other, Author},
  journal = {Journal Name},
  volume = {1},
  number = {1},
  pages = {1--10},
  year = {2024},
  doi = {10.1000/example}
}
```

**Key format:** `lastname_keyword_year` (e.g., `watanabe_biological_2022`)

---

## Workflow Guidelines

### Creating New Documents

1. Create directory: `XX_type/YYYY/NNN_type/`
2. Copy structure from existing document of same type
3. Update `\input{}` path to appropriate preamble (e.g., `essay-preamble.tex`, `paper-preamble.tex`)
4. Create `figures/` and `references/` subdirectories

### Compilation

```bash
# Single compilation
pdflatex essay.tex

# Full compilation with bibliography
latexmk -pdf essay.tex

# Clean auxiliary files
latexmk -c
```

### Version Control

**Commit:**

- Source files (`.tex`, `.bib`, `.md`)
- Final PDFs (for easy access)
- Template changes (separate from content)

**Ignore (via .gitignore):**

- Auxiliary files (`.aux`, `.log`, `.synctex.gz`, etc.)
- Intermediate compilation files

**Branches:**

- `main` — Published/stable versions
- `essay/NNN` — Work-in-progress essays
- `paper/NNN` — Work-in-progress papers

---

## Agent Instructions

### For All Agents (Cursor, OpenCode, Claude Code)

When working in this repository:

1. **Load relevant skills** — Skills in `.agents/skills/` provide specialised guidance
2. **Understand template system** — Check `_templates/README.md` before modifying preamble
3. **Maintain consistency** — Match existing document style in same category
4. **Preserve semantic markers** — Keep `% ! # MARK:` comments for navigation
5. **Context awareness** — This is a writings workspace, not a code repository
6. **LaTeX focus** — Primary files are `.tex`, not programming languages
7. **British English** — All generated text must use British spelling

### Task Categories

| Task Type               | Approach                                                    |
| ----------------------- | ----------------------------------------------------------- |
| **Drafting prose**      | Match author's voice; first-principles; bold but rigorous   |
| **LaTeX formatting**    | Follow template conventions; use custom commands            |
| **Bibliography**        | APA style; verify DOIs; consistent key format               |
| **Figures**             | Descriptive filenames; proper `\floatcaption` usage         |
| **Editing**             | Preserve meaning; improve clarity; maintain British English |
| **Research assistance** | Find citations; verify claims; suggest related work         |

### Quality Checklist

Before completing any task:

- [ ] British English spelling throughout
- [ ] LaTeX compiles without errors
- [ ] Cross-references (`\autoref`) resolve correctly
- [ ] Bibliography entries complete
- [ ] Figures have descriptive captions
- [ ] Section markers present for major sections
- [ ] Consistent formatting with existing documents

---

## Legal & Publication Guidelines

### Patents

**CRITICAL:** Patent documents in `01_patents/` have special handling:

1. **Pre-submission:** Content is confidential; do not discuss publicly
2. **Post-provisional:** Can be pushed to public repository only after provisional patent application filed
3. **Publication timing:** Coordinate with legal counsel before any public disclosure

### Open Access

All other content (essays, papers, books) is intended for public access:

- Repository is public after appropriate legal clearance
- Contributions welcome via pull requests
- Living documents — updates encouraged post-publication

### Citation

When this work is cited:

```bibtex
@misc{burger_writings_2026,
  author = {Burger, Daniel},
  title = {Public Writings Repository},
  year = {2026},
  url = {https://github.com/[username]/Writings}
}
```

---

## Available Skills

Skills provide specialised guidance for agents. Located in `.agents/skills/`.

### Skill Overview

| Skill                           | Purpose                                                | When to Use                         |
| ------------------------------- | ------------------------------------------------------ | ----------------------------------- |
| `writing-clearly-and-concisely` | Strunk's Elements of Style + AI pattern avoidance      | Any prose for humans                |
| `scientific-writing`            | IMRAD structure, citations, reporting guidelines       | Research papers, manuscripts        |
| `scientific-critical-thinking`  | Methodology critique, bias detection, evidence quality | Reviewing claims, research design   |
| `scientific-brainstorming`      | Research ideation, hypothesis generation               | Creative problem-solving            |
| `scientific-visualization`      | Publication figures (matplotlib/seaborn/plotly)        | Creating journal-ready plots        |
| `latex-writing`                 | LaTeX best practices, semantic markup                  | Writing/editing .tex files          |
| `mermaid-diagrams`              | Software diagrams using Mermaid syntax                 | Flowcharts, sequence diagrams, ERDs |

---

### writing-clearly-and-concisely

**Purpose:** Apply Strunk's timeless rules for clearer, stronger writing. Avoid AI writing patterns.

**Use when:**

- Writing documentation, explanations, any prose humans will read
- Editing to improve clarity and conciseness
- Avoiding AI-generated "slop" (puffery, empty phrases, promotional language)

**Key principles:**

- Use active voice
- Put statements in positive form
- Use definite, specific, concrete language
- Omit needless words
- Keep related words together

**Reference files:** `elements-of-style/` (grammar, composition, word choice), `signs-of-ai-writing.md`

---

### scientific-writing

**Purpose:** Write scientific manuscripts with IMRAD structure, proper citations, and reporting guidelines.

**Use when:**

- Writing any section of a scientific manuscript (abstract, introduction, methods, results, discussion)
- Formatting citations (APA, AMA, Vancouver, Chicago, IEEE)
- Applying reporting guidelines (CONSORT, STROBE, PRISMA)
- Preparing manuscripts for journal submission

**Critical principle:** Always write in full paragraphs with flowing prose. Never submit bullet points. Use two-stage process:

1. Create section outlines with key points
2. Convert outlines to complete paragraphs

**Reference files:** `imrad_structure.md`, `citation_styles.md`, `figures_tables.md`, `reporting_guidelines.md`, `writing_principles.md`

---

### scientific-critical-thinking

**Purpose:** Evaluate research rigor, assess methodology, detect biases, analyse statistical validity.

**Use when:**

- Reviewing research papers or evaluating scientific claims
- Assessing experimental design and methodology
- Identifying biases and confounding factors
- Applying GRADE or Cochrane risk of bias frameworks
- Planning rigorous new studies

**Core capabilities:**

- Methodology critique (study design, validity analysis)
- Bias detection (cognitive, selection, measurement, analysis)
- Statistical analysis evaluation (power, tests, p-values, effect sizes)
- Evidence quality assessment (hierarchy, GRADE)
- Logical fallacy identification

**Reference files:** `scientific_method.md`, `common_biases.md`, `statistical_pitfalls.md`, `evidence_hierarchy.md`, `logical_fallacies.md`, `experimental_design.md`

---

### scientific-brainstorming

**Purpose:** Research ideation partner for generating hypotheses and exploring interdisciplinary connections.

**Use when:**

- Generating novel research ideas or directions
- Exploring interdisciplinary connections and analogies
- Challenging assumptions in existing frameworks
- Developing new methodological approaches
- Overcoming creative blocks

**Workflow phases:**

1. Understanding context (research question, constraints)
2. Divergent exploration (cross-domain analogies, assumption reversal, scale shifting)
3. Connection making (patterns, themes, unexpected links)
4. Critical evaluation (feasibility, strengths, challenges)
5. Synthesis and next steps

**Reference files:** `brainstorming_methods.md` (SCAMPER, Six Thinking Hats, TRIZ, Biomimicry)

---

### scientific-visualization

**Purpose:** Create publication-quality figures with matplotlib, seaborn, and plotly.

**Use when:**

- Creating plots for scientific manuscripts
- Preparing figures for journal submission (Nature, Science, Cell, PLOS)
- Ensuring colorblind-friendly, accessible figures
- Making multi-panel figures with consistent styling
- Exporting at correct resolution and format (PDF/EPS/TIFF)

**Key requirements:**

- Colorblind-safe palettes (Okabe-Ito recommended)
- Proper resolution (300-600 DPI for raster, vector preferred)
- Sans-serif fonts (Arial, Helvetica), minimum 6-7pt at final size
- Error bars with statistical significance markers
- Journal-specific dimensions

**Reference files:** `publication_guidelines.md`, `color_palettes.md`, `journal_requirements.md`, `matplotlib_examples.md`

**Assets:** `color_palettes.py`, `*.mplstyle` files (publication, nature, presentation)

**Scripts:** `figure_export.py`, `style_presets.py`

---

### latex-writing

**Purpose:** Guide LaTeX authoring with semantic markup and best practices.

**Use when:**

- Writing or editing .tex files
- Reviewing LaTeX code quality
- Working with literate programming (.nw) files

**Key principles:**

- **Semantic markup:** Use environments matching content meaning, not visual appearance
- **Lists:** Use `description` for term-definition pairs, not `\textbf{Label:}` in `itemize`
- **Cross-references:** Always use `\autoref{}` (hyperref), never `\S\ref{}` or `Figure~\ref{}`
- **Emphasis:** Use `\emph{}`, never ALL CAPITALS
- **Literate programming:** Use `[[code]]` notation in .nw files, not `\texttt{..._...}`

**Anti-patterns to avoid:**

- `\textbf{Label:}` in itemize → use `\item[Label]` in description
- `Section~\ref{sec:x}` → use `\autoref{sec:x}`
- ALL CAPS emphasis → use `\emph{emphasis}`

---

### mermaid-diagrams

**Purpose:** Create professional software diagrams using Mermaid's text-based syntax.

**Use when:**

- Creating flowcharts, sequence diagrams, class diagrams, or ERDs
- Visualising system architecture (C4 diagrams)
- Documenting user journeys, workflows, or state machines
- Explaining code structure or application flows

**Diagram types:**

| Type              | Use Case                                |
| ----------------- | --------------------------------------- |
| Class diagrams    | Domain modelling, OOP design            |
| Sequence diagrams | API flows, method calls                 |
| Flowcharts        | Processes, algorithms, user journeys    |
| ERDs              | Database schemas                        |
| C4 diagrams       | System/container/component architecture |
| State diagrams    | State machines, lifecycles              |
| Gantt charts      | Project timelines                       |

**Key principles:**

- First line declares diagram type (`classDiagram`, `sequenceDiagram`, `flowchart`)
- Use `%%` for comments
- Diagrams are version-controllable text
- Unknown words break diagrams; parameters fail silently

---

## Future Extensions

This section documents planned additions to the workspace and agent capabilities.

### Planned Document Types

- [x] **Patents** (`01_patents/`) — Technical invention disclosures ✓
- [x] **Books** (`03_books/`) — Extended works with chapter structure ✓
- [ ] **Presentations** — Beamer slides for conferences
- [ ] **Grant proposals** — Funding applications

### Planned Skills (for agents)

Future skill modules to be added:

| Skill                  | Purpose                                                    |
| ---------------------- | ---------------------------------------------------------- |
| `mathematics`          | Equation formatting, proof structure, notation consistency |
| `bibliography-manager` | Citation verification, DOI lookup, reference formatting    |
| `figure-design`        | TikZ diagrams, scientific visualisation guidance           |
| `patent-drafting`      | Claims structure, legal language, prior art analysis       |

### Integration Notes

**Unified agent configuration:**

- `.agents/skills/` provides skills for all compatible agents
- Cursor, OpenCode, and Claude Code all discover skills from this location
- AGENTS.md serves as the shared knowledge base

**Editor compatibility:**

- Author uses Zed as primary editor
- `zed <FILE>` opens files from CLI
- This AGENTS.md is editor-agnostic

---

## Quick Reference

### Common Commands

```bash
# Compile document
latexmk -pdf document.tex

# Clean auxiliary files
latexmk -c

# Open in Zed
zed essay.tex

# Git workflow
git checkout -b essay/004
git add essay.tex references/bibliography.bib
git commit -m "Draft: consciousness continuity mechanisms"
```

### LaTeX Snippets

```latex
% New section with marker
% ! ====================
% ! # MARK: Section Name
% ! ====================
\section{Section Name}
\label{sec:section-name}

% Figure with custom caption
\begin{figure}[ht]
  \centering
  \includegraphics[width=\textwidth]{figures/name.png}
  \floatcaption{Title}{Description.}
  \label{fig:name}
\end{figure}

% Inline citation
As demonstrated by \citet{author_keyword_year}, ...

% Parenthetical citation
... substrate independence \citep{author_keyword_year}.
```

### File Naming

- **Figures:** `descriptive-name.png` (lowercase, hyphens)
- **BibTeX keys:** `lastname_keyword_year`
- **Labels:** `type:descriptive-name` (e.g., `fig:process-world-line`, `sec:introduction`, `eq:continuity`)
