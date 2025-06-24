# Unified Template System

This template system provides a single, unified template ([`template.tex`](/templates/template.tex)) that supports two distinct layout variants optimized for different document types. You control which variant to use by defining `\templatevariant` in your document.

## Template Variants

### Essay Variant (`essay`)

- **Purpose**: Long-form essays in a single-column documents
- **Font size**: 11pt (standard document font size)
- **Margins**: Extra generous margins (4cm left/right, 3cm top/3.5cm bottom) for readability

### Paper Variant (`paper`)

- **Purpose**: Academic (pre-print) papers
- **Font size**: 10pt (standard academic font size)
- **Layout**: Two-column support with `multicol` package
- **Margins**: Adjustable margins (default large for front matter, reduced for main content)

## Usage

### For Essays (Single Column)

Define the template variant as "essay" before inputting the template:

```latex
\documentclass[11pt]{article}
\newcommand{\templatevariant}{essay}
\input{../../../templates/template.tex}

\begin{document}
  % All content in single column with generous margins
  \maketitle
  \tableofcontents

  \section{Introduction}
  ...

  \bibliography{...}
\end{document}
```

### For Papers (Two Column)

Define the template variant as "paper" before inputting the template:

```latex
\documentclass[10pt]{article}
\newcommand{\templatevariant}{paper}
\input{../../../templates/template.tex}

\begin{document}
  % Front matter (title, abstract, TOC) - single column with default margins
  \maketitle
  \tableofcontents

  % Start two-column layout with reduced margins
  \newgeometry{left=1.5cm, right=1.5cm, top=2cm, bottom=2cm}
  \begin{multicols}{2}

    % Your main content here in 10pt font, two columns
    \section{Introduction}
    ...

  \end{multicols}  % End two-column layout
  \restoregeometry  % Restore default margins

  % Back matter (bibliography) - single column with default margins
  \bibliography{...}
\end{document}
```

**Note**: If you don't specify `\templatevariant`, it defaults to "essay" layout.

## Figures and Tables

### In Essay Variant (Single Column)

- Use standard `\begin{figure}` and `\begin{table}`
- Width can be up to `\textwidth`
- Simple, straightforward layout

```latex
\begin{figure}[ht]
  \centering
  \includegraphics[width=0.8\textwidth]{image.png}
  \caption{Figure caption}
\end{figure}
```

### In Paper Variant (Two Column)

- **Single-column float**: Use `\begin{figure}` or `\begin{table}`

  - Float appears within one column only
  - Width should be `\columnwidth` or less

- **Double-column float**: Use `\begin{figure*}` or `\begin{table*}`
  - Float spans both columns
  - Width can be up to `\textwidth`
  - Appears at top or bottom of page

```latex
% Single column figure
\begin{figure}[ht]
  \centering
  \includegraphics[width=\columnwidth]{image.png}
  \caption{Single column figure}
\end{figure}

% Double column figure
\begin{figure*}[ht]
  \centering
  \includegraphics[width=\textwidth]{image.png}
  \caption{Double column figure spanning both columns}
\end{figure*}
```

## Technical Details

The unified template uses LaTeX conditionals to check the value of `\templatevariant`:

- **Essay variant**: Loads single-column settings with generous margins
- **Paper variant**: Additionally loads `multicol` and `dblfloatfix` packages with different margin settings
- **Default**: If `\templatevariant` is not defined, defaults to essay layout
