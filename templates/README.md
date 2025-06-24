# LaTeX Template

This template system provides a unified preamble ([`preamble.tex`](/templates/preamble.tex)) that supports two distinct layout variants optimised for different document types. You control which variant to use by defining `\templatevariant` **before** inputting the preamble.

## Template Variants

### Essay Variant (`essay`) – Default

- **Purpose**: Long-form essays and single-column documents
- **Layout**: Single-column with generous margins
- **Margins**: 4cm left/right, 3cm top/3.5cm bottom for readability
- **Font**: TeX Gyre Termes (Times clone) with standard sizing

### Paper Variant (`paper`)

- **Purpose**: Academic papers and pre-prints
- **Layout**: Optimised for two-column layout with `multicol` package support
- **Margins**: 3cm left/right, 2.5cm top/3cm bottom (more compact)
- **Font**: TeX Gyre Termes (Times clone) with standard sizing
- **Additional packages**: Includes `multicol` and `dblfloatfix` for advanced layouts

## Usage

### For Essays (Single Column)

Define the template variant as "essay" **before** inputting the preamble:

```latex
\documentclass[11pt]{article}

% Define template variant BEFORE loading preamble
\providecommand{\templatevariant}{essay}
\input{../../../templates/preamble.tex}

\begin{document}
  % All content in single column with generous margins
  \maketitle
  \tableofcontents

  \section{Introduction}
  ...

  \bibliography{references}
\end{document}
```

**Note**: If you don't specify `\templatevariant`, it defaults to "essay" layout.

### For Papers (Two Column)

Define the template variant as "paper" **before** inputting the preamble:

```latex
\documentclass[10pt]{article}

% Define template variant BEFORE loading preamble
\providecommand{\templatevariant}{paper}
\input{../../../templates/preamble.tex}

\begin{document}
  % Front matter (title, abstract, TOC) - single column with default margins
  \maketitle
  \tableofcontents

  % Start two-column layout with reduced margins
  \newgeometry{left=1.5cm, right=1.5cm, top=2cm, bottom=2cm}
  \begin{multicols}{2}

    % Your main content here in two columns
    \section{Introduction}
    ...

  \end{multicols}  % End two-column layout
  \restoregeometry  % Restore default margins

  % Back matter (bibliography) - single column with default margins
  \bibliography{references}
\end{document}
```

## Key Features

### Automatic Package Loading

- **Common packages**: Both variants load essential packages (fonts, maths, tables, citations, etc.)
- **Variant-specific packages**: Paper variant automatically loads `multicol` and `dblfloatfix`
- **Smart conditionals**: The preamble uses `\ifx` conditionals to load appropriate packages

### Typography & Layout

- **Font**: TeX Gyre Termes (Times clone) with T1 encoding
- **Microtype**: Enhanced typography and justification
- **Custom spacing**: Optimised line spacing and list formatting
- **Hyperlinks**: Configured with blue colours and proper line breaking

### Citations & Bibliography

- **natbib**: Advanced citation management
- **Custom styling**: Bibliography formatted with proper spacing and alignment
- **References title**: Automatically uses "References" instead of "Bibliography"

## Figures and Tables

### In Essay Variant (Single Column)

- Use standard `\begin{figure}` and `\begin{table}`
- Width can be up to `\textwidth`
- Simple, straightforward layout

```latex
\begin{figure}[ht]
  \centering
  \includegraphics[width=0.8\textwidth]{image.png}
  \floatcaption{Figure title}{Detailed description}
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
  \floatcaption{Single column figure}{Description}
\end{figure}

% Double column figure
\begin{figure*}[ht]
  \centering
  \includegraphics[width=\textwidth]{image.png}
  \floatcaption{Double column figure}{Spanning both columns}
\end{figure*}
```

## Custom Commands

The preamble provides several custom commands:

- **`\floatcaption{title}{description}`**: Enhanced caption formatting
- **Code listings**: Pre-configured with syntax highlighting
- **Custom colours**: Defined for code and styling

## Technical Details

The unified preamble uses LaTeX conditionals to check the value of `\templatevariant`:

- **Essay variant (default)**: Single-column settings with generous margins
- **Paper variant**: Loads additional packages (`multicol`, `dblfloatfix`) with compact margins
- **Conditional loading**: Uses `\ifx\templatevariant\papervariant` to determine package loading
- **Fallback**: If `\templatevariant` is not defined, `\providecommand` ensures essay layout

## Important Notes

1. **Order matters**: Always define `\templatevariant` **before** inputting the preamble
2. **Use `\providecommand`**: This prevents errors if the command is already defined
3. **Package compatibility**: The preamble loads packages in the correct order to avoid conflicts
4. **Hyperref**: Loaded last to ensure proper functionality with other packages
