%% LaTeX document class for formatting MIT Course-VI M.Eng. theses.

%% Authors:
%%     Benjamin Charrow <bcharrow@alum.mit.edu>
%%     Matthew Steele <mdsteele@alum.mit.edu>
%%     Krishna Sethuraman <krishna@athena.mit.edu>
%%     Peter Nuth <nuth@ai.mit.edu>
%%     Stephen Gildea <gildea@erl.mit.edu>

%% Last updated: 17 September 2009

%% This document class is a modified version of mitthesis.cls, which was
%% created by Stephen Gildea, Peter Nuth, and Krishna Sethuraman (see copyright
%% below).  It was transformed into mengthesis.cls by Matthew Steele to match
%% more closely the specific requirements for Course-VI M.Eng. theses.  It was
%% then almost unnoticeably modified by Ben Charrow. David Pitman added lots
%% of bloat by finding useful packages which made working in LaTex  and writing
%% a thesis easier.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                           %%
%% Modified mengthesis.cls
%%       Copyright (c) 2009, by Benjamin Charrow                             %%
%%                                                                           %%
%% Modified mitthesis.cls to create mengthesis.cls, which is made            %%
%% specifically for Course-VI M.Eng. theses.                                 %%
%%       Copyright (c) 2009, by Matthew Steele                               %%
%%                                                                           %%
%% Documentclass options (vi and upcase) and changes to copyright notice     %%
%%       Copyright (c) 1990, by Krishna Sethuraman.                          %%
%%                                                                           %%
%% Pagestyle and header generation                                           %%
%%       Copyright (c) 1987, 1988 by Peter Nuth                              %%
%%                                                                           %%
%% Original version                                                          %%
%%       Copyright (c) 1987 by Stephen Gildea                                %%
%%                                                                           %%
%% Permission to copy all or part of this work is granted, provided that the %%
%% copies are not made or distributed for resale, and that the copyright     %%
%% notice and this notice are retained.                                      %%
%%                                                                           %%
%% THIS WORK IS PROVIDED ON AN "AS IS" BASIS.  THE AUTHOR PROVIDES NO        %%
%% WARRANTY WHATSOEVER, EITHER EXPRESS OR IMPLIED, REGARDING THE WORK,       %%
%% INCLUDING WARRANTIES WITH RESPECT TO ITS MERCHANTABILITY OR FITNESS FOR   %%
%% ANY PARTICULAR PURPOSE.                                                   %%
%%                                                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%=============================================================================%

%% Available \documentclass options:

%% Option `11pt':
%%   Use an 11pt font (10pt by default).

%% Option `12pt':
%%   Use an 12pt font (10pt by default).

%% Option `draft':
%%   Puts `overfull' boxes at the end of lines that are too long.

%% Option `leftblank':
%%   If using the `twoside' option, marks extra blank pages with ``THIS PAGE
%%   INTENTIONALLY LEFT BLANK''.

%% Option `mitcopyright':
%%   Gives the thesis copyright to MIT instead of the author.

%% Option `singlespace':
%%   Single-spaces the document, for drafts (double-spaced by default).

