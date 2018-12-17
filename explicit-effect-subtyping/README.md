# Explicit Effect Subtyping

Abella formalisation of proofs that appear in the paper
> Amr Hany Saleh, Georgios Karachalias, Matija Pretnar, Tom Schrijvers:
> *Explicit Effect Subtyping*,
> submitted to ESOP 2018


## Evaluating proofs

Proofs in the paper correspond to the following Abella proofs:

* Theorem 1 (Type Safety):
    `exp/progress_val` and `exp/progress_comp` in `proof-exp-progress.thm`;
    `exp/val_preservation` and `exp/comp_preservation` in `proof-exp-preservation.thm`
* Theorem 2 (Type Preservation of Elaboration): `i2e/of` in `proof-imp2exp-preserves-typing.thm`
* Theorem 6 (Type Preservation of Erasure): `e2s/of` in `proof-exp2skel-preserves-typing.thm`
* Theorem 7 (Semantic Preservation):
    `e2s/val_preservation` and `e2s/comp_preservation` in `proof-exp2skel-preserves-semantics.thm`

To evaluate all the proofs, run:

    abella proofs.thm

The command sequentially loads all of the above files and, if all proofs are correct,
terminates without an error.
