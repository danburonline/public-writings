# LaTeX Templates

This folder contains personal drafting templates for different document types.

> **Note:** These are **personal drafting templates**. When submitting to journals or conferences (e.g., Springer LNCS for HCII, IEEE, ACM), use their official templates and convert your content accordingly.

## Available Templates

| Template | Purpose | Layout |
|----------|---------|--------|
| `essay-preamble.tex` | Essays, thought pieces | Single-column, 11pt, 4cm margins |
| `paper-preamble.tex` | Papers, preprints | Two-column ready, 10pt, 3cm margins |
| `book-preamble.tex` | Technical books | Memoir class, A4, chapter structure |
| `patent-preamble.tex` | Patent applications | Letter, 12pt, double-spaced, numbered paragraphs |
| `preamble.tex` | Legacy (backwards compat) | Conditional via `\templatevariant` |

## Usage

### For Essays

```latex
\documentclass[11pt]{article}
\input{../../../_templates/essay-preamble.tex}

\begin{document}
  \maketitle
  \tableofcontents
  \section{Introduction}
  ...
  \bibliography{references}
\end{document}
```

### For Papers

```latex
\documentclass[10pt]{article}
\input{../../../_templates/paper-preamble.tex}

\begin{document}
  \maketitle
  \tableofcontents

  % Optional: Use two-column layout
  \begin{multicols}{2}
    \section{Introduction}
    ...
  \end{multicols}

  \bibliography{references}
\end{document}
```

### For Books

```latex
\documentclass[11pt,a4paper,openany]{memoir}
\input{../../_templates/book-preamble.tex}

\begin{document}

\frontmatter
\title{Book Title}
\author{Author Name}
\maketitle
\tableofcontents

\mainmatter
\chapter{Introduction}
...

\appendix
\chapter{Supplementary Material}
...

\backmatter
\bibliography{references}
\printindex

\end{document}
```

### For Patents

```latex
\documentclass[12pt]{article}
\input{../../../_templates/patent-preamble.tex}

\begin{document}

\patenttitle{Method and System for Doing Something Novel}

\inventor{Daniel Burger}{London, United Kingdom}

\crossref{This application claims priority to...}

\technicalfield{
\para The present invention relates to...
}

\background{
\para Existing systems suffer from...
\para There is a need for...
}

\summary{
\para The present invention provides...
}

\drawingsdesc{
\para FIG. 1 illustrates...
\para FIG. 2 shows...
}

\detaileddesc{
\para Referring to FIG. 1, a system \refnum{100} includes...
\para The processor \refnum{102} is configured to...
}

\begin{claims}
  \claim A method for doing something, comprising:
    \begin{enumerate}[label=(\alph*)]
      \item receiving input data;
      \item processing the input data; and
      \item outputting a result.
    \end{enumerate}
  \claim The method of claim \claimref{1}, wherein the processing includes...
  \claim A system comprising:
    \begin{enumerate}[label=(\alph*)]
      \item a processor; and
      \item a memory storing instructions.
    \end{enumerate}
\end{claims}

\patentabstract{A method and system for... [150 words max]}

\end{document}
```

## Key Features

### Automatic Package Loading

- **Common packages**: Both variants load essential packages (fonts, maths, tables, citations, etc.)
- **Variant-specific packages**: Paper variant automatically loads `multicol` and `dblfloatfix`.
- **Smart conditionals**: The preamble uses `\ifx` conditionals to load appropriate packages.

### Typography & Layout

- **Font**: TeX Gyre Termes (Times clone) with T1 encoding.
- **Microtype**: Enhanced typography and justification.
- **Custom spacing**: Optimised line spacing and list formatting.
- **Hyperlinks**: Configured with blue colours and proper line breaking.

### Citations & Bibliography

- **`natbib`**: Advanced citation management.
- **Custom styling**: Bibliography formatted with proper spacing and alignment.
- **References title**: Automatically uses "References" instead of "Bibliography".

### Custom Commands & Environments

- **`\floatcaption{title}{description}`**: Creates a caption for floats with a bold title and a description.
- **Code Listings**: The preamble provides extensive support for syntax-highlighted code listings using the `listings` package. A custom style named `mystyle` is pre-configured with a light grey background, specific colours for keywords, strings, and comments, and line numbers. To add a code block, use the `lstlisting` environment and specify the language.

  ```latex
  \begin{lstlisting}[language=JavaScript, caption={A JavaScript code example.}, label={lst:example}]
  function helloWorld() {
    // This is a comment
    const message = "Hello, World!";
    console.log(message);
  }
  \end{lstlisting}
  ```

