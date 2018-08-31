module mon2del.
accumulate auto-mon2del.

mon2del/comp (mon/reify M (mon/mon Nu Nb)) (del/app (del/reset M' (x\ del/fun nb\ Nu' x)) (del/thunk (del/fun x\ del/fun k\ Nb' x k))) :-
    mon2del/comp M M',
    pi x\ pi x'\
        mon2del/value x x' =>
        mon2del/comp (Nu x) (Nu' x'),
    pi x\ pi k\ pi x'\ pi k'\
        mon2del/value x x' =>
        mon2del/value k k' =>
        mon2del/comp (Nb x k) (Nb' x' k').
mon2del/comp (mon/reflect M)
    (del/shift k\ (del/fun nb\ (del/app (del/app (del/force nb) (del/thunk M')) (del/thunk (del/fun y\ del/app (del/app (del/force k) y) nb))))) :-
    mon2del/comp M M'.

mon2del/evctx (mon/evctx/reify E (mon/mon Nu Nb)) (del/evctx/app (del/evctx/reset E' (x\ del/fun nb\ Nu' x)) (del/thunk (del/fun x\ del/fun k\ Nb' x k))) :-
    mon2del/evctx E E',
    pi x\ pi x'\
        mon2del/value x x' =>
        mon2del/comp (Nu x) (Nu' x'),
    pi x\ pi k\ pi x'\ pi k'\
        mon2del/value x x' =>
        mon2del/value k k' =>
        mon2del/comp (Nb x k) (Nb' x' k').

