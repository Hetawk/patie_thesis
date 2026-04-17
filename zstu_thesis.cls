\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{zstu_thesis}[2024/04/01 Zhejiang Sci-Tech University Thesis Class]

% Engine detection and conditional loading
\RequirePackage{iftex}

\ifXeTeX
    % XeLaTeX specific settings
    \AddToHook{package/xeCJK/after}{\defaultCJKfontfeatures{}}
    \PassOptionsToPackage{AutoFakeBold}{xeCJK}
    \LoadClass[UTF8,a4paper,twoside,openany,fontset=none]{ctexrep}
\else
    % pdfLaTeX specific settings - use windows fontset as fallback
    \LoadClass[UTF8,a4paper,twoside,openany,fontset=windows]{ctexrep}
\fi

\RequirePackage{tocloft}
\RequirePackage{ragged2e}
\RequirePackage{amsmath,amssymb,amsfonts,geometry,makeidx,graphicx,caption,verbatim,pdfpages,fancyhdr,placeins,xcolor,enumitem,float,chngcntr,setspace,etoolbox,longtable}
\RequirePackage{truncate}
\ifXeTeX
    % txfonts is OT1/T1-oriented and triggers TU font-shape warnings under XeLaTeX.
    % Keep Times-like math appearance with a Unicode-safe math package.
    \RequirePackage{newtxmath}
\else
    \RequirePackage{txfonts}
\fi
\RequirePackage[colorlinks=true,allcolors=black,unicode=true,bookmarksnumbered=true,bookmarksopen=true,pdfencoding=auto]{hyperref}
\RequirePackage[nameinlink]{cleveref}
\RequirePackage[linesnumbered,ruled,vlined]{algorithm2e}
\RequirePackage[backend=biber,style=gb7714-2015,gbnoauthor=true,gbnamefmt=lowercase,gbpunctin=false]{biblatex}
\DeclareFieldFormat[inproceedings]{booktitle}{#1[C]}
\DefineBibliographyStrings{english}{in={In:\ }}
\makeindex

% Font settings (only for XeLaTeX) — uses macOS system fonts
\ifXeTeX
    \setCJKmainfont[AutoFakeBold, AutoFakeSlant]{Songti SC}
    \setCJKsansfont[AutoFakeBold, AutoFakeSlant]{Heiti SC}
    \setCJKmonofont{STFangsong}

    \setCJKfamilyfont{st_}[AutoFakeBold, AutoFakeSlant]{Songti SC}
    \setCJKfamilyfont{fs_}[AutoFakeBold, AutoFakeSlant]{STFangsong}
    \setCJKfamilyfont{ht_}[AutoFakeBold, AutoFakeSlant]{Heiti SC}
    \setCJKfamilyfont{kt_}[AutoFakeBold, AutoFakeSlant]{STKaiti}

    % Define font-switch commands for XeLaTeX
    \providecommand{\songti}{}
    \providecommand{\heiti}{}
    \providecommand{\fangsong}{}
    \providecommand{\kaishu}{}
    \renewcommand{\songti}{\CJKfamily{st_}}
    \renewcommand{\heiti}{\CJKfamily{ht_}}
    \renewcommand{\fangsong}{\CJKfamily{fs_}}
    \renewcommand{\kaishu}{\CJKfamily{kt_}}
\fi

% Set page margins
\geometry{left=3.18cm,right=3.18cm,top=2.54cm,bottom=2.54cm}
\setlength{\headheight}{12.7pt}

% Body: 小四号 (12pt), 1.5× line spacing, justified, first-line indent 2 chars
\linespread{1.625}
\zihao{-4}
\setlength{\parindent}{2em}
\AtBeginDocument{\justifying}

\ctexset{
	chapter={
		name={Chapter\space,},
		number=\arabic{chapter},
		nameformat=\heiti\zihao{3}\bfseries,
		titleformat=\heiti\zihao{3}\bfseries,
		format=\centering\heiti\zihao{3}\bfseries,
		fixskip=true,
		beforeskip=6pt,
		afterskip=18pt,
		aftername=\quad,
	},
	section={
		format=\raggedright\heiti\zihao{-3}\bfseries,
		beforeskip=12pt,
		afterskip=6pt,
		aftername=\enspace,
	},
	subsection={
		format=\raggedright\heiti\zihao{4}\bfseries,
		beforeskip=6pt,
		afterskip=3pt,
		aftername=\enspace,
	},
	subsubsection={
		format=\raggedright\heiti\zihao{-4},
		beforeskip=3pt,
		afterskip=3pt,
		aftername=\enspace,
	},
	paragraph={
		format=\heiti\bfseries\zihao{-4},
		beforeskip=0ex,
		afterskip=1em,
	},
    contentsname={\hfill\textnormal{\zihao{3}\bfseries{Table of Contents}}\hfill},
}

% Footnote style
\renewcommand{\footnotesize}{\zihao{-5}}

% Reset figure/table counters at the beginning of each chapter
\counterwithin{figure}{chapter}
\counterwithin{table}{chapter}
\counterwithin{equation}{chapter}
\counterwithin{algocf}{chapter}
% Figure and table caption styles
\renewcommand{\figurename}{Figure}
\renewcommand{\tablename}{Table}
\renewcommand{\algorithmcfname}{Algorithm}
\crefname{figure}{Figure}{Figures}
\crefname{table}{Table}{Tables}
\renewcommand{\thefigure}{\arabic{chapter}-\arabic{figure}}
\renewcommand{\thetable}{\arabic{chapter}-\arabic{table}}
\renewcommand{\theequation}{\arabic{chapter}-\arabic{equation}}
\renewcommand{\thealgocf}{\arabic{chapter}-\arabic{algocf}}
\DeclareCaptionFont{five}{\zihao{5}\songti\bfseries}
\captionsetup[figure]{labelsep=quad,font=five}
\captionsetup[table]{labelsep=quad,font=five,position=top}
% Algorithm formatting
\SetAlgoCaptionSeparator{}
\SetAlCapFnt{\zihao{5}\songti}
\SetAlCapNameFnt{\quad\zihao{5}\songti\bfseries}
\setlength{\interspacetitleruled}{3pt}

% Table style
\newcommand{\settablefontsize}{\zihao{-5}}
\AtBeginEnvironment{tabular}{\settablefontsize}
\newenvironment{tablenotes}{%
  \par\vspace{2pt}\footnotesize
  \begin{list}{}{\setlength{\leftmargin}{0pt}\setlength{\labelwidth}{0pt}\setlength{\labelsep}{0pt}\setlength{\itemindent}{0pt}\setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}}%
}{%
  \end{list}\vspace{2pt}
}

