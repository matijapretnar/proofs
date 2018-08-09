sig mon.
accum_sig auto-mon.

type    mon/cons            mon/eff -> (mon/valty -> mon/compty) -> (mon/value -> mon/comp) -> (mon/value -> mon/value -> mon/comp) -> mon/eff.

kind    mon/monad           type.
type    mon/mon             (mon/value -> mon/comp) -> (mon/value -> mon/value -> mon/comp) -> mon/monad.

type    mon/reflect         mon/comp -> mon/comp.
type    mon/reify           mon/comp -> mon/monad -> mon/comp.

type    mon/of/monad        mon/monad -> mon/eff -> o.

type    mon/evctx/reify     mon/evctx -> mon/monad -> mon/evctx.
