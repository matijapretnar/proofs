sig del.

accum_sig mam.

type    cons            eff -> compty -> eff.

type    reset           comp -> (value -> comp) -> comp.
type    shift           (value -> comp) -> comp.

type    evctx/reset     evctx -> (value -> comp) -> evctx.
