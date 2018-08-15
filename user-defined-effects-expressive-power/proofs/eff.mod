module eff.
accumulate auto-eff.

eff/is-evctx (eff/evctx/handle E H) :- eff/is-evctx E.

eff/op/apart (eff/op N) (eff/op N') :-
    apart N N'.

eff/op-sig (eff/cons _ Op A B) Op A B.
eff/op-sig (eff/cons Eff Op' _ _) Op A B :-
    eff/op/apart Op Op',
    eff/op-sig Eff Op A B.

eff/plug (eff/evctx/handle E H) M (eff/handle EM H) :-
    eff/plug E M EM.

eff/get-valcase (eff/valcase M) M.
eff/get-valcase (eff/opcase H _ _) M :-
    eff/get-valcase H M.

eff/get-opcase (eff/opcase H Op M) Op M.
eff/get-opcase (eff/opcase H Op' _) Op M :-
    eff/op/apart Op Op',
    eff/get-opcase H Op M.

eff/reduce (eff/handle (eff/ret V) H) (M V) :-
    eff/get-valcase H M.
eff/reduce (eff/handle EOp H) (M V (eff/thunk (eff/fun x\ eff/handle (ER x) H))) :-
    eff/plug E (eff/call Op V) EOp,
    pi x\ eff/plug E (eff/ret x) (ER x),
    eff/hoisting E,
    eff/get-opcase H Op M.


eff/of-handler (eff/valcase M) A eff/empty C :-
    pi x\ (eff/of-value x A => eff/of-comp (M x) C).
eff/of-handler (eff/opcase H Op M) A (eff/cons Eff Op A1 A2) C :-
    eff/of-handler H A Eff C,
    pi x\ pi k\ (eff/of-value x A1 => eff/of-value k (eff/u (eff/arrow A2 C)) => eff/of-comp (M x k) C).

eff/of-comp (eff/call Op V) (eff/f Eff B) :-
    eff/op-sig Eff Op A B,
    eff/of-value V A.
eff/of-comp (eff/handle M H) C :-
    eff/of-comp M (eff/f Eff A),
    eff/of-handler H A Eff C.

eff/of-evctx (eff/evctx/handle E H) C C' :-
    eff/of-evctx E C (eff/f Eff A),
    eff/of-handler H A Eff C'.

eff/progresses EOp C :-
    eff/eff-kind C Eff,
    eff/op-sig Eff Op _ _,
    eff/plug E (eff/call Op _) EOp,
    eff/hoisting E.
