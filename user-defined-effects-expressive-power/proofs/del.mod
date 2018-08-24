module del.
accumulate auto-del.

del/wf-eff (del/cons Eff C) :-
    del/wf-eff Eff,
    del/wf-compty C.

del/plug (del/evctx/reset E N) M (del/reset EM N) :-
    del/plug E M EM.

del/reduce (del/reset (del/ret V) N) (N V).
del/reduce (del/reset ESM N) (M (del/thunk (del/fun (x\ del/reset (ER x) N)))) :-
    del/plug E (del/shift M) ESM,
    del/hoisting E,
    pi x\ del/plug E (del/ret x) (ER x).

del/progresses ES C :-
    del/eff-kind C (del/cons _ _),
    del/hoisting E,
    del/plug E (del/shift _) ES.

del/of-comp (del/reset M N) C :-
    del/eff-kind C Eff,
    pi x\ (del/of-value x A => del/of-comp (N x) C),
    del/of-comp M (del/f (del/cons Eff C) A).
del/of-comp (del/shift M) (del/f (del/cons Eff C) A) :-
    del/eff-kind C Eff,
    pi k\ (del/of-value k (del/u (del/arrow A C)) => del/of-comp (M k) C).

del/of-evctx (del/evctx/reset E N) C D :-
    del/eff-kind D Eff,
    pi x\ (del/of-value x A => del/of-comp (N x) D),
    del/of-evctx E C (del/f (del/cons Eff D) A).
