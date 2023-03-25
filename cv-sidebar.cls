\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}
\LoadClass{article}

\RequirePackage{fontspec}
\RequirePackage[parfill]{parskip}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\usetikzlibrary{positioning, shapes}

\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{hyperref}
\RequirePackage{enumitem}
\RequirePackage{tabularx}
\RequirePackage{titlesec}

\newcommand\padding{1cm}
\newcommand\iconDistance{.5em}

\newcommand\sidebarWidth{7cm}
\newcommand\sidebarSectionPadding{.5cm}

\newcommand\logoWidth{\dimexpr\sidebarWidth-\padding-\padding\relax}
\newcommand\mainWidth{\paperwidth-\sidebarWidth}
\newcommand\contentWidth{\dimexpr%
	\mainWidth-\padding-\padding%
	\relax}
\newcommand\contentOffset{\dimexpr\sidebarWidth+\padding\relax}

\RequirePackage
	[ top=\padding
	, left=\contentOffset
	, bottom=0cm
	, right=\padding
	, noheadfoot
	]{geometry}

\setlength{\topskip}{0cm}
\setlength{\parindent}{0cm}
\setlength{\parskip}{0cm}
\setlength{\marginparsep}{0cm}
\setlength{\marginparwidth}{0cm}
\setlength{\marginparpush}{0cm}

% lengths for textpos package
\setlength{\TPHorizModule}{\padding}
\setlength{\TPVertModule}{\TPHorizModule}

\setlist{nolistsep, leftmargin=0cm, topsep=0cm, partopsep=0cm}

\titlespacing*{\section}{0pt}{0pt}{0pt}

\makeatletter
\renewcommand{\@seccntformat}[1]{}
\makeatother

%https://tex.stackexchange.com/questions/68272/make-section-headings-invisible/68296#68296
\newcommand\invisiblesection[1]{%
  \refstepcounter{section}%
  \addcontentsline{toc}{section}{\protect\numberline{\thesection}#1}%
  \sectionmark{#1}%
}
\newcommand\historyItemSection[1]{%
  \refstepcounter{subsection}%
  \addcontentsline{toc}{subsection}{\protect\numberline{\thesubsection}#1}%
  \sectionmark{#1}%
}

\newenvironment{profile}[1]{%
	\begin{tikzpicture}[overlay, remember picture]
		\node
			[ rectangle
			, fill=highlightColor
			, anchor=north west
			, minimum width=\sidebarWidth
			, minimum height=\paperheight
			] (sidebar) at (current page.north west){};
	\end{tikzpicture}
	\textblock{5}(1,1)
		\invisiblesection{Profile}
		\includegraphics[width=\logoWidth]{#1}\\[\padding]
		% https://en.wikibooks.org/wiki/LaTeX/Tables#@_and_!_expressions
		% @{} is used to get rid of extra space
		\tabularx{\textwidth}{@{} c@{\hspace{\iconDistance}} X@{}}}
	{\endtabularx
	\endtextblock}
\newcommand\profileItem[2]{#1&#2\\}
\newcommand\profileItemWithGap[2]{#1&#2\\\noalign{\vspace{\sidebarSectionPadding}}}

% We use \tabularx instead of \begin{tabularx} because of some bug in tabularX. See https://mirrors.evoluso.com/CTAN/macros/latex/required/tools/tabularx.pdf, chapter 5 Macros, item \tabularx.
\newenvironment{details}
	{\tabularx{\textwidth}{@{} c@{\hspace{\iconDistance}} X@{}}}
	{\endtabularx}
\newcommand\detailItem[2]{%
	\begin{tikz}[baseline=(char.base)]%
		\node[minimum width=1.5em] (char) {#1};%
	\end{tikz}%
	&#2\\\noalign{\vspace{-0.2em}}}


\newenvironment{subDetails}
	{\tabularx{\dimexpr\textwidth-\iconDistance-2em\relax}{@{} c@{\hspace{\iconDistance}} X@{}}}
	{\endtabularx}

\newcommand\historyItem[3]{
	\begin{tikzpicture}
		\node
			[ outer sep=0cm
			, align=left
			, text width=\contentWidth
			, anchor=mid west
		] (clabeltext) {
			\historyItemSection{#1 (#2)}
			#1 \hfill #2

			#3
		};
		\draw
			[ draw=highlightColor
			, line width=.2em
			] (clabeltext.north west) -- (clabeltext.south west) {};
			
	\end{tikzpicture}
}

% get rid of page numbers
\pagestyle{empty}
