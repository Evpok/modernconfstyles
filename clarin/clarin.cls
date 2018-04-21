\RequirePackage{expl3}
\RequirePackage{l3keys2e}
\RequirePackage{xparse}

\ProvidesExplClass{clarin}{2018/04/20}{0.0.1}{The style for CLARIN annual conference conference papers and extended abstracts}
% Keep trace of submission/standalone mode
\bool_new:N\g_clarin_submission_bool
\bool_set_true:N\g_clarin_submission_bool

\keys_define:nn {lrec} {
	submission .bool_gset:N = \g_clarin_submission_bool,
	standalone .bool_gset_inverse:N = \g_clarin_submission_bool,
}

\ProcessKeysOptions{lrec}

% Provide alternative content depending if the paper is in submission version
\NewDocumentCommand\IfSubmission{+m +O{}}{
	\bool_if:nTF\g_clarin_submission_bool{#1}{#2}
}

% Keep trace of the use of hyperref
\bool_new:N\g_clarin_hyperref_bool
\bool_set_false:N\g_clarin_hyperref_bool
\AtBeginDocument{
	\@ifpackageloaded{hyperref}{
        \bool_set_true:N\g_clarin_hyperref_bool
	}{}
}

\LoadClass[a4paper, 11pt]{article}
\RequirePackage[margin=25mm]{geometry}

% Other page settings
\dim_gset:Nn\parindent{0cm}
\dim_gset:Nn\parskip{0cm}

% Fonts
\RequirePackage{fontspec}
	\setmainfont{TeX Gyre Termes}  % Modern open-source “Times Roman”
	\setlength{\baselineskip}{11pt}

% Title block
\box_new:N\clarin_titlebox

\tl_new:N\g_clarin_title_tl
\tl_new:N\g_clarin_author_tl

\dim_new:N\clarin_title_height
\dim_set:Nn\clarin_title_height{5cm}

\RenewDocumentCommand\title{+m}{\tl_gset:Nn\g_clarin_title_tl{#1}}
\RenewDocumentCommand\author{+m}{\tl_gset:Nn\g_clarin_author_tl{#1}}

\RenewDocumentCommand\maketitle{}{
    \vbox_set:Nn\clarin_titlebox{
        {\centering
            {\bfseries\fontsize{15pt}{17pt}\selectfont\tl_use:N\g_clarin_title_tl}
            \IfSubmission{}[
                \bool_if:nT\g_clarin_hyperref_bool{\pdfbookmark[1]{Title}{title}}
            ]
            \par
        }
        \vspace{0.2in}
        {\centering
            \tl_const:Nn\And{
                \end{tabular}
                \hspace{1in}
                \begin{tabular}[t]{c}
                    \bfseries
            }
            \tl_const:Nn\AND{
                \end{tabular}
                \par
                \dim_gadd:Nn\clarin_title_height{3cm}
                \vspace{0.25in}
                \begin{tabular}[t]{c}
                    \bfseries
            }
            \begin{tabular}[t]{c}
                \bfseries\tl_use:N\g_clarin_author_tl
            \end{tabular}
            \par
        }
    }
    \box_set_ht:Nn\clarin_titlebox{\clarin_title_height-\box_dp:N\clarin_titlebox}
    \box_use:N\clarin_titlebox
}

% Abstract
% > The width of the abstract text should be smaller than main body by about 6 mm on each side
\dim_const:Nn\clarin_abstract_width{\textwidth - 6mm*2}
\RenewDocumentEnvironment{abstract}{}{
    \centering
    \begin{minipage}{\dim_use:N\clarin_abstract_width}
        {\centering
            {\bfseries\fontsize{12pt}{14pt}\selectfont Abstract}
            \par
        }
        \vspace{\topsep}
}{
    \end{minipage}
    \par
}

\RequirePackage[pagestyles]{titlesec}
% Header and footer
% TODO: needs more LaTeX3 idiomatism
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

% Section titles
\titleformat{\section}{\normalfont\bfseries\fontsize{12pt}{14pt}\selectfont}{\thesection.}{1em}{}
\titlespacing*{\section}{0pt}{12pt minus \parskip}{3pt}

\titleformat{\subsection}{\normalfont\bfseries\fontsize{11pt}{13pt}\selectfont}{\thesubsection.}{1em}{}
\titlespacing*{\subsection}{0pt}{6pt minus \parskip}{3pt}

\titleformat{\subsubsection}{\normalfont\bfseries\fontsize{10pt}{12pt}\selectfont}{\thesubsubsection.}{1em}{}
\titlespacing*{\subsubsection}{0pt}{6pt minus \parskip}{0pt}

% Misc
\frenchspacing

\NewDocumentCommand\blfootnote{m}{
    \begingroup
        \tl_set_eq:NN\@thefnmark\relax
        \@footnotetext{#1}
        \addtocounter{footnote}{-1}
    \endgroup
}


% Set pdf metadata using hyperref
% TODO: rework `\name` et al to make them more easily parsable and provide more metadata here
\AtBeginDocument{
	\IfSubmission{}[
		\bool_if:nT\g_clarin_hyperref_bool{
			\hypersetup{
	            pdftitle=\tl_use:N\g_clarin_title_tl,
			}
		}
	]
}
