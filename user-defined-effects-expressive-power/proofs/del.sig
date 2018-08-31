sig del.
accum_sig auto-del.

type    del/cons            del/eff -> del/compty -> del/eff.

type    del/reset           del/comp -> (del/value -> del/comp) -> del/comp.
type    del/shift           (del/value -> del/comp) -> del/comp.

type    del/evctx/reset     del/evctx -> (del/value -> del/comp) -> del/evctx.
