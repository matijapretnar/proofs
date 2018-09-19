# On the Expressive Power of User-Defined Effects

Abella formalisation of proofs that appear in the paper

> Yannick Forster, Ohad Kammar, Sam Lindley, Matija Pretnar:
> *On the expressive power of user-defined effects:*
> *effect handlers, monadic reflection, delimited control*,
> Submitted to JFP

For proofs that appear in the ICFP 2017 version, check out the tag `icfp-2017`.

## Evaluating proofs

Proofs in the paper correspond to the following Abella proofs:

* Theorem 1 (MAM safety): `mam/safety` in `proof-mam-safety.thm`
* Theorem 6 (EFF safety): `eff/safety` in `proof-eff-safety.thm`
* Theorem 11 (MON safety): `mon/safety` in `proof-mon-safety.thm`
* Theorem 17 (DEL safety): `del/safety` in `proof-del-safety.thm`
* Theorem 19 (DEL → MON correctness):  `del2mon/correctness` in `proof-del2mon.thm`
* Theorem 20 (DEL → MON preserves typeability):  `preservation` in `proof-del2mon-typed.thm`
* Theorem 22 (MON → DEL correctness):  `mon2del/correctness` in `proof-mon2del.thm`
* Theorem 23 (DEL → EFF correctness):  `del2eff/correctness` in `proof-del2eff.thm`
* Theorem 24 (EFF → DEL correctness):  `eff2del/correctness` in `proof-eff2del.thm`
* Theorem 25 (MON → EFF correctness):  `mon2eff/correctness` in `proof-mon2eff.thm`
* Theorem 26 (EFF → MON correctness):  `eff2mon/correctness` in `proof-eff2mon.thm`

To evaluate all the proofs, run:

    abella proofs.thm

The command sequentially loads all of the above files and, if all proofs are correct,
terminates without an error. In addition, the formalisation contains two proofs
not found in the paper:

* Correctness for the alternative MON → DEL translation described in 6.2.1:  `mon2del/correctness` in `proof-mon2del-alt.thm`
* Correctness for the alternative EFF → DEL translation described in 6.4.1:  `eff2del/correctness` in `proof-eff2del-alt.thm`

To evaluate these two proofs, run:

    abella proofs-alt.thm
