module mon.

accumulate mam.

is-eff (cons Eff C _ _) :-
    is-eff Eff,
    pi a\ is-valty a => is-compty (C a).

plug (evctx/reify E T) M (reify EM T) :-
    plug E M EM.

reduce (reify (ret V) (mon Nu _)) (Nu V).
reduce (reify ERN (mon Nu Nb)) (Nb (thunk N) (thunk (fun (x\ reify (ER x) (mon Nu Nb))))) :-
    plug E (reflect N) ERN,
    hoisting E,
    pi x\ plug E (ret x) (ER x).

of/monad (mon Nu Nb) (cons Eff C Nu Nb) :-
    pi a\ pi x\ (is-valty a => of/value x a => of/comp (Nu x) (C a)),
    pi a\ pi b\ pi x\ pi k\ (is-valty a => is-valty b => of/value x (u (C a)) => of/value k (u (arrow a (C b))) => of/comp (Nb x k) (C b)).

of/comp (reify N T) (C A) :-
    of/monad T (cons Eff C Nu Nb),
    of/comp N (f (cons Eff C Nu Nb) A).
of/comp (reflect N) (f (cons Eff C Nu Nb) A) :-
    of/comp N (C A).

of/evctx (evctx/reify E T) D (C A) :-
    of/monad T (cons Eff C Nu Nb),
    of/evctx E D (f (cons Eff C Nu Nb) A).

progresses ES C :-
    eff-kind C (cons _ _ _ _),
    hoisting E,
    plug E (reflect _) ES.
