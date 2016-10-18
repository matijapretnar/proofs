sig syntax.

%%% CBPV %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind    cbpv/value, cbpv/comp, cbpv/evctx type.

type    cbpv/unit           cbpv/value.
type    cbpv/pair           cbpv/value -> cbpv/value -> cbpv/value.
type    cbpv/inl            cbpv/value -> cbpv/value.
type    cbpv/inr            cbpv/value -> cbpv/value.
type    cbpv/thunk          cbpv/comp -> cbpv/value.

type    cbpv/ret            cbpv/value -> cbpv/comp.
type    cbpv/fun            (cbpv/value -> cbpv/comp) -> cbpv/comp.
type    cbpv/split          cbpv/value -> (cbpv/value -> cbpv/value -> cbpv/comp) -> cbpv/comp.
type    cbpv/case           cbpv/value -> (cbpv/value -> cbpv/comp) -> (cbpv/value -> cbpv/comp) -> cbpv/comp.
type    cbpv/force          cbpv/value -> cbpv/comp.
type    cbpv/bind           cbpv/comp -> (cbpv/value -> cbpv/comp) -> cbpv/comp.
type    cbpv/app            cbpv/comp -> cbpv/value -> cbpv/comp.

type    cbpv/hole           cbpv/evctx.
type    cbpv/evctx/bind     cbpv/evctx -> (cbpv/value -> cbpv/comp) -> cbpv/evctx.
type    cbpv/evctx/app      cbpv/evctx -> cbpv/value -> cbpv/evctx.

type    cbpv/plug           cbpv/evctx -> cbpv/comp -> cbpv/comp -> o.
type    cbpv/hoisting       cbpv/evctx -> o.
type    cbpv/reduce         cbpv/comp -> cbpv/comp -> o.
type    cbpv/step           cbpv/comp -> cbpv/comp -> o.

%%% DEL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind    del/value, del/comp, del/evctx type.

type    del/unit            del/value.
type    del/pair            del/value -> del/value -> del/value.
type    del/inl             del/value -> del/value.
type    del/inr             del/value -> del/value.
type    del/thunk           del/comp -> del/value.

type    del/ret             del/value -> del/comp.
type    del/fun             (del/value -> del/comp) -> del/comp.
type    del/split           del/value -> (del/value -> del/value -> del/comp) -> del/comp.
type    del/case            del/value -> (del/value -> del/comp) -> (del/value -> del/comp) -> del/comp.
type    del/force           del/value -> del/comp.
type    del/bind            del/comp -> (del/value -> del/comp) -> del/comp.
type    del/app             del/comp -> del/value -> del/comp.
type    del/reset           del/comp -> (del/value -> del/comp) -> del/comp.
type    del/shift           (del/value -> del/comp) -> del/comp.

type    del/hole            del/evctx.
type    del/evctx/bind      del/evctx -> (del/value -> del/comp) -> del/evctx.
type    del/evctx/app       del/evctx -> del/value -> del/evctx.
type    del/evctx/reset     del/evctx -> (del/value -> del/comp) -> del/evctx.

type    del/plug           del/evctx -> del/comp -> del/comp -> o.
type    del/hoisting       del/evctx -> o.
type    del/reduce         del/comp -> del/comp -> o.
type    del/step           del/comp -> del/comp -> o.

%%% MON %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind    mon/monad, mon/value, mon/comp, mon/evctx type.

type    mon/mon             (mon/value -> mon/comp) -> (mon/value -> mon/value -> mon/comp) -> mon/monad.

type    mon/unit            mon/value.
type    mon/pair            mon/value -> mon/value -> mon/value.
type    mon/inl             mon/value -> mon/value.
type    mon/inr             mon/value -> mon/value.
type    mon/thunk           mon/comp -> mon/value.

type    mon/ret             mon/value -> mon/comp.
type    mon/fun             (mon/value -> mon/comp) -> mon/comp.
type    mon/split           mon/value -> (mon/value -> mon/value -> mon/comp) -> mon/comp.
type    mon/case            mon/value -> (mon/value -> mon/comp) -> (mon/value -> mon/comp) -> mon/comp.
type    mon/force           mon/value -> mon/comp.
type    mon/bind            mon/comp -> (mon/value -> mon/comp) -> mon/comp.
type    mon/app             mon/comp -> mon/value -> mon/comp.
type    mon/reflect         mon/comp -> mon/comp.
type    mon/reify           mon/comp -> mon/monad -> mon/comp.

type    mon/hole            mon/evctx.
type    mon/evctx/bind      mon/evctx -> (mon/value -> mon/comp) -> mon/evctx.
type    mon/evctx/app       mon/evctx -> mon/value -> mon/evctx.
type    mon/evctx/reify     mon/evctx -> mon/monad -> mon/evctx.

type    mon/plug            mon/evctx -> mon/comp -> mon/comp -> o.
type    mon/hoisting        mon/evctx -> o.
type    mon/reduce          mon/comp -> mon/comp -> o.
type    mon/step            mon/comp -> mon/comp -> o.
