sig eff2del.

accum_sig syntax.

type    eff2del/nat         eff/nat -> del/nat -> o.
type    eff2del/label       eff/label -> del/label -> o.
type    eff2del/value       eff/value -> del/value -> o.
type    eff2del/comp        eff/comp -> del/comp -> o.
type    eff2del/evctx       eff/evctx -> del/evctx -> o.
type    eff2del/cases       eff/cases -> del/cases -> o.
type    eff2del/handler     eff/handler -> (del/value -> del/comp) -> del/cases -> o.

type    del/is-evctx        del/evctx -> o.