## Figures and Tables

### In Essay Variant (Single Column)

- Use standard `\begin{figure}` and `\begin{table}`.
- Width can be up to `\textwidth`.
- Simple, straightforward layout.

```latex
\begin{figure}[ht]
  \centering
  \includegraphics[width=0.8\textwidth]{image.png}
  \floatcaption{Figure title}{Detailed description}
\end{figure}
```

### In Paper Variant (Two Column)

- **Single-column float**: Use `\begin{figure}` or `\begin{table}`.
  - Float appears within one column only.
  - Width should be `\columnwidth` or less.
- **Double-column float**: Use `\begin{figure*}` or `\begin{table*}`.
  - Float spans both columns.
  - Width can be up to `\textwidth`.
  - Appears at top or bottom of page.

```latex
% Single column figure
\begin{figure}[ht]
  \centering
  \includegraphics[width=\columnwidth]{image.png}
  \floatcaption{Single column figure}{Description}
\end{figure}

% Double column figure
\begin{figure*}[ht]
  \centering
  \includegraphics[width=\textwidth]{image.png}
  \floatcaption{Double column figure}{Spanning both columns}
\end{figure*}
```

## Technical Details

The unified preamble uses LaTeX conditionals to check the value of `\templatevariant`:

- **Essay variant (default)**: Single-column settings with generous margins.
- **Paper variant**: Loads additional packages (`multicol`, `dblfloatfix`) with compact margins.
- **Conditional loading**: Uses `\ifx\templatevariant\papervariant` to determine package loading.
- **Fallback**: If `\templatevariant` is not defined, `\providecommand` ensures essay layout.

## Important Notes

1.  **Order matters**: Always define `\templatevariant` **before** inputting the preamble.
2.  **Use `\providecommand`**: This prevents errors if the command is already defined.
3.  **Package compatibility**: The preamble loads packages in the correct order to avoid conflicts.
4.  **Hyperref**: Loaded last to ensure proper functionality with other packages.

---

## Book Template Features

The book template uses the **memoir** class, which provides superior typography and extensive customisation for longer works.

### Document Structure

- **`\frontmatter`**: Roman numerals, no chapter numbers (title page, TOC, preface)
- **`\mainmatter`**: Arabic numerals, chapter numbers (main content)
- **`\appendix`**: Appendix chapters (A, B, C...)
- **`\backmatter`**: No chapter numbers (bibliography, index)

### Chapter Style

A clean, modern chapter style with:
- Large chapter number and title on same line
- Generous spacing before and after
- Section numbering to subsection level

### Headers & Footers

- Even pages: page number left, chapter name right
- Odd pages: section name left, page number right
- Chapter opening pages: centred page number only

### Index Support

Index generation is enabled by default. Use:
- `\index{term}` in text to add entries
- `\printindex` in backmatter to output

---

## Patent Template Features

The patent template is designed for **drafting** patent applications. Convert to official format (USPTO, EPO, WIPO) before filing.

### Formatting

- **Letter paper** (8.5" × 11") with 1" margins
- **12pt font** with double spacing (USPTO provisional requirements)
- **No section numbering** (patent convention)
- **Centred, uppercase section headings**

### Paragraph Numbering

Two styles available:

```latex
\para This paragraph will be numbered [1], [2], etc.

\pnum This paragraph will be numbered 1., 2., etc.
```

### Claims Environment

```latex
\begin{claims}
  \claim An independent claim...
  \claim The method of claim \claimref{1}, wherein... (dependent)
  \claim Another independent claim...
\end{claims}
```

### Reference Numerals

Use `\refnum{102}` for consistent formatting of reference numerals in detailed description. Outputs **102** in bold.

### Convenience Macros

| Macro | Purpose |
|-------|---------|
| `\patenttitle{...}` | Centred, uppercase title |
| `\inventor{name}{address}` | Inventor listing |
| `\crossref{...}` | Cross-reference section |
| `\technicalfield{...}` | Technical field section |
| `\background{...}` | Background section |
| `\summary{...}` | Summary section |
| `\drawingsdesc{...}` | Brief description of drawings |
| `\detaileddesc{...}` | Detailed description section |
| `\patentabstract{...}` | Abstract (end of document) |

### Figure Naming

Figures automatically use "FIG. X" notation (patent standard) instead of "Figure X".