% Float tuning: keep medium tables closer to surrounding text and reduce
% single-float pages with large blank whitespace.
\renewcommand{\topfraction}{0.9}
\renewcommand{\bottomfraction}{0.8}
\renewcommand{\textfraction}{0.07}
\renewcommand{\floatpagefraction}{0.8}
\setlength{\textfloatsep}{10pt plus 2pt minus 2pt}
\setlength{\intextsep}{10pt plus 2pt minus 2pt}
\setlength{\@fptop}{8pt}
\setlength{\@fpsep}{8pt plus 1fil}
\setlength{\@fpbot}{0pt plus 1fil}

% Define headers and footers
\fancypagestyle{tocstyle}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\fancyfoot[C]{\zihao{-5}\thepage}
}
\renewcommand{\chaptermark}[1]{\markboth{Chapter \thechapter\quad #1}{}}
\fancypagestyle{mainstyle}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0.3pt}
    \fancyhead[CO,CE]{\zihao{5}\fangsong\nouppercase{\leftmark}}
	\fancyfoot[C]{\zihao{-5}\thepage}
}

% Set table of contents style
\setlength\cftbeforetoctitleskip{0ex}
\setlength\cftaftertoctitleskip{0ex}
\setlength\cftbeforechapskip{0ex}
\setlength\cftbeforesecskip{0ex}
\setlength\cftbeforesubsecskip{0ex}
\renewcommand{\cftchapfont}{\zihao{-4}\heiti\bfseries}
\renewcommand{\cftsecfont}{\zihao{5}\songti}
\renewcommand{\cftsubsecfont}{\zihao{5}\songti}
\renewcommand{\cftsubsubsecfont}{\zihao{5}\fangsong}
\renewcommand{\cftchapdotsep}{\cftdotsep}
\renewcommand{\cftchappagefont}{\mdseries}
\renewcommand{\cftsecpagefont}{\mdseries}
\renewcommand{\cftdotsep}{1}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\setlength{\cftchapnumwidth}{5.5em}
\setlength{\cftsecindent}{1.5em}
\setlength{\cftsecnumwidth}{2.0em}
\setlength{\cftsubsecindent}{3.8em}
\setlength{\cftsubsecnumwidth}{2.8em}
\setlength{\cftsubsubsecindent}{6.8em}
\setlength{\cftsubsubsecnumwidth}{3.5em}

% ---------------------------------------------------------------
% List of Figures / List of Tables
% ---------------------------------------------------------------
\renewcommand{\cftfigfont}{\zihao{5}\songti}
\renewcommand{\cftfigpagefont}{\zihao{5}\mdseries}
\renewcommand{\cftfigdotsep}{\cftdotsep}
\renewcommand{\cftfigleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cfttabfont}{\zihao{5}\songti}
\renewcommand{\cfttabpagefont}{\zihao{5}\mdseries}
\renewcommand{\cfttabdotsep}{\cftdotsep}
\renewcommand{\cfttableader}{\cftdotfill{\cftdotsep}}

