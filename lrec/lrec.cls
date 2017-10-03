\RequirePackage{expl3}
\RequirePackage{l3keys2e}
\RequirePackage{xparse}

\ProvidesExplClass{lrec}{2017/09/23}{0.0.1}{The style for LREC conference papers and extended abstracts}
% Keep trace of submission/standalone mode
\bool_new:N\g_lrec_submission_bool
\bool_set_true:N\g_lrec_submission_bool


\keys_define:nn {lrec} {
	submission .bool_gset:N = \g_lrec_submission_bool,
	standalone .bool_gset_inverse:N = \g_lrec_submission_bool,
}

\ProcessKeysOptions{lrec}

% Provide alternative content depending if the paper is in submission version
\NewDocumentCommand\IfSubmission{+m +O{}}{
	\bool_if:nTF\g_lrec_submission_bool{#1}{#2}
}

% Keep trace of the use of hyperref
\bool_new:N\g_lrec_hyperref_bool
\bool_set_false:N\g_lrec_hyperref_bool
\AtBeginDocument{
	\@ifpackageloaded{hyperref}{
        \bool_set_true:N\g_lrec_hyperref_bool
	}{}
}

\LoadClass[a4paper, 10pt, twocolumns]{article}
\RequirePackage[margin=19mm,
                top=25mm,
                columnsep=6.3mm]{geometry}

% Other page settings
\dim_gset:Nn\parindent{0cm}
\dim_gset:Nn\parskip{0cm}

% Allow a larger proportion of the column/page to be taken up with
% floats than the standard classes.  Also discourage the creation of
% columns/pages containing only floats.

% Maximum fraction of the page that can be occupied by floats:
\tl_gset:Nn\topfraction{.9}
\tl_gset:Nn\bottomfraction{.5}
\tl_gset:Nn\dbltopfraction{.9}	% 2-column floats

% Minimum fraction of page that can be occupied by text:
\tl_gset:Nn\textfraction{.1}

% Maximum fraction of a page that can be occupied by floats before a
% separate float page is produced:
\tl_gset:Nn\floatpagefraction{0.9}
\tl_gset:Nn\dblfloatpagefraction{.9}	% 2-column floats

% Footnotes
\tl_gset:Nn\footnotesize{\fontsize{9pt}{11pt}\selectfont}
\tl_gset:Nn\footnoterule{
   \vspace*{0.1cm}\noindent\rule{5cm}{0.001cm}\vspace*{0.1cm}
}

% Fonts
\RequirePackage{fontspec}
	\setmainfont{TeX Gyre Termes}  % Open-source “Times Roman”
	\setlength{\baselineskip}{11pt}

% Title block
\tl_new:N\g_lrec_title_tl
\tl_new:N\g_lrec_name_tl
\tl_new:N\g_lrec_address_tl
\tl_new:N\g_lrec_abstract_tl
\tl_new:N\g_lrec_keywords_tl

\RenewDocumentCommand\title{+m}{\tl_gset:Nn\g_lrec_title_tl{#1}}
\NewDocumentCommand\name{+m}{\tl_gset:Nn\g_lrec_name_tl{#1}}
\NewDocumentCommand\address{+m}{\tl_gset:Nn\g_lrec_address_tl{#1}}
\RenewDocumentCommand\abstract{+m}{\tl_gset:Nn\g_lrec_abstract_tl{#1}}
\NewDocumentCommand\keywords{m}{\tl_gset:Nn\g_lrec_keywords_tl{#1}}

% Meant for use only at the top of the first page (because of dirty spaces adjustments)
\RenewDocumentCommand\maketitle{}{
	\twocolumn[
		% Dirty fix for the fact that the first page top margin must be 3cm instead of 2.5cm
		\vspace*{.5cm}
		{\centering
			{\bfseries\fontsize{14pt}{16pt}\selectfont\tl_use:N\g_lrec_title_tl}
            \IfSubmission{}[
                \bool_if:nT\g_lrec_hyperref_bool{\pdfbookmark[1]{Title}{title}}
            ]
            \par
			\vspace{2em}
			{\large\bfseries\tl_use:N\g_lrec_name_tl}\par
			{\normalfont\fontsize{10pt}{12pt}\selectfont\tl_use:N\g_lrec_address_tl}\par
			\vspace{12pt}
			{\bfseries\fontsize{10pt}{12pt}\selectfont\abstractname}
            \IfSubmission{}[
                \bool_if:nT\g_lrec_hyperref_bool{\pdfbookmark[1]{Abstract}{abstract}}
            ]
            \par
		}
		{\normalfont\fontsize{9pt}{10pt}\selectfont
			\tl_use:N\g_lrec_abstract_tl
		}\par
		\vspace{12pt}
		\textbf{Keywords}:\, \tl_use:N\g_lrec_keywords_tl
		\vspace{12pt}
	]
}

% Header and footer
\RequirePackage[pagestyles]{titlesec}
	\newpagestyle{main}{
		\IfSubmission{
		}[
			\sethead{}{\ifnum\thepage>1 {\tl_use:N\g_lrec_title_tl}\fi}{}
			\setfoot{}{\thepage}{}
		]
	}
	\AtBeginDocument{
		\pagestyle{main}
	}

	\titleformat{\section}{\normalfont\bfseries\fontsize{12pt}{14pt}\selectfont\filcenter}{\thesection.}{1em}{}
	\titlespacing*{\section}{0pt}{12pt minus \parskip}{3pt}

	\titleformat{\subsection}{\normalfont\bfseries\fontsize{11pt}{13pt}\selectfont\filcenter}{\thesubsection.}{1em}{}
	\titlespacing*{\subsection}{0pt}{6pt minus \parskip}{3pt}

	\titleformat{\subsubsection}{\normalfont\bfseries\fontsize{10pt}{12pt}\selectfont\filcenter}{\thesubsubsection.}{1em}{}
	\titlespacing*{\subsubsection}{0pt}{6pt minus \parskip}{0pt}

% Set pdf metadata using hyperref
% TODO: rework `\name` et al to make them more easily parsable and provide more metadata here
\AtBeginDocument{
	\IfSubmission{}[
		\bool_if:nT\g_lrec_hyperref_bool{
			\hypersetup{
	            pdftitle=\tl_use:N\g_lrec_title_tl,
	            pdfkeywords=\tl_use:N\g_lrec_keywords_tl
			}
		}
	]
}

% Legacy commands
\tl_set:Nn\maketitleabstract{\maketitle}
