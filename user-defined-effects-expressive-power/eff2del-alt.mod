module eff2del-alt.
accumulate auto-eff2del.

eff2del/comp (eff/call (eff/op X) V)
    (del/shift k\ (del/shift h\ del/app (del/force h) (del/inj (lbl X) (del/pair V' (del/thunk (del/fun x\ del/reset (del/app (del/force k) x) (y\ del/app (del/force h) y))))))) :-
    eff2del/value V V'.
eff2del/comp (eff/handle M H)
    (del/reset (del/reset M' (x\ del/shift h\ (Nu' x))) (y\ del/case y Ms')) :-
    eff2del/comp M M',
    eff2del/handler H Nu' Ms'.

eff2del/handler (eff/valcase N) N' del/cases/nil :-
    pi x\ pi x'\
        eff2del/value x x' =>
        eff2del/comp (N x) (N' x').
eff2del/handler (eff/opcase H (eff/op X) M) Nu
    (del/cases/cons Ms (lbl X) (p\ del/split p M')) :-
    eff2del/handler H Nu Ms,
    pi x\ pi x'\
    pi k\ pi k'\
        eff2del/value x x' =>
        eff2del/value k k' =>
        eff2del/comp (M x k) (M' x' k').

eff2del/evctx (eff/evctx/handle E H)
    (del/evctx/reset (del/evctx/reset E' (x\ del/shift h\ (Nu' x))) (y\ del/case y Ms')) :-
    eff2del/evctx E E',
    eff2del/handler H Nu' Ms'.

