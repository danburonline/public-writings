# LaTeX Template: One-Column vs Two-Column Layout Guide

This template supports both single-column and two-column layouts with customizable margins and float control.

## Basic Setup

The template uses the `multicol` package for column control and `geometry` for margin settings. These are already configured in `preamble.tex`.

## Two-Column Layout

To use a two-column layout for your main content with reduced margins:

```latex
\begin{document}
  % Front matter (title, abstract, TOC) - single column with default margins
  \maketitle
  \tableofcontents

  % Start two-column layout with reduced margins
  \newgeometry{left=1.5cm, right=1.5cm, top=2cm, bottom=2cm}
  \begin{multicols}{2}

    % Your main content here
    \section{Introduction}
    ...

  \end{multicols}  % End two-column layout
  \restoregeometry  % Restore default margins

  % Back matter (bibliography) - single column with default margins
  \bibliography{...}
\end{document}
```

## One-Column Layout

For a single-column document, simply omit the `multicols` environment:

```latex
\begin{document}
  % All content in single column
  \maketitle
  \tableofcontents

  \section{Introduction}
  ...

  \bibliography{...}
\end{document}
```

## Figures and Tables

### In Two-Column Layout

- **Single-column float**: Use `\begin{figure}` or `\begin{table}`

  - Float appears within one column only
  - Width should be `\columnwidth` or less

- **Double-column float**: Use `\begin{figure*}` or `\begin{table*}`
  - Float spans both columns
  - Width can be up to `\textwidth`
  - Appears at top or bottom of page

Example:

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

### In One-Column Layout

- Use standard `\begin{figure}` and `\begin{table}`
- Both `figure` and `figure*` behave the same way
- Width can be up to `\textwidth`

## Equations

For wide equations in two-column layout, use the `split` environment:

```latex
\begin{equation}
  \begin{split}
    \text{Long equation part 1} \\
    \text{Long equation part 2}
  \end{split}
  \label{eq:example}
\end{equation}
```

## Page Geometry

The template uses different margins for different parts of the document:

- **Front matter** (title, abstract, TOC): Default margins (3cm left/right, 2.5cm top/bottom)
- **Main content** (in multicols): Reduced margins (1.5cm left/right, 2cm top/bottom)
- **Bibliography**: Same as main content (reduced margins, two-column layout with smaller font)

### Single-Column Layout

Uses default margins (3cm left/right, 2.5cm top/bottom) for better readability.

### Two-Column Layout

To apply reduced margins to the main content:

```latex
% Before multicols
\newgeometry{left=1.5cm, right=1.5cm, top=2cm, bottom=2cm}
\begin{multicols}{2}
  % Content with reduced margins
\end{multicols}

% Bibliography also uses two-column with smaller font
\begin{multicols}{2}
  {\footnotesize
    \bibliography{...}
  }
\end{multicols}
```

Column settings:

- Column separation: 0.7cm
- No line between columns

## Tips

1. **Float placement**: The `dblfloatfix` package improves double-column float placement
2. **Column balance**: Content is automatically balanced between columns
3. **Page breaks**: Use `\newpage` to force content to the next page
4. **Column breaks**: Use `\columnbreak` to force content to the next column

## Common Issues

- **Overfull equations**: Break long equations using `split` or `align` environments
- **Figure placement**: LaTeX decides optimal placement; use `[ht!]` to suggest placement
- **Unbalanced columns**: Usually happens on the last page; this is normal behavior
