module del.

accumulate cbpv.

plug (evctx/reset E N) M (reset EM N) :-
    plug E M EM.

resetfree hole.
resetfree (evctx/bind E _) :-
    resetfree E.
resetfree (evctx/app E _) :-
    resetfree E.

reduce (reset (ret V) N) (N V).
reduce (reset ESM N) (M (thunk (fun (x\ reset (ER x) N)))) :-
    plug E (shift M) ESM,
    resetfree E,
    pi x\ plug E (ret x) (ER x).

progresses ES C :-
    eff-kind C (cons _ _),
    resetfree E,
    plug E (shift _) ES.

of/comp (reset M N) C :-
    eff-kind C Eff,
    pi x\ (of/value x A => of/comp (N x) C),
    of/comp M (f (cons Eff C) A).
of/comp (shift M) (f (cons Eff C) A) :-
    eff-kind C Eff,
    pi k\ (of/value k (u (arrow A C)) => of/comp (M k) C).

of/evctx (evctx/reset E N) C D :-
    eff-kind D Eff,
    pi x\ (of/value x A => of/comp (N x) D),
    of/evctx E C (f (cons Eff D) A).
