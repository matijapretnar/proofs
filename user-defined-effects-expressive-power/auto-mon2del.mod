module auto-mon2del.
accumulate mon.
accumulate del.

mon2del/value mon/unit del/unit.
mon2del/value (mon/pair V1 V2) (del/pair V1' V2') :-
    mon2del/value V1 V1',
    mon2del/value V2 V2'.
mon2del/value (mon/inj L V) (del/inj L V') :-
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
mon2del/comp (mon/case V Ms) (del/case V' Ms') :-
    mon2del/value V V',
    mon2del/cases Ms Ms'.
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
mon2del/comp (mon/comppair M1 M2) (del/comppair M1' M2') :-
    mon2del/comp M1 M1',
    mon2del/comp M2 M2'.
mon2del/comp (mon/prj1 M) (del/prj1 M') :-
    mon2del/comp M M'.
mon2del/comp (mon/prj2 M) (del/prj2 M') :-
    mon2del/comp M M'.

mon2del/cases mon/cases/nil del/cases/nil.
mon2del/cases (mon/cases/cons Ms L M) (del/cases/cons Ms' L M') :-
    mon2del/cases Ms Ms',
    pi x\ pi x'\
        mon2del/value x x' =>
        mon2del/comp (M x) (M' x').

mon2del/evctx mon/hole del/hole.
mon2del/evctx (mon/evctx/bind E N) (del/evctx/bind E' N') :-
    mon2del/evctx E E',
    pi x\ pi x'\
        mon2del/value x x' =>
        mon2del/comp (N x) (N' x').
mon2del/evctx (mon/evctx/app E V) (del/evctx/app E' V') :-
    mon2del/evctx E E',
    mon2del/value V V'.
mon2del/evctx (mon/evctx/prj1 E) (del/evctx/prj1 E') :-
    mon2del/evctx E E'.
mon2del/evctx (mon/evctx/prj2 E) (del/evctx/prj2 E') :-
    mon2del/evctx E E'.
