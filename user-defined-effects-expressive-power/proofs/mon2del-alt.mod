module mon2del-alt.
accumulate auto-mon2del.


mon2del/comp (mon/reify M (mon/mon Nu Nb))
    (del/reset
        (del/reset M' (x\ del/shift b\ Nu' x))
        (z\ del/split z (y\ f\ Nb' y f))) :-
    mon2del/comp M M',
    pi x\ pi x'\
        mon2del/value x x' =>
        mon2del/comp (Nu x) (Nu' x'),
    pi x\ pi k\ pi x'\ pi k'\
        mon2del/value x x' =>
        mon2del/value k k' =>
        mon2del/comp (Nb x k) (Nb' x' k').
mon2del/comp (mon/reflect M)
    (del/shift k\
        (del/shift b\
            (del/app
                (del/force b)
                (del/pair
                    (del/thunk M')
                    (del/thunk (
                        del/fun x\
                            del/reset
                                (del/app (del/force k) x)
                                (z\ del/split z (y\ f\ 
                                    (del/app
                                        (del/force b)
                                        (del/pair y f)
                                )))
                    ))
                )
            )
        )
    ) :-
    mon2del/comp M M'.

mon2del/evctx (mon/evctx/reify E (mon/mon Nu Nb))
    (del/evctx/reset
        (del/evctx/reset E' (x\ del/shift b\ Nu' x))
        (z\ del/split z (y\ f\ Nb' y f))) :-
    mon2del/evctx E E',
    pi x\ pi x'\
        mon2del/value x x' =>
        mon2del/comp (Nu x) (Nu' x'),
    pi x\ pi k\ pi x'\ pi k'\
        mon2del/value x x' =>
        mon2del/value k k' =>
        mon2del/comp (Nb x k) (Nb' x' k').
