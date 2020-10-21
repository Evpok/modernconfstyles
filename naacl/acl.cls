\RequirePackage{expl3}
\RequirePackage{l3keys2e}
\RequirePackage{xparse}

% Inherit from article
\LoadClass[a4paper, twocolumns]{article}

\ProvidesExplClass{acl}{2018/05/25}{0.0.1}{The style for acl conference papers and extended abstracts}
% ## Class options processing
\bool_new:N\g_acl_submission_bool
\bool_set_true:N\g_acl_submission_bool

\bool_new:N\g_acl_hyperref_requested
\bool_set_true:N\g_acl_hyperref_requested

\bool_new:N\g_acl_final
\bool_set_false:N\g_acl_final

\keys_define:nn {acl} {
	standalone .bool_gset_inverse:N = \g_acl_submission_bool,
	hyperref .bool_gset:N = \g_acl_hyperref_requested,
	nonhyperref .bool_gset_inverse:N = \g_acl_hyperref_requested,
	final .bool_gset:N = \g_acl_final,
	submission .bool_gset_inverse:N = \g_acl_final,
}

\ProcessKeysOptions{acl}

% Provide alternative content depending if the paper is in submission version
\NewDocumentCommand\IfSubmission{+m +O{}}{
	\bool_if:nTF\g_acl_submission_bool{#1}{#2}
}

% Convenience: use hyperref depending on class options
\bool_if:nTF\g_acl_hyperref_requested{
	\RequirePackage{hyperref}
}{
	\cs_new:Npn\href#1#2{{#2}}

}
% Keep track of the use of hyperref
\bool_new:N\g_acl_hyperref_bool
\bool_set_false:N\g_acl_hyperref_bool
\AtBeginDocument{
	\@ifpackageloaded{hyperref}{
        \bool_set_true:N\g_acl_hyperref_bool
	}{}
}

% ## Geometry
% ### General Layout
\RequirePackage[
	margin=25mm,
    columnsep=6mm,
]{geometry}
\dim_new:N\acl_title_height
\dim_set:Nn\acl_title_height{5cm}

% ### Other dimensional settings
\dim_gset:Nn\parindent{1em}

% #### Section titles
\RequirePackage[pagestyles]{titlesec}
\titleformat{\section}{\normalfont\bfseries\fontsize{12pt}{14pt}\selectfont\raggedright}{\thesection}{1em}{}
\titlespacing*{\section}{0pt}{2.0ex plus 0.5ex minus .2ex}{1.5ex plus 0.3ex minus .2ex}{}

\titleformat{\subsection}{\normalsize\bfseries\raggedright}{\thesubsection}{1em}{}
\titlespacing*{\subsection}{0pt}{1.8ex plus 0.5ex minus .2ex}{0.8ex plus .2ex}{}

\titleformat{\subsubsection}{\normalsize\bfseries\raggedright}{\thesubsubsection}{1em}{}
\titlespacing*{\subsubsection}{0pt}{1.5ex plus 0.5ex minus .2ex}{0.5ex plus .2ex}{}

\titleformat{\paragraph}{\normalsize\bfseries}{\theparagraph}{1em}{}
\titlespacing*{\paragraph}{0pt}{1.5ex plus 0.5ex minus .2ex}{-1em}{}

\titleformat{\subparagraph}{\normalsize\bfseries}{\thesubparagraph}{1em}{}
\titlespacing*{\subparagraph}{0pt}{1.5ex plus 0.5ex minus .2ex}{-1em}{}

% #### Footnotes
\dim_gset:Nn\footnotesep{6.65pt}
% \skip_gset:Nn\footins{9pt plus 4pt minus 2pt}
\tl_gset:Nn\footnoterule{
   \kern-3pt \hrule width 5pc \kern 2.6pt
}

% #### Lists
\skip_gset:Nn\topsep{4pt plus 1pt minus 2pt}
\skip_gset:Nn\partopsep{1pt plus 0.5pt minus 0.5pt}
\skip_gset:Nn\itemsep{2pt plus 1pt minus 0.5pt}
\skip_gset:Nn\parsep{2pt plus 1pt minus 0.5pt}


% ## Colours
\RequirePackage{xcolor}

% ## Fonts
\RequirePackage{fontspec}
	\setmainfont{TeX Gyre Termes}  % Open-source “Times Roman”
	\setlength{\baselineskip}{11pt}

% Title block
\tl_new:N\g_acl_title_tl
\tl_new:N\g_acl_name_tl
\tl_new:N\g_acl_address_tl
\tl_new:N\g_acl_abstract_tl
\tl_new:N\g_acl_keywords_tl

\RenewDocumentCommand\title{+m}{\tl_gset:Nn\g_acl_title_tl{#1}}
\NewDocumentCommand\name{+m}{\tl_gset:Nn\g_acl_name_tl{#1}}
\NewDocumentCommand\address{+m}{\tl_gset:Nn\g_acl_address_tl{#1}}
\RenewDocumentCommand\abstract{+m}{\tl_gset:Nn\g_acl_abstract_tl{#1}}
\NewDocumentCommand\keywords{m}{\tl_gset:Nn\g_acl_keywords_tl{#1}}

% Meant for use only at the top of the first page (because of dirty spaces adjustments)
% TODO: Make this more LaTeX3-y, maybe through using l3coffins ?
\RenewDocumentCommand\maketitle{}{
	\twocolumn[
		\vbox_to_ht:nn{\acl_title_height}{
			{\centering
				{\bfseries\fontsize{14pt}{16pt}\selectfont\tl_use:N\g_acl_title_tl}
	            \IfSubmission{}[
	                \bool_if:nT\g_acl_hyperref_bool{\pdfbookmark[1]{Title}{title}}
	            ]
			}
		}
	]
}

% Header and footer
% TODO: needs more LaTeX3 idiomatism
\newpagestyle{main}{
	\IfSubmission{
	}[
		\sethead{}{\ifnum\thepage>1 {\tl_use:N\g_acl_title_tl}\fi}{}
		\setfoot{}{\thepage}{}
	]
}
\AtBeginDocument{
	\pagestyle{main}
}

% Set pdf metadata using hyperref
% TODO: rework `\name` et al to make them more easily parsable and provide more metadata here
\AtBeginDocument{
	\bool_if:nT\g_acl_hyperref_bool{
		\definecolor{darkblue}{rgb}{0, 0, 0.5}
		\hypersetup{
            pdftitle=\tl_use:N\g_acl_title_tl,
            pdfkeywords=\tl_use:N\g_acl_keywords_tl,
			colorlinks=true,
			citecolor=darkblue,
			linkcolor=darkblue,
			urlcolor=darkblue,
		}
	}
}

% Legacy commands for backward compatibility
\cs_new:Npn\Thanks#1{\thanks{\ #1}}