\renewcommand{\cftloftitlefont}{\hfill\heiti\zihao{3}\bfseries}
\renewcommand{\cftafterloftitle}{\hfill}
\setlength{\cftbeforeloftitleskip}{0pt}
\setlength{\cftafterloftitleskip}{12pt}
\renewcommand{\cftlottitlefont}{\hfill\heiti\zihao{3}\bfseries}
\renewcommand{\cftafterlottitle}{\hfill}
\setlength{\cftbeforelottitleskip}{0pt}
\setlength{\cftafterlottitleskip}{12pt}

% ---------------------------------------------------------------
% List of Equations
% ---------------------------------------------------------------
\newlistof{myeqs}{loq}{List of Equations}
\renewcommand{\cftloqtitlefont}{\hfill\heiti\zihao{3}\bfseries}
\renewcommand{\cftafterloqtitle}{\hfill}
\setlength{\cftbeforeloqtitleskip}{0pt}
\setlength{\cftafterloqtitleskip}{12pt}
\renewcommand{\cftmyeqsfont}{\zihao{5}\songti}
\renewcommand{\cftmyeqspagefont}{\zihao{5}\mdseries}
\renewcommand{\cftmyeqsdotsep}{\cftdotsep}
\renewcommand{\cftmyeqsleader}{\cftdotfill{\cftdotsep}}

\AtEndEnvironment{equation}{%
  \addcontentsline{loq}{myeqs}{\protect\numberline{(\theequation)}}%
}

% Abstract without page number
\pagestyle{empty}

% Bibliography style
\defbibheading{MyBibHeadingStyle}{
	\phantomsection
	\pdfbookmark[1]{References}{bookmark:References}
    \markboth{References}{References}
	\cftaddtitleline{toc}{chapter}{References}{\thepage}
	\begin{center}
		\heiti\zihao{3}\bfseries{References}
	\end{center}
}
\addbibresource[location=local]{reference.bib}

% Create table of contents
\newcommand{\maketoc}{
	\pdfbookmark[1]{Contents}{bookmark:Contents}
	\pagestyle{tocstyle}
	\fancypagestyle{plain}{
		\pagestyle{tocstyle}
	}
	{\setstretch{1.2}\tableofcontents}

	\newpage
	\pagestyle{mainstyle}
	\fancypagestyle{plain}{
		\pagestyle{mainstyle}
	}
}

% Insert bibliography
\newcommand{\makereference}{\printbibliography[heading=MyBibHeadingStyle]}

% ---------------------------------------------------------------
% List of Abbreviations environment
% ---------------------------------------------------------------
\newenvironment{abbreviations}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Abbreviations}
    \markboth{List of Abbreviations}{List of Abbreviations}
  \begin{center}
    \heiti\zihao{3}\bfseries List of Abbreviations
  \end{center}
  \vspace{1em}
  \zihao{5}
  \noindent
  \begin{longtable}{@{}l@{\hspace{2em}}l@{}}
  \toprule
  \textbf{Abbreviation} & \textbf{Full Term} \\
  \midrule
  \endhead
}{%
  \bottomrule
  \end{longtable}
}

% Chinese abstract
\newcommand{\abstractzh}[2]{
	\phantomsection
	\pdfbookmark[1]{摘要}{bookmark:Abstract-Chinese}
	\cftaddtitleline{toc}{chapter}{摘要（中文）}{\thepage}
	\begin{center}\heiti\zihao{3}\bfseries 摘要\end{center}
	\zihao{-4}

	#1

	\vspace{1ex}\noindent\heiti{关键词：}\songti#2
	\newpage
}

% English abstract
\newcommand{\abstracten}[2]{
	\phantomsection
	\pdfbookmark[1]{Abstract}{bookmark:Abstract}
	\cftaddtitleline{toc}{chapter}{Abstract}{\thepage}
	\begin{center}\bfseries\zihao{3}Abstract\end{center}
	\zihao{-4}

	#1

	\vspace{1ex}\noindent\textbf{Keywords: }#2
	\newpage
}

% Acknowledgements
\newenvironment{acknowledgement}{
	\phantomsection
	\pdfbookmark[1]{Acknowledgements}{bookmark:Acknowledgements}
	\cftaddtitleline{toc}{chapter}{Acknowledgements}{\thepage}
    \markboth{Acknowledgements}{Acknowledgements}
	\begin{center}\heiti\zihao{3}\bfseries Acknowledgements\end{center}

	\indent
}{
	\newpage
}

% Set spacing for ordered/unordered lists
\setenumerate[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}
\setitemize[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}
\setdescription{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}

