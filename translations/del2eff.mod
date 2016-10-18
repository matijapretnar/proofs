module del2eff.

accumulate syntax.

del2eff/value del/unit eff/unit.
del2eff/value (del/pair V1 V2) (eff/pair V1' V2') :-
    del2eff/value V1 V1',
    del2eff/value V2 V2'.
del2eff/value (del/inl V) (eff/inl V') :-
    del2eff/value V V'.
del2eff/value (del/inr V) (eff/inr V') :-
    del2eff/value V V'.
del2eff/value (del/thunk M) (eff/thunk M') :-
    del2eff/comp M M'.

del2eff/comp (del/ret V) (eff/ret V') :-
    del2eff/value V V'.
del2eff/comp (del/fun M) (eff/fun M') :-
    pi x\ pi x'\
        del2eff/value x x' =>
        del2eff/comp (M x) (M' x').
del2eff/comp (del/split V M) (eff/split V' M') :-
    del2eff/value V V',
    pi x1\ pi x2\ pi x1'\ pi x2'\
        del2eff/value x1 x1' =>
        del2eff/value x2 x2' =>
        del2eff/comp (M x1 x2) (M' x1' x2').
del2eff/comp (del/case V M1 M2) (eff/case V' M1' M2') :-
    del2eff/value V V',
    pi x\ pi x'\
        del2eff/value x x' =>
        del2eff/comp (M1 x) (M1' x'),
    pi x\ pi x'\
        del2eff/value x x' =>
        del2eff/comp (M2 x) (M2' x').
del2eff/comp (del/force V) (eff/force V') :-
    del2eff/value V V'.
del2eff/comp (del/bind M N) (eff/bind M' N') :-
    del2eff/comp M M',
    pi x\ pi x'\
        del2eff/value x x' =>
        del2eff/comp (N x) (N' x').
del2eff/comp (del/app M V) (eff/app M' V') :-
    del2eff/comp M M',
    del2eff/value V V'.
del2eff/comp (del/reset M N) (eff/handle M' (
        eff/opcase (eff/valcase N') eff/op/z (f\ k\ eff/app (eff/force f) k)
    )) :-
    del2eff/comp M M',
    pi x\ pi x'\
        del2eff/value x x' =>
        del2eff/comp (N x) (N' x').
del2eff/comp (del/shift M) (eff/call eff/op/z (eff/thunk (eff/fun M'))) :-
    pi k\ pi k'\
        del2eff/value k k' =>
        del2eff/comp (M k) (M' k').

del2eff/evctx del/hole eff/hole.
del2eff/evctx (del/evctx/bind E N) (eff/evctx/bind E' N') :-
    del2eff/evctx E E',
    pi x\ pi x'\
        del2eff/value x x' =>
        del2eff/comp (N x) (N' x').
del2eff/evctx (del/evctx/app E V) (eff/evctx/app E' V') :-
    del2eff/evctx E E',
    del2eff/value V V'.
del2eff/evctx (del/evctx/reset E N) (eff/evctx/handle E' (
        eff/opcase (eff/valcase N') eff/op/z (f\ k\ eff/app (eff/force f) k)
    )) :-
    del2eff/evctx E E',
    pi x\ pi x'\
        del2eff/value x x' =>
        del2eff/comp (N x) (N' x').

eff/is-evctx eff/hole.
eff/is-evctx (eff/evctx/bind E N) :- eff/is-evctx E.
eff/is-evctx (eff/evctx/app E V) :- eff/is-evctx E.
eff/is-evctx (eff/evctx/handle E H) :- eff/is-evctx E.
