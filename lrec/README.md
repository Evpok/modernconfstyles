LREC
====

This is an unofficial style for [The International Conference on Language Resources and Evaluation (LREC)](http://lrec-conf.org/).
It works for both extended abstracts and final submissions.

Note that according to the official guidelines, using this should get you rejected

> You MUST use the LREC template for both the Extended Abstract and the Final Paper. If you do not, your submission will be rejected.
[LREC 2018 Autor's Kit][authorkit2018]


## How to use

  - Copy [`lrec.cls`](lrec.cls) (for the main class) and the [`lrec.cbx`](lrec.cbx), [`lrec.bbx`](lrec.bbx) and [`lrec.dbx`](lrec.dbx) files (for the biblatex style) somewhere where LaTeX will find them (the easiest is probably to use the folder of your own `.tex` file, but your preferred `.texmf` should work, too)
  - Use `\documentclass{lrec}` and `\usepackage[backend=biber, style=lrec]{biblatex}`
  - See [`xample.tex`](xample.tex) for more details about what you can do

## Known limitations
The bibliography styles have not been extensively tested and might not work for all entry types, check yours before submission and submit bug reports if something is wrong.

## API
Listing only changes with respect to the official template.

### Changed
  - We chose to use a document class instead of a package, as we felt it made more sense, since we are actually changing things like the title apparence or the page geometry.
    In practice, it only means that instead of `\documentclass{article}\usepackage{lrec}` you have to use `\documentclass{lrec}`.
  - The title block should be typeset using `\maketitle`. The original `\maketitleabstract` is aliased to it.
  - The `\keywords` commands now actually sets keywords instead of just adding a new line and printing **keywords**. You should still be able to keep using it as in the original template, though<a href="#note1" id="noteref1">¹</a>.
  - The `\cite`, `\newcite` and `\shortcite` commands work as advertised, but using the more explicit `\parencite` and `\textcite` and avoiding `\shortcite` is recommended.

### Added
  - The `standalone` class option will try to give you a nicer look for standalone versions of your article (such as for putting on your homepage), most notably by adding headers and page numbers (see <a href="#standalone">below</a>)
    - The `\IfSubmission{code if submission}{code if standalone}` command gives you a way to change the content of your document depending on that option.
  - If hyperref is used in your document (and it should be), the `lrec` class will set pdf metadata using the content of `\title`, `\author`, `\keywords`…


## Other deviations
### Style
Priority has been given to the format of the official templates over the [author's kit stylesheet][authorkit2018], as per the big scary red warning at the top of the latter, except for

  - The maximum number of people per person list in the bibliography (four or more and you'll get an *et al.*.). The LaTeX template does not seem actually enforce it.
  - The dimensions are those mandated by the stylesheet and might slightly deviate from the official template's (see <a href="#dimensions">below</a>)

### Font
In the spirit of the previous statement, we chose to use [TeX Gyre Thermes](http://www.gust.org.pl/projects/e-foundry/tex-gyre/termes) for the main font. The rationale is that

  - It should be available in all major TeX distributions
  - It supersedes [URW++ Nimbus Roman No9 L](https://www.urwpp.de/shop/?fontshop=datei:show_font_details;fontnummer:n021003l), the “Times” font used by default in LaTeX and the font used by the official template.
  - It has a good Unicode coverage and looks nice.

If you *really* want to use a commercial Times Roman or Times New Roman font, a judicious use of `fontspec`'s `\setmainfont` will do the trick, but it my experience it looked worse this way.

Fun fact : the only place where Times New Roman is explicitely mandated by the stylesheet is for heading level 2 and 3, whereas the official (LaTeX) template uses it for everything, but actually sets the font with

```latex
\renewcommand{\sfdefault}{phv}
\renewcommand{\rmdefault}{ptm}
\renewcommand{\ttdefault}{pcr}
```

and thus actually uses URW++ Nimbus Roman No9 L.

### <a id="dimensions">Dimensions</a>

The official template sets its dimensions in weird ways that I don't want to reverse-engineer, so I used those mandated by the stylesheet.
Oddly, that leaves 0.7mm not accounted for, but instead of using them in [pretty ways](https://twitter.com/EvpokPadding/status/911674913412599808), I give them to you as extra text space.

You are welcome.

### Misc

  - We decided against printing “LREC Proceedings style” in the LaTeX log output.

## <a id="standalone">Standalone mode</a>
Declaring the document class as `\documentclass[standalone]{lrec}` will give you the fabled standalone mode, which features

  - Page numbers
  - Headers
  - Additional PDF bookmarks

This is intended to be a style for standalone publications — such as on your homepage or for third-party archives — that stays close to LREC's to avoid confusing your readers, but take advantages of the fact that on those media, you are not constrained by the official style requirements.

---

<a id="note1" href="#noteref1">1.</a> Please don't.

[authorkit2018]: http://lrec2018.lrec-conf.org/en/submission/authors-kit/
