sig eff2mon.

accum_sig syntax.

type    eff2mon/nat         eff/nat -> mon/nat -> o.
type    eff2mon/label       eff/label -> mon/label -> o.
type    eff2mon/value       eff/value -> mon/value -> o.
type    eff2mon/comp        eff/comp -> mon/comp -> o.
type    eff2mon/evctx       eff/evctx -> mon/evctx -> o.
type    eff2mon/cases       eff/cases -> mon/cases -> o.
type    eff2mon/handler     eff/handler -> (mon/value -> mon/comp) -> mon/cases -> o.

type    mon/is-evctx        mon/evctx -> o.
