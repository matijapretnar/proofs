Formalization of Eff in Twelf
=============================

This is a formalization of the basic properties of core Eff,
a small fragment of the [Eff](http://www.eff-lang.org/) programming language.
Core Eff contains all the essential ingredients of Eff,
except dynamic instance generation.

For an explanation of the basic concepts of core Eff, please refer to:
[An Effect System for Algebraic Effects and Handlers](http://arxiv.org/abs/1306.6316)
as the comments in the code serve only to highlight implementation details.

The formalization is written in [Twelf](http://www.twelf.org/).
To run it, just do the usual thing you do in Twelf.

## The structure of the files

* `sources.cfg`: Twelf configuration file determining the order of files

### Core language
* `names.elf`: an auxiliary type of comparable names
* `effects.elf`: definitions involving effects, operations, regions and dirt
* `effects-lemmas.elf`: various lemmas about the above definitions
* `syntax.elf`: abstract syntax

### Static semantics
* `signature.elf`: definitions of signatures (ones assigning types to operation symbols)
* `subtyping.elf`: definition of the subtyping relation
* `subtyping-lemmas.elf`: reflexivity and transitivity of subtyping
* `typing.elf`: definition of typing judgements
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
