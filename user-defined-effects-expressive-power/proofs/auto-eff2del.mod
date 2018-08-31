module auto-eff2del.
accumulate eff.
accumulate del.

eff2del/value eff/unit del/unit.
eff2del/value (eff/pair V1 V2) (del/pair V1' V2') :-
    eff2del/value V1 V1',
    eff2del/value V2 V2'.
eff2del/value (eff/inj L V) (del/inj L V') :-
    eff2del/value V V'.
eff2del/value (eff/thunk M) (del/thunk M') :-
    eff2del/comp M M'.

eff2del/comp (eff/ret V) (del/ret V') :-
    eff2del/value V V'.
eff2del/comp (eff/fun M) (del/fun M') :-
    pi x\ pi x'\
        eff2del/value x x' =>
        eff2del/comp (M x) (M' x').
eff2del/comp (eff/split V M) (del/split V' M') :-
    eff2del/value V V',
    pi x1\ pi x2\ pi x1'\ pi x2'\
        eff2del/value x1 x1' =>
        eff2del/value x2 x2' =>
        eff2del/comp (M x1 x2) (M' x1' x2').
eff2del/comp (eff/case V Ms) (del/case V' Ms') :-
    eff2del/value V V',
    eff2del/cases Ms Ms'.
eff2del/comp (eff/force V) (del/force V') :-
    eff2del/value V V'.
eff2del/comp (eff/bind M N) (del/bind M' N') :-
    eff2del/comp M M',
    pi x\ pi x'\
        eff2del/value x x' =>
        eff2del/comp (N x) (N' x').
eff2del/comp (eff/app M V) (del/app M' V') :-
    eff2del/comp M M',
    eff2del/value V V'.
eff2del/comp (eff/comppair M1 M2) (del/comppair M1' M2') :-
    eff2del/comp M1 M1',
    eff2del/comp M2 M2'.
eff2del/comp (eff/prj1 M) (del/prj1 M') :-
    eff2del/comp M M'.
eff2del/comp (eff/prj2 M) (del/prj2 M') :-
    eff2del/comp M M'.

eff2del/cases eff/cases/nil del/cases/nil.
eff2del/cases (eff/cases/cons Ms L M) (del/cases/cons Ms' L M') :-
    eff2del/cases Ms Ms',
    pi x\ pi x'\
        eff2del/value x x' =>
        eff2del/comp (M x) (M' x').

eff2del/evctx eff/hole del/hole.
eff2del/evctx (eff/evctx/bind E N) (del/evctx/bind E' N') :-
    eff2del/evctx E E',
    pi x\ pi x'\
        eff2del/value x x' =>
        eff2del/comp (N x) (N' x').
eff2del/evctx (eff/evctx/app E V) (del/evctx/app E' V') :-
    eff2del/evctx E E',
    eff2del/value V V'.
eff2del/evctx (eff/evctx/prj1 E) (del/evctx/prj1 E') :-
    eff2del/evctx E E'.
eff2del/evctx (eff/evctx/prj2 E) (del/evctx/prj2 E') :-
    eff2del/evctx E E'.
