module mon.
accumulate auto-mon.

mon/is-evctx (mon/evctx/reify E T) :-
    mon/is-evctx E.

mon/wf-eff (mon/cons Eff C _ _) :-
    mon/wf-eff Eff,
    pi a\ mon/wf-valty a => mon/wf-compty (C a).

mon/plug (mon/evctx/reify E T) M (mon/reify EM T) :-
    mon/plug E M EM.

mon/reduce (mon/reify (mon/ret V) (mon/mon Nu _)) (Nu V).
mon/reduce (mon/reify ERN (mon/mon Nu Nb)) (Nb (mon/thunk N) (mon/thunk (mon/fun (x\ mon/reify (ER x) (mon/mon Nu Nb))))) :-
    mon/plug E (mon/reflect N) ERN,
    mon/hoisting E,
    pi x\ mon/plug E (mon/ret x) (ER x).

mon/of-monad (mon/mon Nu Nb) (mon/cons Eff C Nu Nb) :-
    pi a\ pi x\ (mon/wf-valty a => mon/of-value x a => mon/of-comp (Nu x) (C a)),
    pi a\ pi b\ pi x\ pi k\ (mon/wf-valty a => mon/wf-valty b => mon/of-value x (mon/u (C a)) => mon/of-value k (mon/u (mon/arrow a (C b))) => mon/of-comp (Nb x k) (C b)).

mon/of-comp' (mon/reify N T) (C A) :-
    mon/of-monad T (mon/cons Eff C Nu Nb),
    mon/of-comp N (mon/f (mon/cons Eff C Nu Nb) A).
mon/of-comp' (mon/reflect N) (mon/f (mon/cons Eff C Nu Nb) A) :-
    mon/of-comp N (C A).

mon/of-evctx (mon/evctx/reify E T) D (C A) :-
    mon/of-monad T (mon/cons Eff C Nu Nb),
    mon/of-evctx E D (mon/f (mon/cons Eff C Nu Nb) A).

mon/progresses ES C :-
    mon/eff-kind C (mon/cons _ _ _ _),
    mon/hoisting E,
    mon/plug E (mon/reflect _) ES.