%% Option `twoside':
%%   Prints double-sided, inserting extra blank pages as necessary.

%=============================================================================%

%% Parameters to initialize for boilerplate page:
%
%    \title{My Great Thesis Title}
%    \author{J. Random Student}
%    \prevdegrees{B.S., University of California (1978) \\
%                 S.M., Massachusetts Institute of Technology (1981)}
%    \degreemonth{June}
%    \degreeyear{2009}
%    \thesisdate{May 22, 2009}
%
%% If there is more than one supervisor, use the \supervisor and/or
%% \cosupervisor commands once for each.
%
%    \supervisor{John Doe}{Associate Professor, Department of Awesome}
%    \cosupervisor{Mary H. Lamb}{Director, Mutton Laboratory}
%
%% Make the titlepage based on the above information.  If you need
%% something special and can't use the standard form, you can specify
%% the exact text of the titlepage yourself.  Put it in a titlepage
%% environment and leave blank lines where you want vertical space.
%% The spaces will be adjusted to fill the entire page.  The dotted
%% lines for the signatures are made with the \signature command.

%% The abstractpage environment sets up everything on the page except
%% the text itself.  The title and other header material are put at the
%% top of the page, and the supervisors are listed at the bottom.  A
%% new page is begun both before and after.  Of course, an abstract may
%% be more than one page itself.  If you need more control over the
%% format of the page, you can use the abstract environment, which puts
%% the word "Abstract" at the beginning and single spaces its text.
%
%    \begin{abstractpage}
%      Abstract goes here.
%    \end{abstractpage}

%=============================================================================%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mengthesis}[2009/02/09]

%================================== OPTIONS ==================================%

\def\mystretch{1.5}  % Double spacing hack
\DeclareOption{doublespace}{}  % This is default
                               % So we do not read this style twice
\DeclareOption{singlespace}{   % If he explicitly wants single spacing
    \def\mystretch{1}}

%% mitcopyright option by Matthew Steele
\newif\if@mitcopyright \@mitcopyrightfalse
\DeclareOption{mitcopyright}{\@mitcopyrighttrue}

%% leftblank option by Kevin Fu
\newif\if@leftblank \@leftblankfalse
\DeclareOption{leftblank}{\@leftblanktrue}

%% Thesis looks much like report
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass{report}

% If the user wants single spacing, set baselinestretch=1.

\usepackage{setspace}

% Note - doublespace.sty has some float-related troubles in
% combination with graphics or color, and is not officially compliant
% with 2e.  setspace is a replacement which is 2e-compliant.

\def\baselinestretch{\mystretch} % Double spacing hack

%========================== MARGINS AND FORMATTING ===========================%

%% Note we want 1in top margin assuming no header line, so push header into 1in
%% margin.  Draft mode brings the header back down.

%% The Course-VI thesis guide (http://www.eecs.mit.edu/ug/thesis-guide.html)
%% requires at least 1in margins on all four sides, no exceptions.  We'll use
%% 1in margins on the top and bottom, and 1.1in margins on the left and right
%% (just in case an hbox overflows slightly).

\setlength{\oddsidemargin}{0.1in}       % 1.1in left margin.
\setlength{\evensidemargin}{0.1in}      % 1.1in left margin (even pages).
\setlength{\topmargin}{0.0in}           % 1.0in top margin.
\setlength{\textwidth}{6.3in}           % 6.3in text (1.1in right margin).
\setlength{\textheight}{9in}            % Body hieght for 1in bottom margin.
\addtolength{\topmargin}{-\headheight}  % No header, so compensate for header
\addtolength{\topmargin}{-\headsep}     %   height and separation.

% The next two macros compensate page style for headers and footers
% We only need them in page styles that USE headers and footers.

% If we have a header, it must be 1in from top of page.
\newcommand{\pulldownheader}  % Shift header down 1in from top
  {\addtolength{\topmargin}{\headheight}
   \addtolength{\topmargin}{\headsep}
   \addtolength{\textheight}{-\headheight}
   \addtolength{\textheight}{-\headsep}}

% If we have a footer, put it 1in up from bottom
\newcommand{\pullupfooter}  % Shift footer up
  {\addtolength{\textheight}{-\footskip}
%  \addtolength{\textheight}{-\footheight}  %footheight doesn't exist in 2e
  }

%============================ HEADERS AND FOOTERS ============================%

% Format for draft of thesis.  Define our own PageStyle -
% Just like headings, but has foot lines with the date and warning

\if@twoside  % If two-sided printing.
\def\ps@drafthead{
    \let\@mkboth\markboth
    \def\@oddfoot{\rm \today \hfil \sc **DRAFT**}
    \def\@evenfoot{\sc **DRAFT** \hfil \rm \today }
    \def\@evenhead{\rm \thepage\hfil \sl \leftmark}
    \def\@oddhead{\hbox{}\sl \rightmark \hfil \rm\thepage}
    \def\chaptermark##1{\markboth {\uppercase{\ifnum \c@secnumdepth >\m@ne
 \@chapapp\ \thechapter. \ \fi ##1}}{}}
    \def\sectionmark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\z@
 \thesection. \ \fi ##1}}}
    \pulldownheader  % Bring header down from edge
    \pullupfooter    % Bring footer up
}
\else  % If one-sided printing.
\def\ps@drafthead{
    \let\@mkboth\markboth
    \def\@oddfoot{\rm \today \hfil \sc **DRAFT**}
    \def\@oddhead{\hbox{}\sl \rightmark \hfil \rm\thepage}
    \def\chaptermark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\m@ne
 \@chapapp\ \thechapter. \ \fi ##1}}}
    \pulldownheader  % Bring header down from edge
    \pullupfooter    % Bring footer up
}
\fi

% I redefine these formats that were defined in report.sty
% Definition of 'headings' page style
%  Note the use of ##1 for parameter of \def\chaptermark inside the
%  \def\ps@headings.
%

\if@twoside     % If two-sided printing.
\def\ps@headings{\let\@mkboth\markboth
    \def\@oddfoot{}
    \def\@evenfoot{}  % No feet.
    \def\@evenhead{\rm \thepage\hfil \sl \leftmark}        % Left heading.
    \def\@oddhead{\hbox{}\sl \rightmark \hfil \rm\thepage} % Right heading.
    \def\chaptermark##1{\markboth {\uppercase{\ifnum \c@secnumdepth >\m@ne
 \@chapapp\ \thechapter. \ \fi ##1}}{}}
    \def\sectionmark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\z@
 \thesection. \ \fi ##1}}}
    \pulldownheader    % Bring header down from edge
}
\else      % If one-sided printing.
\def\ps@headings{\let\@mkboth\markboth
    \def\@oddfoot{}
    \def\@evenfoot{}  %     No feet.
    \def\@oddhead{\hbox {}\sl \rightmark \hfil \rm\thepage} % Heading.
    \def\chaptermark##1{\markright {\uppercase{\ifnum \c@secnumdepth >\m@ne
 \@chapapp\ \thechapter. \ \fi ##1}}}
    \pulldownheader    % Bring header down from edge
}
\fi

% Redefine '/chapter' to always start on an odd page.
% Should make no difference in singleside mode.
%
\if@leftblank
% Prints "THIS PAGE INTENTIONALLY LEFT BLANK" on blank pages.
\def\chapter{\clearpage\ifodd\c@page\else
   \hbox{}\par\vfill\centerline%
   {THIS PAGE INTENTIONALLY LEFT BLANK}%
   \vfill\newpage\fi
   \thispagestyle{plain} % Page style of chapter page is 'plain'
   \global\@topnum\z@  % Prevents figures from going at top of page.
   \@afterindentfalse  % Suppresses indent in first paragraph.  Change
   \secdef\@chapter\@schapter} % to \@afterindenttrue to have indent.
\else
\def\chapter{\cleardoublepage % Starts new page.
   \thispagestyle{plain} % Page style of chapter page is 'plain'
   \global\@topnum\z@  % Prevents figures from going at top of page.
   \@afterindentfalse  % Suppresses indent in first paragraph.  Change
   \secdef\@chapter\@schapter} % to \@afterindenttrue to have indent.
\fi
% If using the report style, use - instead of . in the figure number.
\@ifundefined{thechapter}{}{\def\thefigure{\thechapter-\arabic{figure}}}

%============================ COVER CUSTOMIZATION ============================%

%% Define all the pieces that go on the title page and the abstract.

%% \title and \author already exist

%% Month, year, and exact date of thesis.
\newcommand{\degreemonth}[1]{\gdef\@degreemonth{#1}}
\newcommand{\degreeyear}[1]{\gdef\@degreeyear{#1}}
\newcommand{\thesisdate}[1]{\gdef\@thesisdate{#1}}

%% Previous degrees (none by default).
\newcommand{\prevdegrees}[1]{\gdef\@prevdegrees{#1}}
\def\@prevdegrees{}

% These (inconsistent) copyright formats are specified by:
%   http://www.eecs.mit.edu/ug/thesis-guide.html
\if@mitcopyright
\def\@copyrightnotice{\copyright\@degreeyear\ Massachusetts Institute of
                      Technology\\  All rights reserved.}
\else
\def\@copyrightnotice{Copyright \@degreeyear\ \@author.  All rights reserved.
\par\noindent{\centering
  The author hereby grants to M.I.T. permission to reproduce and
  distribute publicly paper and electronic copies of this thesis
  document in whole and in part in any medium now known or
  hereafter created.}}
\fi

% The \copyrightnotice command can manually override the copyright notice.
\newcommand{\copyrightnotice}[1]{\gdef\@copyrightnotice{#1}}

% since there can be more than one supervisor,
% we build the appropriate boxes for the titlepage and
% the abstractpage as the user makes multiple calls
% to \supervisor
\newbox\@titlesupervisor
\newbox\@abstractsupervisor

\newcommand{\supervisor}[2]
  {\setbox\@titlesupervisor\vbox
   {\unvbox\@titlesupervisor \vskip 30pt% plus 1fil minus 1fil
   \def\baselinestretch{1}\large
   \signature{Certified by}{#1 \\ #2 \\ Thesis Supervisor}}
   \setbox\@abstractsupervisor\vbox{\unvbox\@abstractsupervisor
   \vskip\baselineskip \def\baselinestretch{1}\@normalsize
   \par\noindent Thesis Supervisor: #1 \\ Title: #2}}

\newcommand{\cosupervisor}[2]
  {\setbox\@titlesupervisor\vbox
   {\unvbox\@titlesupervisor \vskip 30pt% plus 1fil minus 1fil
   \def\baselinestretch{1}\large
   \signature{Certified by}{#1 \\ #2 \\ Thesis Co-Supervisor}}
   \setbox\@abstractsupervisor\vbox{\unvbox\@abstractsupervisor
   \vskip\baselineskip \def\baselinestretch{1}\@normalsize
   \par\noindent Thesis Co-Supervisor: #1 \\ Title: #2}}

%================================ TITLE PAGE =================================%

\renewcommand{\maketitle}
  {\begin{titlepage}
   \large
   {\def\baselinestretch{1.2}\Large\bf\@title}
   \par
   by
   \par
   {\Large\@author}
   \par
   \@prevdegrees
   \par
   Submitted to the Department of Electrical Engineering and Computer Science
   \par
   in partial fulfillment of the requirements for the Degree of
   \par
   Master of Engineering in Electrical Engineering and Computer Science
   \par
   at the Massachusetts Institute of Technology
   \par
   \@degreemonth\ \@degreeyear
   \par
   \@copyrightnotice
   \par
   \vskip 3\baselineskip
   \signature
       {Author}
       {Department of Electrical Engineering and Computer Science \\
        \@thesisdate}
   \par
   \vfill
   \unvbox\@titlesupervisor
   \par
   \vfill
   \signature
       {Accepted by}
       {Dennis M. Freeman \\
        Professor of Electrical Engineering \\
        Chairman, Department Committee on Graduate Theses}
   \vfill
   \end{titlepage}}

% You can use the titlepage environment to do it all yourself if you
% don't want to use \maketitle.  If the titlepage environment, the
% paragraph skip is infinitely stretchable, so if you leave a blank line
% between lines that you want space between, the space will stretch so
% that the title page fills up the entire page.
\renewenvironment{titlepage}
  {\cleardoublepage\centering
   \thispagestyle{empty}
   \parindent 0pt \parskip 10pt plus 1fil minus 1fil
   \def\baselinestretch{1}\@normalsize
   \vbox to \vsize\bgroup\vbox to 9in\bgroup}
  % The \kern0pt pushes any depth into the height.  Thanks to Richard Stone.
  {\par\kern 0pt\egroup\vss\egroup\newpage}

%=============================== ABSTRACT PAGE ===============================%

\newenvironment{abstractpage}
  {\cleardoublepage
   \parskip 10pt
   \begin{center}{\large{\bf \@title}\\
   by\\
   \@author \\[\baselineskip]}
   \par
   \def\baselinestretch{1}\@normalsize
   Submitted to the\\
   Department of Electrical Engineering and Computer Science
   \par
   \@thesisdate
   \par
   In partial fulfillment of the requirements for the Degree of\\
   Master of Engineering in Electrical Engineering and Computer Science
   \end{center}
   \par
   \begin{abstract}}
  {\end{abstract}\noindent\unvcopy\@abstractsupervisor\cleardoublepage}

%% This counter is used to save the page number for the second copy of
%% the abstract.
%\newcounter{savepage}

\renewenvironment{abstract}
  {\subsection*{Abstract}\small\def\baselinestretch{1}\@normalsize}
  {\par}

%============================= UTILITY COMMANDS ==============================%

\newcommand{\signature}[2]{\par\noindent#1\dotfill\null\\*{\raggedleft #2\par}}

%=============================================================================%
