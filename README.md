Formalization of Eff in Twelf
=============================

This is a formalization of the basic properties of core Eff, which is
a small fragment of the [Eff](http://math.andrej.com/eff/) programming
language. Core Eff contains all the essential ingridients of Eff,
except dynamic instance generation.

The formalization is written in [Twelf](http://www.twelf.org/). To run it,
just do the usual thing you do in Twelf.

The structure of the files is as follows:

* `sig.elf`: definitions involving effect types, regions, and dirt
* `core.elf`: abstract syntax, static and dynamic semantics
* `subtyping.elf`: properties of the subtyping relation
* `preservation.elf`: proof of the preservation theorem
* `progress.elf`: proof of the progress theorem
