LREC
====

This is an unofficial style for [The International Conference on Language Resources and Evaluation (LREC)](http://lrec-conf.org/). It works for both the extend abstract and final submissions.

Note that according to the official guidelines, using this should get you rejected

> You MUST use the LREC template for both the Extended Abstract and the Final Paper. If you do not, your submission will be rejected.


## How to use

  - Copy [`lrec.cls`](lrec.cls) (for the main class) and the [`lrec.cbx`](lrec.cbx), [`lrec.bbx`](lrec.bbx) and [`lrec.dbx`](lrec.dbx) files (for the biblatex style) somewhere where LaTeX will find them (the easiest is probably to use the forlder of your own `.tex` file, but your preferred `.txmf` should work, too)
  - Use `\documentclass{lrec}` and `\usepackage[backend=biber, style=lrec]{biblatex}`
  - See [`xample.tex`](xample.tex) for more details about what you can do

## Known limitations
The bibliography styles have not been extensively tested and might not work for all entry types, check yours before submission and submit bug reports if something is wrong.

## API
Listing only changes wrt the official template.

### Changed
  - We chose to use a document class instead of a package, as we felt it made more sense, since we are actually changing things like the title apparence or the page geometry.
  - The title block should be typeset using `\maketitle`. The original `\maketitleabstract` is aliased to it.
  - The `\keywords` commands is now a true standalone command that sets you keyword and not a mere formatting directive that goes in your abstract, though you should be able to keep using it as in the original template.
  - The `\cite`, `\newcite` and `\shortcite` commands work as advertised, but I would advise to use the more explicit `\parencite` and `\textcite` and to avoid using `\shortcite`.

### Added
  - The `submission=false` class option will try to give you a nicer look for out of proceeding, standalone versions of your article, most notably by adding headers and page numbers.
    - The `\IfSubmission{code if submission}{code if standalone}` gives you a way to change the content of your document depending on that option.


## Other deviations
### Style
The priority has been given to the format of the official templates over the [author's kit stylesheet](http://lrec2018.lrec-conf.org/en/submission/authors-kit/), as per the big scary red warning at the top of the latter, except for

  - The maximum number of people per list in the bibliography (four or more and you'll get an *et al.*.). The LaTeX template does not seem actually enforce it.
  - The dimensions are those mandated by the stylesheet and might slightly deviate from the official template's (see [below](### Dimensions))

### Font
In the spirit of the previous statement, we chose to use [TeX Gyre Thermes](http://www.gust.org.pl/projects/e-foundry/tex-gyre/termes) for the main font. The rationale is that

  - It should be available in all major TeX distributions
  - It supersedes [URW++ Nimbus Roman No9 L](https://www.urwpp.de/shop/?fontshop=datei:show_font_details;fontnummer:n021003l), the “Times” font used by default in LaTeX and the font used by the official template.
  - It has a good Unicode coverage and looks quite nice.

If you *really* want to use a commercial Times Roman or Times New Roman font, a judicious use of `fontspec`'s `\setmainfont` will do the trick, but it my experience it looked worse this way.

Fun fact : the only place where Times New Roman is explicitely mandated in the stylesheet is for heading 2 and 3, whereas the official (LaTeX) template mandates it for everything, but actually sets the font with

```latex
\renewcommand{\sfdefault}{phv}
\renewcommand{\rmdefault}{ptm}
\renewcommand{\ttdefault}{pcr}
```

and thus actually uses URW++ Nimbus Roman No9 L.

### Dimensions

The official template sets its dimensions in weird ways that I don't want to reverse-engineer, so I used mandated by the stylesheet.
Oddly, that lefts 0.7mm not accounted for, but instead of using them in [weird and pretty way](https://twitter.com/EvpokPadding/status/911674913412599808), I give them to you as extra text space.

You are welcome.
