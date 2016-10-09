sig mon.

accum_sig cbpv.

type    cons            eff -> (valty -> compty) -> (value -> comp) -> (value -> value -> comp) -> eff.

kind    monad           type.
type    mon             (value -> comp) -> (value -> value -> comp) -> monad.

type    reflect         comp -> comp.
type    reify           comp -> monad -> comp.

type    of/monad        monad -> eff -> o.

type    evctx/reify     evctx -> monad -> evctx.

type    reifyfree       evctx -> o.
