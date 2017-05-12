sig mon2eff.

accum_sig syntax.

type    mon2eff/nat         mon/nat -> eff/nat -> o.
type    mon2eff/label       mon/label -> eff/label -> o.
type    mon2eff/value       mon/value -> eff/value -> o.
type    mon2eff/comp        mon/comp -> eff/comp -> o.
type    mon2eff/evctx       mon/evctx -> eff/evctx -> o.
type    mon2eff/cases       mon/cases -> eff/cases -> o.

type    eff/is-evctx        eff/evctx -> o.