% Custom cover page commands
\RequirePackage{tikz}
\RequirePackage{geometry}
\RequirePackage{array}

% ---------------------------------------------------------------
% Cover page metadata variables
% ---------------------------------------------------------------
\newcommand{\@studentnum}{}
\newcommand{\@chinesetitle}{}
\newcommand{\@englishtitle}{}
\newcommand{\@authorname}{}
\newcommand{\@category}{}
\newcommand{\@completiondate}{}

% Setter commands (called from main.tex)
\newcommand{\studentnum}[1]{\renewcommand{\@studentnum}{#1}}
\newcommand{\chinesetitle}[1]{\renewcommand{\@chinesetitle}{#1}}
\newcommand{\englishtitle}[1]{\renewcommand{\@englishtitle}{#1}}
\newcommand{\authorname}[1]{\renewcommand{\@authorname}{#1}}
\newcommand{\category}[1]{\renewcommand{\@category}{#1}}
\newcommand{\completiondate}[1]{\renewcommand{\@completiondate}{#1}}

% Convenience: spread a label to fixed width
\newlength{\zstu@labelwd}
\setlength{\zstu@labelwd}{6em}
\newcommand{\zstulabel}[1]{\makebox[\zstu@labelwd][s]{#1}}

% ---------------------------------------------------------------
% Cover page (ZSTU format — based on screenshot)
% ---------------------------------------------------------------
\newcommand{\makecover}{
    \newpage
    \thispagestyle{empty}

    \vspace*{-1cm}

    % University name image at top
    \begin{center}
        \includegraphics[width=0.55\textwidth]{figures/default/zstu_logo_and_name.jpg}
    \end{center}

    \vspace{0.8cm}

    % 硕士学位论文 （学术学位）
    \begin{center}
        {\heiti\bfseries\fontsize{42}{52}\selectfont 硕士学位论文}\\[0.6em]
        {\heiti\fontsize{18}{22}\selectfont （学术学位）}
    \end{center}

    \vspace{1.0cm}

    % University logo
    \begin{center}
        \includegraphics[width=0.24\textwidth]{figures/default/zstu_logo.jpg}
    \end{center}

    \vspace{1.0cm}

    % Chinese title + English title
    \begin{center}
        \begin{minipage}{0.85\textwidth}
            \centering
            {\heiti\zihao{3}\@chinesetitle}
        \end{minipage}

        \vspace{0.8em}

        \begin{minipage}{0.85\textwidth}
            \centering
            {\bfseries\rmfamily\fontsize{14}{20}\selectfont \@englishtitle}
        \end{minipage}
    \end{center}

    \vspace{1.5cm}

    % Metadata table
    \begin{center}
        \fontsize{14}{24}\selectfont\songti
        \renewcommand{\arraystretch}{1.8}
        \begin{tabular}{r@{：}l}
            \zstulabel{论\hfill 文\hfill 编\hfill 号} &
                \underline{\makebox[6cm][c]{\@studentnum}} \\
            \zstulabel{姓\hfill 名} &
                \underline{\makebox[6cm][c]{\@authorname}} \\
            \zstulabel{类别（领域）} &
                \underline{\makebox[6cm][c]{\@category}} \\
        \end{tabular}
    \end{center}

    \vfill

    % Completion date
    \begin{center}
        {\songti\zihao{3}\bfseries 完成日期：\@completiondate}
    \end{center}

    \vspace{1.5cm}
    \newpage
}


% ---------------------------------------------------------------
% Integrity declaration page (原创性声明) — ZSTU version
% ---------------------------------------------------------------
\newcommand{\makeintegritydeclaration}{
    \newpage
    \thispagestyle{empty}
    \vspace*{1.2cm}

    % ---- 原创性声明 ----
    \begin{center}
        {\heiti\zihao{-2}\bfseries 原\enspace 创\enspace 性\enspace 声\enspace 明}
    \end{center}
    \vspace{1em}
    \zihao{-4}\setlength{\parindent}{2em}
    \par
    本人郑重声明：所呈交的学位论文，是本人在导师的指导下，独立进行研究所取得的成果。除文中已经注明引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写过的科研成果。对本文的研究作出重要贡献的个人和集体，均已在文中以明确方式标明。本人完全意识到本声明的法律责任由本人承担。

    \vspace{2.5em}
    \noindent\hfill
    论文作者签名：\underline{\hspace{4cm}}\quad
    日\enspace 期：\underline{\hspace{3cm}}

    \newpage
}

% ---------------------------------------------------------------
% Back cover page (empty or blank for ZSTU)
% ---------------------------------------------------------------
\newcommand{\makeendpage}{
    \clearpage
    \thispagestyle{empty}
    \null
    \clearpage
}
