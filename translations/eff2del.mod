module eff2del.

accumulate syntax.

eff2del/nat eff/z del/z.
eff2del/nat (eff/s N) (del/s N') :-
    eff2del/nat N N'.

eff2del/label (eff/lbl N) (del/lbl N') :-
    eff2del/nat N N'.

eff2del/value eff/unit del/unit.
eff2del/value (eff/pair V1 V2) (del/pair V1' V2') :-
    eff2del/value V1 V1',
    eff2del/value V2 V2'.
eff2del/value (eff/inj L V) (del/inj L' V') :-
    eff2del/label L L',
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
eff2del/comp (eff/call (eff/op X) V)
    (del/shift k\ (del/fun h\ del/app (del/force h) (del/inj (del/lbl X') (del/pair V' (del/thunk (del/fun y\ del/app (del/app (del/force k) y) h)))))) :-
    eff2del/nat X X',
    eff2del/value V V'.
eff2del/comp (eff/handle M H)
    (del/app (del/reset M' (x\ del/fun b\ (Nu' x))) (del/thunk (del/fun y\ del/case y Ms'))) :-
    eff2del/comp M M',
    eff2del/handler H Nu' Ms'.

eff2del/cases eff/cases/nil del/cases/nil.
eff2del/cases (eff/cases/cons Ms L M) (del/cases/cons Ms' L' M') :-
    eff2del/cases Ms Ms',
    eff2del/label L L',
    pi x\ pi x'\
        eff2del/value x x' =>
        eff2del/comp (M x) (M' x').

eff2del/handler (eff/valcase N) N' del/cases/nil :-
    pi x\ pi x'\
        eff2del/value x x' =>
        eff2del/comp (N x) (N' x').
eff2del/handler (eff/opcase H (eff/op X) M) Nu
    (del/cases/cons Ms (del/lbl X') (p\ del/split p M')) :-
    eff2del/handler H Nu Ms,
    eff2del/nat X X',
    pi x\ pi x'\
    pi k\ pi k'\
        eff2del/value x x' =>
        eff2del/value k k' =>
        eff2del/comp (M x k) (M' x' k').

eff2del/evctx eff/hole del/hole.
eff2del/evctx (eff/evctx/bind E N) (del/evctx/bind E' N') :-
    eff2del/evctx E E',
    pi x\ pi x'\
        eff2del/value x x' =>
        eff2del/comp (N x) (N' x').
eff2del/evctx (eff/evctx/app E V) (del/evctx/app E' V') :-
    eff2del/evctx E E',
    eff2del/value V V'.
eff2del/evctx (eff/evctx/handle E H)
    (del/evctx/app (del/evctx/reset E' (x\ del/fun b\ (Nu' x))) (del/thunk (del/fun y\ del/case y Ms'))) :-
    eff2del/evctx E E',
    eff2del/handler H Nu' Ms'.

del/is-evctx del/hole.
del/is-evctx (del/evctx/bind E N) :- del/is-evctx E.
del/is-evctx (del/evctx/app E V) :- del/is-evctx E.
del/is-evctx (del/evctx/reset E N) :- del/is-evctx E.
