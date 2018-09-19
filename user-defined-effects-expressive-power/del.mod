module del.
accumulate auto-del.

del/wf-eff (del/cons Eff C) :-
    del/wf-eff Eff,
    del/wf-compty Eff C.

del/plug (del/evctx/reset E N) M (del/reset EM N) :-
    del/plug E M EM.

del/reduce (del/reset (del/ret V) N) (N V).
del/reduce (del/reset ESM N) (M (del/thunk (del/fun (x\ del/reset (ER x) N)))) :-
    del/plug E (del/shift M) ESM,
    del/hoisting E,
    pi x\ del/plug E (del/ret x) (ER x).

del/progresses ES (del/cons _ _) :-
    del/hoisting E,
    del/plug E (del/shift _) ES.

del/of-comp' (del/reset M N) Eff C :-
    pi x\ (del/of-value x A => del/of-comp (N x) Eff C),
    del/of-comp M (del/cons Eff C) (del/f A).
del/of-comp' (del/shift M) (del/cons Eff C) (del/f A) :-
    pi k\ (del/of-value k (del/u Eff (del/arrow A C)) => del/of-comp (M k) Eff C).

del/of-evctx' (del/evctx/reset E N) Eff1 C Eff2 D :-
    pi x\ (del/of-value x A => del/of-comp (N x) Eff2 D),
    del/of-evctx E Eff1 C (del/cons Eff2 D) (del/f A).
