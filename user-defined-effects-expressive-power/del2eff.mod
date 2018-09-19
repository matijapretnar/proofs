module del2eff.
accumulate auto-del2eff.

del2eff/comp (del/reset M N) (eff/handle M' (
        eff/opcase (eff/valcase N') (eff/op z) (f\ k\ eff/app (eff/force f) k)
    )) :-
    del2eff/comp M M',
    pi x\ pi x'\
        del2eff/value x x' =>
        del2eff/comp (N x) (N' x').
del2eff/comp (del/shift M) (eff/call (eff/op z) (eff/thunk (eff/fun M'))) :-
    pi k\ pi k'\
        del2eff/value k k' =>
        del2eff/comp (M k) (M' k').

del2eff/evctx (del/evctx/reset E N) (eff/evctx/handle E' (
        eff/opcase (eff/valcase N') (eff/op z) (f\ k\ eff/app (eff/force f) k)
    )) :-
    del2eff/evctx E E',
    pi x\ pi x'\
        del2eff/value x x' =>
        del2eff/comp (N x) (N' x').
