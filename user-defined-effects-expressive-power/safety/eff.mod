module eff.

accumulate mam.

op/apart (op N) (op N') :-
    apart N N'.

op-sig (cons _ Op A B) Op A B.
op-sig (cons Eff Op' _ _) Op A B :-
    op/apart Op Op',
    op-sig Eff Op A B.

plug (evctx/handle E H) M (handle EM H) :-
    plug E M EM.

get-valcase (valcase M) M.
get-valcase (opcase H _ _) M :-
    get-valcase H M.

get-opcase (opcase H Op M) Op M.
get-opcase (opcase H Op' _) Op M :-
    op/apart Op Op',
    get-opcase H Op M.

reduce (handle (ret V) H) (M V) :-
    get-valcase H M.
reduce (handle EOp H) (M V (thunk (fun x\ handle (ER x) H))) :-
    plug E (call Op V) EOp,
    pi x\ plug E (ret x) (ER x),
    hoisting E,
    get-opcase H Op M.


of/handler (valcase M) A empty C :-
    pi x\ (of/value x A => of/comp (M x) C).
of/handler (opcase H Op M) A (cons Eff Op A1 A2) C :-
    of/handler H A Eff C,
    pi x\ pi k\ (of/value x A1 => of/value k (u (arrow A2 C)) => of/comp (M x k) C).

of/comp (call Op V) (f Eff B) :-
    op-sig Eff Op A B,
    of/value V A.
of/comp (handle M H) C :-
    of/comp M (f Eff A),
    of/handler H A Eff C.

of/evctx (evctx/handle E H) C C' :-
    of/evctx E C (f Eff A),
    of/handler H A Eff C'.

progresses EOp C :-
    eff-kind C Eff,
    op-sig Eff Op _ _,
    plug E (call Op _) EOp,
    hoisting E.
