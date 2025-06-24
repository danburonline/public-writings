# Templates: Essay vs Paper Templates

This template system provides two distinct templates optimized for different document types:

## Template Files

### Essay Template ([`essay-template.tex`](/templates/essay-template.tex))

- **Purpose**: Long-form essays, reports, and single-column documents
- **Font size**: 11pt (larger for comfortable reading)
- **Layout**: Single column throughout
- **Margins**: Extra generous margins (4cm left/right, 3cm top/3.5cm bottom) for readability

### Paper Template ([`paper-template.tex`](/templates/paper-template.tex))

- **Purpose**: Academic (pre-print) papers, conference submissions, journal articles
- **Font size**: 10pt (standard academic font size)
- **Layout**: Two-column support with `multicol` package
- **Margins**: Adjustable margins (default large for front matter, reduced for main content)

## Usage

### For Essays (Single Column)

Use the essay template for documents that need comfortable reading layout:

```latex
\documentclass[11pt]{article}
\input{../../../templates/essay-template.tex}

\begin{document}
  % All content in single column with 11pt font
  \maketitle
  \tableofcontents

  \section{Introduction}
  ...

  \bibliography{...}
\end{document}
```

### For Papers (Two Column)

Use the paper template for academic papers with two-column layout:

```latex
\documentclass[10pt]{article}
\input{../../../templates/paper-template.tex}

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

## Figures and Tables

### In Essay Template (Single Column)

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

### In Paper Template (Two Column)

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
