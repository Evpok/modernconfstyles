Modern conference styles
========================

It is no secret (but no shame either!) that many LaTeX templates offered by conference organisators carry a lot of cruft and thus often outdated, and often incompatible with modern LaTeX technologies, including — but not limited to —

  - [Lua(La)TeX](http://lualatex.org) and [Xe(La)TeX](http://xetex.sourceforge.net/)
  - [fontspec](https://github.com/wspr/fontspec) and [unicode-math](https://github.com/wspr/unicode-math)
  - [BibLaTeX](https://github.com/plk/biblatex/)/[Biber](http://biblatex-biber.sourceforge.net/)

This repository offers alternatives to official templates that are compatible with these and much more !

## Limitations
It is a sad fact that modernization sometimes has to get rid of good old things in order to get good new things, and this makes no exception.
In particular, unless stated otherwise, no effort is made to preserve compatibility with legacy engines and the templates in this repository **require** the use of either LuaLaTeX of XeLaTeX for the compilation of documents and BibLaTeX/Biber for the compilation of bibliographies.

Also, let us say it in capitals and pseudo-legalese, which apparently makes it official in some weird jurisdictions

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

Which means that nobody is guaranteeing that those templates actually comply to conferences guidelines and stylesheets and that you won't get laughed at by the second reviewer (who we all know is the worst).

That said,

  - We make our best efforts to stay as close as possible from the official templates and guidelines (including by painstakingly measuring resulting PDF files)
  - It is not *that* a big deal, since
    - Some official conference templates don't comply with their own official stylesheet either
    - Some official stylesheets are known to be inconsistent

So don't worry too much.

## Licence
This body of work is released under your choice<a href="#note1" id="noteref1">¹</a> of the [Creative Commons CC0 1.0 Universal  Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/), the [WTFPL 2 license](http://wtfpl.net) or the MIT License, whose full texts are available in the `LICENSE.XXX.md` files.

I do try to stay as close as possible to the original templates, so this might or might not be an issue of copyright infrigement, depending on the copyright policy and moral stance you take.
However, this is done in good faith, in the spirit of sharing tools to make life easier for authors, and in no way to harm the original template providers, nor to imply any criticism of their considerable work.

The bottom line is: if you are a copyright holder and want to claim rights on anything provided here, please contact me before unleashing your k̶r̶a̶k̶e̶n̶s̶ lawyers.

---

<a id="note1" href="#noteref1">1.</a> Depending on your country, your personal tastes and your stance on profanity.
