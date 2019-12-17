# Explicit Effect Subtyping

Abella formalisation of proofs that appear in the paper
> Georgios Karachalias, Matija Pretnar, Amr Hany Saleh, Tom Schrijvers:
> *Explicit Effect Subtyping*,
> submitted to JFP


## Evaluating proofs

Proofs in the paper correspond to the following Abella proofs:

* Theorem 4.1:
    `exp/progress_val` and `exp/progress_comp` in `proof-exp-progress.thm`;
    `exp/val_preservation` and `exp/comp_preservation` in `proof-exp-preservation.thm`
* Theorem 5.1: `i2e/of` in `proof-imp2exp-preserves-typing.thm`
* Theorem 6.1: `e2s/of` in `proof-exp2skel-preserves-typing.thm`
* Theorem 6.2: `e2s/val_preservation` and `e2s/comp_preservation` in `proof-exp2skel-preserves-semantics.thm`
* Theorem 7.1: `ml/preservation` in `proof-ml-preservation.thm`
* Theorem 7.2: `ml/progress` in `proof-ml-progress.thm`
* Theorem 7.3: `e2m/of` in `proof-exp2ml-preserves-typing.thm`

To evaluate all the proofs, run:

    abella proofs.thm

using Abella 2.0.4 or higher, The command sequentially loads all of the above files and,
if all proofs are correct, terminates without an error.
