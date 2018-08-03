module del.

accumulate mam.

is-eff (cons Eff C) :-
    is-eff Eff,
    pi a\ is-valty a => is-compty (C a).

plug (evctx/reset E N) M (reset EM N) :-
    plug E M EM.

reduce (reset (ret V) N) (N V).
reduce (reset ESM N) (M (thunk (fun (x\ reset (ER x) N)))) :-
    plug E (shift M) ESM,
    hoisting E,
    pi x\ plug E (ret x) (ER x).

progresses ES C :-
    eff-kind C (cons _ _),
    hoisting E,
    plug E (shift _) ES.

of/comp (reset M N) (C A) :-
    pi a\ eff-kind (C a) Eff,
    pi x\ (of/value x A => of/comp (N x) (C A)),
    of/comp M (f (cons Eff C) A).
of/comp (shift M) (f (cons Eff C) A) :-
    is-valty A,
    pi a\ eff-kind (C a) Eff,
    pi a\ pi k\ (of/value k (u (arrow A (C a))) => of/comp (M k) (C a)).

of/evctx (evctx/reset E N) C (D A) :-
    pi a\ eff-kind (D a) Eff,
    pi x\ (of/value x A => of/comp (N x) (D A)),
    of/evctx E C (f (cons Eff D) A).
