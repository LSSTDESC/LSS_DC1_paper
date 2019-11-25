# DC1 paper

This is a paper to sum up the lessons and work done for the DESC DC1.

## Building this Paper

You can compile latex papers locally with
```
make  [mnras]
```
`make` with no arguments compiles the latex using the `default_format` stored in `.metadata.json`. Choosing `tex` causes the paper to be made using the `texmf/styles/lsstdescnote.cls` class, with commands defined in `texmf/styles/lsstdesc_macros.sty`. Don't edit these style files, as you may want to replace them with newer versions as they become available. Instead, use the `macros.tex` file to add your own `newcommand`'s and `def`'s.

At present, the Makefile is only used to compile latex. In future, we hope to enable compilation of jupyter notebooks, `Markdown` and `reStructuredText` format notes into PDF as well.

## Internal review

The LSST-DESC internal review page is located [here](https://confluence.slac.stanford.edu/pages/viewpage.action?pageId=263758426)

## Comments/questions?

Please send an email to jsanch87@fnal.gov or open an issue if you have any comments, questions or suggestions.


