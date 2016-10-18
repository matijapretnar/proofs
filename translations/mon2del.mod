module mon2del.

accumulate syntax.

mon2del/value mon/unit del/unit.
mon2del/value (mon/pair V1 V2) (del/pair V1' V2') :-
    mon2del/value V1 V1',
    mon2del/value V2 V2'.
mon2del/value (mon/inl V) (del/inl V') :-
    mon2del/value V V'.
mon2del/value (mon/inr V) (del/inr V') :-
    mon2del/value V V'.
mon2del/value (mon/thunk M) (del/thunk M') :-
    mon2del/comp M M'.

mon2del/comp (mon/ret V) (del/ret V') :-
    mon2del/value V V'.
mon2del/comp (mon/fun M) (del/fun M') :-
    pi x\ pi x'\
        mon2del/value x x' =>
        mon2del/comp (M x) (M' x').
mon2del/comp (mon/split V M) (del/split V' M') :-
    mon2del/value V V',
    pi x1\ pi x2\ pi x1'\ pi x2'\
        mon2del/value x1 x1' =>
        mon2del/value x2 x2' =>
        mon2del/comp (M x1 x2) (M' x1' x2').
mon2del/comp (mon/case V M1 M2) (del/case V' M1' M2') :-
    mon2del/value V V',
    pi x\ pi x'\
        mon2del/value x x' =>
        mon2del/comp (M1 x) (M1' x'),
    pi x\ pi x'\
        mon2del/value x x' =>
        mon2del/comp (M2 x) (M2' x').
mon2del/comp (mon/force V) (del/force V') :-
    mon2del/value V V'.
mon2del/comp (mon/bind M N) (del/bind M' N') :-
    mon2del/comp M M',
    pi x\ pi x'\
        mon2del/value x x' =>
        mon2del/comp (N x) (N' x').
mon2del/comp (mon/app M V) (del/app M' V') :-
    mon2del/comp M M',
    mon2del/value V V'.
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

mon2del/evctx mon/hole del/hole.
mon2del/evctx (mon/evctx/bind E N) (del/evctx/bind E' N') :-
    mon2del/evctx E E',
    pi x\ pi x'\
        mon2del/value x x' =>
        mon2del/comp (N x) (N' x').
mon2del/evctx (mon/evctx/app E V) (del/evctx/app E' V') :-
    mon2del/evctx E E',
    mon2del/value V V'.
mon2del/evctx (mon/evctx/reify E (mon/mon Nu Nb)) (del/evctx/app (del/evctx/reset E' (x\ del/fun nb\ Nu' x)) (del/thunk (del/fun x\ del/fun k\ Nb' x k))) :-
    mon2del/evctx E E',
    pi x\ pi x'\
        mon2del/value x x' =>
        mon2del/comp (Nu x) (Nu' x'),
    pi x\ pi k\ pi x'\ pi k'\
        mon2del/value x x' =>
        mon2del/value k k' =>
        mon2del/comp (Nb x k) (Nb' x' k').

del/is-evctx del/hole.
del/is-evctx (del/evctx/bind E N) :- del/is-evctx E.
del/is-evctx (del/evctx/app E V) :- del/is-evctx E.
del/is-evctx (del/evctx/reset E T) :- del/is-evctx E.
