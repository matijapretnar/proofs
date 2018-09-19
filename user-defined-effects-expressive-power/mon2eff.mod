module mon2eff.
accumulate auto-mon2eff.

mon2eff/comp (mon/reify M (mon/mon Nu Nb)) (eff/handle M' (eff/opcase (eff/valcase Nu') (eff/op z) (Nb'))) :-
    mon2eff/comp M M',
    pi x\ pi x'\
        mon2eff/value x x' =>
        mon2eff/comp (Nu x) (Nu' x'),
    pi x\ pi x'\ pi k\ pi k'\
        mon2eff/value x x' =>
        mon2eff/value k k' =>
        mon2eff/comp (Nb x k) (Nb' x' k').
mon2eff/comp (mon/reflect M) (eff/call (eff/op z) (eff/thunk M')) :-
    mon2eff/comp M M'.

mon2eff/evctx (mon/evctx/reify E (mon/mon Nu Nb)) (eff/evctx/handle E' (
        eff/opcase (eff/valcase Nu') (eff/op z) (Nb')
    )) :-
    mon2eff/evctx E E',
    pi x\ pi x'\
        mon2eff/value x x' =>
        mon2eff/comp (Nu x) (Nu' x'),
    pi x\ pi x'\ pi k\ pi k'\
        mon2eff/value x x' =>
        mon2eff/value k k' =>
        mon2eff/comp (Nb x k) (Nb' x' k').
