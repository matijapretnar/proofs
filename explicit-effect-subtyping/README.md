# Explicit Effect Subtyping

Abella formalisation of proofs that appear in the paper
> Amr Hany Saleh, Georgios Karachalias, Matija Pretnar, Tom Schrijvers:
> *Explicit Effect Subtyping*,
> submitted to ESOP 2018


## Evaluating proofs

Proofs in the paper correspond to the following Abella proofs:

* Theorem 1 (Type Safety):
    `val/progress_comp` in `target_progress.thm` and
    `val/comp_preservation` in `target_preservation.thm`
* Theorem 2 (Type Preservation of Elaboration): `elb_of` in `elaboration_preserves_typing.thm`
* Theorem 6 (Type Preservation of Erasure): `ers_of` in `erasure_preserves_typing.thm`
* Theorem 7 (Semantic Preservation): `val/comp_preservation` in `erasure_preserves_semantics.thm`

To evaluate all the proofs, run:

    abella all.thm

If all the proofs are correct, the command ends with outputting

    Proof completed.
    Abella < 
    </pre> [sic]
