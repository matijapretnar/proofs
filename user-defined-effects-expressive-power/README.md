# On the Expressive Power of User-Defined Effects

Abella formalisation of proofs that appear in the paper
> Yannick Forster, Ohad Kammar, Sam Lindley, Matija Pretnar:
> *On the Expressive Power of User-Defined Effects:*
> *Effect Handlers, Monadic Reflection, Delimited Control*,
> ICFP 2017

## Proofs

Proofs are contained in `.thm` files, which can be run by

    abella filename.thm

If the proof is correct, the command ends with outputting

    Proof completed.
    Abella < 
    </pre> 


### Safety of MAM and its extensions

The directory `safety` contains proofs of safety, i.e. progress and
preservation, for the language MAM defined in the paper and its extensions EFF,
MON and DEL. For each language XXX, we have four files:

* `xxx.sig`, which gives syntax of the language and the signature of relations
* `xxx.mod`, which defines typing and operational semantics
* `xxx-progress.thm`, which proves the progress theorem
* `xxx-preservation.thm`, which proves the preservation theorem

Note that `.sig` and `.mod` files for language extensions make use of Abella's
mechanism for accumulating signatures only specify constructs that need to be
added to MAM. A similar mechanism cannot exist for the `.thm` files because the
specification changes, so even though they are quite similar, these need to be
specified in full for each extension.


### Correctness of translations

The directory `translations` contains proofs of translations between the three
extensions of MAM. First, we have the files:

* `syntax.sig`, which gives the syntax of all the extensions and
* `syntax.mod`, which defines typing and operational semantics,

which are an amalgamation of the corresponding files in the `safety` directory.
Next, for any two extensions XXX and YYY, we have three files:

* `xxx2yyy.sig`, which gives signatures of the translation relations, one for each syntactic family,
* `xxx2yyy.mod`, which defines the translations and
* `xxx2yyy.thm`, which proves their correctness.

Even though the three language extensions we compare have most constructs in
common, we must specify each one individually. For example, even though both MON
and DEL share the same syntax, typing rules and operational semantics for
functions, these constructs must be represented differently, for the former can
contain monadic constructs, while the latter can contain effects and handlers.
Note that this was not a problem in the safety proofs, because each we always
studied just a single calculus at a time. The disambiguation between constructs
is implemented by putting a suitable prefix in front of each identifier.

As one can imagine, there is a lot of duplication in the final code. To define
each construct exactly once and to avoid manual typing of repetitive proofs, we
have written a Python 3 script `scaffolding/generate.py`, which takes the syntax
definitions in the `safety` directory and three templates for the translations,
and generates a `translations_scaffold/` folder that serves as a starting point
for the proofs of correctness.

By comparing the generated files in to their final counterparts, one can see
what needs to be changed for each particular translation. Files `syntax.sig` and
`syntax.mod` can be used without further modification, whereas the files
defining translations must be extended with translations of extension specific
constructs. Finally, significant work must be put into adapting the proofs in
the `.thm` files to the new cases.
