Accompannying material for _No value restriction is needed for algebraic effects and handlers_
==============================================================================================
[Ohad Kammar](http://www.cs.ox.ac.uk/people/ohad.kammar) and [Matija Pretnar](http://matija.pretnar.info/)

[This code (value-restriction.tar.gz)](value-restriction.tar.gz)
formalises the basic meta-theoretic properties of the different
variations of the calculus presented in the aforementioned
article.

The code is based
on
[Matija Pretnar and Andrej Bauer's formalisation](https://github.com/matijapretnar/twelf-eff/) of
the core of the [Eff](http://www.eff-lang.org/) programming language.
For an explanation of the basic concepts of core Eff, please refer to
the aforementioned article, and to the
article
[An Effect System for Algebraic Effects and Handlers](http://arxiv.org/abs/1306.6316) as
the comments in the code serve only to highlight implementation
details.

## Running the code

The formalization is written in [Twelf](http://www.twelf.org/). To install it,
please see the [official instructions](http://www.twelf.org/wiki/Download).

The simplest way to run the code is to open any `.elf` file in Emacs,
and load the configuration by entering `Ctrl-C Ctrl-C` and confirming
the default locations (unless you moved them to a different location).

Alternatively, you can run `twelf-server` in the main directory, and type `make`.

## The formalisations

* `local-sig`: the calculus in the article, with fully annotated local
               signatures
* `shallow`: a variation on the local-sig calculus, where handlers are shallow
* `global-sig`: a coarsely-annotated variation of the calculus, with a single,
               global, effect signature
* `jumbo`: the coarsely-annotated calculus extended with fixed-points,
           structural subtyping, and static effect instances

## The structure of each formalisation

Each sub-directory has approximately the same structure:

* `sources.cfg`: Twelf configuration file determining the order of files

### Core language
* `effects.elf`: definitions involving operations, regions and dirt
* `effects-lemmas.elf`: various lemmas about the above definitions
* `syntax.elf`: abstract syntax

Since types and dirts are mutually defined in `local-sig`, the files
`effects.elf` and `syntax.elf` are merged, and `effects-lemmas.elf` is
named `syntax-lemmas.elf`.

### Static semantics
* `typing.elf`: definition of typing judgments
* `typing-lemmas.elf`: various typing lemmas, mainly substitution lemma

The formalisation `jumbo` also contains files `subtyping.elf` and
`subtyping-lemmas.elf` that contain appropriate definitions and lemmas for
subtyping.

### Dynamic semantics
* `operational.elf`: definition of small step and big step operational semantics

### Safety theorems
* `progress-lemmas.elf`: lemmas used in `progress.elf`
* `progress.elf`: the progress theorem
* `preservation-lemmas.elf`: lemmas used in `preservation.elf`
* `preservation.elf`: the preservation theorem
