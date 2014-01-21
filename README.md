Formalization of Eff in Twelf
=============================

This is a formalization of the basic properties of core Eff,
a small fragment of the [Eff](http://www.eff-lang.org/) programming language.
Core Eff contains all the essential ingredients of Eff,
except dynamic instance generation.

For an explanation of the basic concepts of core Eff, please refer to:
[An Effect System for Algebraic Effects and Handlers](http://arxiv.org/abs/1306.6316)
as the comments in the code serve only to highlight implementation details.

## Running the code

The formalization is written in [Twelf](http://www.twelf.org/). To install it,
please see the [official instructions](http://www.twelf.org/wiki/Download).

The simplest way to run the code is to open any `.elf` file in Emacs,
and load the configuration by entering `Ctrl-C Ctrl-C` and confirming
the default locations (unless you moved them to a different location).

Alternatively, you can run `twelf-server` in the main directory, and type `make`.

## The structure of the files

* `sources.cfg`: Twelf configuration file determining the order of files

### Core language
* `names.elf`: an auxiliary type of comparable names
* `effects.elf`: definitions involving effects, operations, regions and dirt
* `effects-lemmas.elf`: various lemmas about the above definitions
* `syntax.elf`: abstract syntax

### Static semantics
* `signature.elf`: definitions of effect signatures and signatures
* `subtyping.elf`: definition of the subtyping relation
* `subtyping-lemmas.elf`: reflexivity and transitivity of subtyping
* `typing.elf`: definition of typing judgments
* `typing-lemmas.elf`: various typing lemmas, mainly substitution lemma

### Dynamic semantics
* `operational.elf`: definition of small step and big step operational semantics
* `small-big-lemmas.elf`: lemmas used in `small-big.elf`
* `small-big.elf`: equivalence between small and big step semantics

### Safety theorems
* `progress-lemmas.elf`: lemmas used in `progress.elf`
* `progress.elf`: the progress theorem
* `preservation-lemmas.elf`: lemmas used in `preservation.elf`
* `preservation.elf`: the preservation theorem
