\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ujn_thesis}[2024/02/06 University of Jinan Thesis Class]

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
\RequirePackage{txfonts}
\RequirePackage[colorlinks=true,allcolors=black,unicode=true,bookmarksnumbered=true,bookmarksopen=true,pdfencoding=auto]{hyperref}
\RequirePackage[nameinlink]{cleveref}
\RequirePackage[linesnumbered,ruled,vlined]{algorithm2e}
% \RequirePackage[backend=biber,style=gb7714-2015,gbnoauthor=true,gbnamefmt=lowercase]{biblatex}
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
	contentsname={\hfill\textnormal{\zihao{3}\heiti\bfseries{目\quad 录}}\hfill},
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

% Automatically truncate long LoF/LoT entries to fit on one line.
% Defined at class level (not inside \AtBeginDocument) so that parameter
% characters (#) are handled by plain \def rules with no doubling.
\newlength{\ujn@lof@maxwidth}
% Parse each .lof entry: keep \numberline{label} intact so tocloft renders
% the number column correctly, and truncate only the caption text after it.
\def\ujn@truncate@lof@entry\numberline#1#2\@nil{%
  \numberline{#1}%
  \sbox\z@{\truncate{\ujn@lof@maxwidth}{#2}}%
  \ifdim\wd\z@>\dimexpr\ujn@lof@maxwidth+1pt\relax
    % \truncate could not handle complex content; hard-clip the box
    \sbox\z@{#2}%
    \wd\z@=\dimexpr\ujn@lof@maxwidth-1em\relax
    \box\z@\,{\normalfont\dots}%
  \else
    \unhbox\z@
  \fi
}
% Override tocloft's \l@figure and \l@table here (after tocloft is loaded).
\let\ujn@orig@l@figure\l@figure
\def\l@figure#1#2{%
  \ujn@orig@l@figure{\ujn@truncate@lof@entry#1\@nil}{#2}%
}
\let\ujn@orig@l@table\l@table
\def\l@table#1#2{%
  \ujn@orig@l@table{\ujn@truncate@lof@entry#1\@nil}{#2}%
}
% Set the caption text width at begin-document so geometry has finalised \textwidth.
\AtBeginDocument{%
  \setlength{\ujn@lof@maxwidth}{0.68\textwidth}%
}
% Algorithm formatting
\SetAlgoCaptionSeparator{}
\SetAlCapFnt{\zihao{5}\songti}
\SetAlCapNameFnt{\quad\zihao{5}\songti\bfseries}
\setlength{\interspacetitleruled}{3pt}

% Table style
\newcommand{\settablefontsize}{\zihao{-5}}
\AtBeginEnvironment{tabular}{\settablefontsize}

% Define headers and footers
\fancypagestyle{tocstyle}{
	\fancyhf{} % clear all header and footer fields
	\renewcommand{\headrulewidth}{0pt}
	\fancyfoot[C]{\zihao{-5}\thepage}
}
\fancypagestyle{mainstyle}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0.3pt}
	\fancyhead[CO]{\zihao{5}\fangsong{济南大学硕士学位论文}}
	\fancyhead[CE]{\zihao{5}\fangsong{\@title}}
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
% TOC indentation: chapter number needs room for "Chapter 1",
% sections start just past the chapter number, subsections indent modestly.
\setlength{\cftchapnumwidth}{5.5em}
\setlength{\cftsecindent}{1.5em}
\setlength{\cftsecnumwidth}{2.0em}
\setlength{\cftsubsecindent}{3.8em}
\setlength{\cftsubsecnumwidth}{2.8em}
\setlength{\cftsubsubsecindent}{6.8em}
\setlength{\cftsubsubsecnumwidth}{3.5em}

% ---------------------------------------------------------------
% List of Figures / List of Tables: format entries like reference thesis
% ---------------------------------------------------------------
\renewcommand{\cftfigfont}{\zihao{5}\songti}
\renewcommand{\cftfigpagefont}{\zihao{5}\mdseries}
\renewcommand{\cftfigdotsep}{\cftdotsep}
\renewcommand{\cftfigleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cfttabfont}{\zihao{5}\songti}
\renewcommand{\cfttabpagefont}{\zihao{5}\mdseries}
\renewcommand{\cfttabdotsep}{\cftdotsep}
\renewcommand{\cfttableader}{\cftdotfill{\cftdotsep}}

% Centre the LoF / LoT chapter-level titles (matching abbreviations style)
\renewcommand{\cftloftitlefont}{\hfill\heiti\zihao{3}\bfseries}
\renewcommand{\cftafterloftitle}{\hfill}
\setlength{\cftbeforeloftitleskip}{0pt}
\setlength{\cftafterloftitleskip}{12pt}
\renewcommand{\cftlottitlefont}{\hfill\heiti\zihao{3}\bfseries}
\renewcommand{\cftafterlottitle}{\hfill}
\setlength{\cftbeforelottitleskip}{0pt}
\setlength{\cftafterlottitleskip}{12pt}

% ---------------------------------------------------------------
% List of Equations -- fully automatic, like LoF/LoT
% Every numbered equation environment auto-adds itself via AtEndEnvironment.
% Analogous to how \caption{} auto-adds figures/tables to LoF/LoT.
% ---------------------------------------------------------------
\newlistof{myeqs}{loq}{List of Equations}
\renewcommand{\cftmyeqstitlefont}{\hfill\heiti\zihao{3}\bfseries}
\renewcommand{\cftaftermyeqstitle}{\hfill}
\setlength{\cftbeforeloqtitleskip}{0pt}
\setlength{\cftafterloqtitleskip}{12pt}
\renewcommand{\cftmyeqsfont}{\zihao{5}\songti}
\renewcommand{\cftmyeqspagefont}{\zihao{5}\mdseries}
\renewcommand{\cftmyeqsdotsep}{\cftdotsep}
\renewcommand{\cftmyeqsleader}{\cftdotfill{\cftdotsep}}

% Patch equation environment end to auto-add to LoQ
% (\AtEndEnvironment from etoolbox, already required above)
\AtEndEnvironment{equation}{%
  \addcontentsline{loq}{myeqs}{\protect\numberline{(\theequation)}}%
}

% Abstract without page number
\pagestyle{empty}

% Bibliography style
\defbibheading{MyBibHeadingStyle}{
	\phantomsection
	\pdfbookmark[1]{References}{bookmark:References}
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
	% Roman numbering starts in main.tex before abstract (page I)
	% and continues through LoF, LoT, LoQ, Abbreviations
	% Arabic numbering is set in main.tex just before Chapter 1
}

% Insert bibliography
\newcommand{\makereference}{\printbibliography[heading=MyBibHeadingStyle]}

% ---------------------------------------------------------------
% List of Abbreviations environment
% Usage: \begin{abbreviations} ABBR & Full Term \\ ... \end{abbreviations}
% ---------------------------------------------------------------
\newenvironment{abbreviations}{%
  \clearpage
  \phantomsection
  \addcontentsline{toc}{chapter}{List of Abbreviations}
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
	\begin{center}\heiti\zihao{3}\bfseries Acknowledgements\end{center}

	\indent
}{
	\newpage
}

% Set spacing for ordered/unordered lists
\setenumerate[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}
\setitemize[1]{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}
\setdescription{itemsep=0pt,partopsep=0pt,parsep=\parskip,topsep=5pt}

% Custom cover page commands - flexible and configurable
\RequirePackage{tikz}
\RequirePackage{geometry}
\RequirePackage{array}

% ---------------------------------------------------------------
% Cover page metadata variables
% ---------------------------------------------------------------
\newcommand{\@classificationnum}{}
\newcommand{\@studentnum}{}
\newcommand{\@degreetype}{}
\newcommand{\@degreelevel}{}
\newcommand{\@thesistitle}{}
\newcommand{\@englishtitle}{}
\newcommand{\@authorname}{}
\newcommand{\@supervisor}{}
\newcommand{\@cosupervisor}{}
\newcommand{\@discipline}{}
\newcommand{\@degreecategory}{}
\newcommand{\@defensedate}{}
\newcommand{\@defenseengdate}{}
\newcommand{\@degreeenglish}{}

% Setter commands (called from main.tex)
\newcommand{\classificationnum}[1]{\renewcommand{\@classificationnum}{#1}}
\newcommand{\studentnum}[1]{\renewcommand{\@studentnum}{#1}}
\newcommand{\degreetype}[1]{\renewcommand{\@degreetype}{#1}}
\newcommand{\degreelevel}[1]{\renewcommand{\@degreelevel}{#1}}
\newcommand{\thesistitle}[1]{\renewcommand{\@thesistitle}{#1}}
\newcommand{\englishtitle}[1]{\renewcommand{\@englishtitle}{#1}}
\newcommand{\authorname}[1]{\renewcommand{\@authorname}{#1}}
\newcommand{\supervisor}[1]{\renewcommand{\@supervisor}{#1}}
\newcommand{\cosupervisor}[1]{\renewcommand{\@cosupervisor}{#1}}
\newcommand{\discipline}[1]{\renewcommand{\@discipline}{#1}}
\newcommand{\degreecategory}[1]{\renewcommand{\@degreecategory}{#1}}
\newcommand{\defensedate}[1]{\renewcommand{\@defensedate}{#1}}
\newcommand{\defenseengdate}[1]{\renewcommand{\@defenseengdate}{#1}}
\newcommand{\degreeenglish}[1]{\renewcommand{\@degreeenglish}{#1}}

% Convenience: spread a label to fixed width (like Word "分散对齐")
\newlength{\ujn@labelwd}
\setlength{\ujn@labelwd}{4em}
\newcommand{\ujnlabel}[1]{\makebox[\ujn@labelwd][s]{#1}}

% ---------------------------------------------------------------
% Cover page (Chinese format, with sidebar background)
% ---------------------------------------------------------------
\newcommand{\makecover}{
    \newpage
    \thispagestyle{empty}
    \newgeometry{margin=0cm}

    % Background image
    \begin{tikzpicture}[remember picture, overlay]
        \node[anchor=north west, inner sep=0pt] at (current page.north west) {
            \includegraphics[width=\paperwidth, height=\paperheight]{images/default/top_cover_sidebar.jpg}
        };
    \end{tikzpicture}

    % Foreground content
    \begin{tikzpicture}[remember picture, overlay]

        % --- Top-right: 分类号 / 学号 (stacked, right-aligned) ---
        \node[anchor=north east, align=left, inner sep=0pt]
            at ([xshift=-2.0cm, yshift=-1.7cm]current page.north east) {
            \fontsize{10.5}{16}\selectfont\songti
            \ujnlabel{分 类 号}：\@classificationnum \\[0.4em]
            \makebox[\ujn@labelwd][s]{学\hfill 号}：\@studentnum
        };

        % --- 硕士学位论文 + （全日制研究生）---
        \node[anchor=center, text width=14cm, align=center]
            at ([yshift=6.8cm]current page.center) {
            \fontsize{42}{52}\selectfont\heiti\bfseries\@degreetype \\[0.6em]
            \fontsize{18}{22}\selectfont\heiti\@degreelevel
        };

        % --- English thesis title only ---
        \node[anchor=center, text width=13cm, align=center]
            at ([yshift=1.5cm]current page.center) {
            \fontsize{16}{24}\selectfont\bfseries\rmfamily\@englishtitle
        };

        % --- Author / advisor info table ---
        % Labels: 四号宋体 (14pt Songti), Values: 小三楷体 (15pt Kaishu)
        \node[anchor=center]
            at ([yshift=-4.2cm]current page.center) {
            \fontsize{14}{20}\selectfont\songti
            \renewcommand{\arraystretch}{2.3}
            \begin{tabular}{r@{：}l}
                \ujnlabel{作\hfill 者} &
                    \underline{\makebox[6.2cm][c]{\fontsize{15}{22}\selectfont\kaishu\@authorname}} \\
                \ujnlabel{指导教师} &
                    \underline{\makebox[6.2cm][c]{\fontsize{15}{22}\selectfont\kaishu\@supervisor}} \\
                \ujnlabel{合作导师} &
                    \underline{\makebox[6.2cm][c]{\fontsize{15}{22}\selectfont\kaishu\@cosupervisor}} \\
                \ujnlabel{学科名称} &
                    \underline{\makebox[6.2cm][c]{\fontsize{15}{22}\selectfont\kaishu\@discipline}} \\
                \ujnlabel{学位类别} &
                    \underline{\makebox[6.2cm][c]{\fontsize{15}{22}\selectfont\kaishu\@degreecategory}} \\
                \ujnlabel{答辩时间} &
                    \underline{\makebox[6.2cm][c]{\fontsize{15}{22}\selectfont\kaishu\@defensedate}} \\
            \end{tabular}
        };

    \end{tikzpicture}

    \restoregeometry
    \newpage
}

% ---------------------------------------------------------------
% English title page (after Chinese cover)
% ---------------------------------------------------------------
\newcommand{\makeenglishtitlepage}{
    \newpage
    \thispagestyle{empty}
    \vspace*{2.5cm}
    \begin{center}
        {\fontsize{16}{24}\selectfont\bfseries\rmfamily \@englishtitle}

        \vspace{2.2cm}
        {\fontsize{14}{20}\selectfont\rmfamily By}

        \vspace{0.6em}
        {\fontsize{14}{20}\selectfont\bfseries\rmfamily \@authorname}

        \vspace{2.2cm}
        {\fontsize{12}{18}\selectfont\rmfamily Under the Supervision of}

        \vspace{0.6em}
        {\fontsize{14}{20}\selectfont\bfseries\rmfamily \@supervisor}

        \vspace{2.2cm}
        {\fontsize{12}{18}\selectfont\rmfamily
            A Thesis Submitted to the University of Jinan \\[0.5em]
            In Partial Fulfillment of the Requirements \\[0.5em]
            For the Degree of \@degreeenglish
        }

        \vspace{2.2cm}
        {\fontsize{14}{21}\selectfont\bfseries\rmfamily University of Jinan}

        \vspace{0.4em}
        {\fontsize{12}{18}\selectfont\rmfamily Jinan, Shandong, P.\,R. China}

        \vspace{2cm}
        {\fontsize{12}{18}\selectfont\rmfamily \@defenseengdate}
    \end{center}
    \newpage
}

% ---------------------------------------------------------------
% Integrity declaration page (原创性声明 + 授权声明)
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

    \vspace{3.5em}

    % ---- 授权声明 ----
    \begin{center}
        {\heiti\zihao{-2}\bfseries 关于学位论文使用授权的声明}
    \end{center}
    \vspace{1em}
    \par
    本人完全了解济南大学有关保留、使用学位论文的规定，同意学校保留或向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅和借鉴；本人授权济南大学可以将学位论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或其他复制手段保存论文和汇编本学位论文。

    \vspace{1.5em}
    \noindent $\square$\,公开\qquad
    $\square$\,保密（\underline{\hspace{1.5cm}} 年，解密后应遵守此规定）

    \vspace{2.5em}
    \noindent
    论文作者签名：\underline{\hspace{3.5cm}}\quad
    导师签名：\underline{\hspace{3.5cm}}\quad
    日期：\underline{\hspace{2cm}}

    \newpage
}

% ---------------------------------------------------------------
% Back cover page
% ---------------------------------------------------------------
\newcommand{\makeendpage}{
    \clearpage
    \thispagestyle{empty}
    \newgeometry{margin=0cm}

    \begin{tikzpicture}[remember picture, overlay]
        \node[anchor=north west, inner sep=0pt] at (current page.north west) {
            \includegraphics[width=\paperwidth, height=\paperheight]{images/default/bottom_cover_sidebar.jpg}
        };
    \end{tikzpicture}

    \restoregeometry
    \clearpage
}
