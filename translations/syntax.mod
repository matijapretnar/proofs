module syntax.

%%% CBPV %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cbpv/plug cbpv/hole M M.
cbpv/plug (cbpv/evctx/bind E N) M (cbpv/bind EM N) :-
    cbpv/plug E M EM.
cbpv/plug (cbpv/evctx/app E V) M (cbpv/app EM V) :-
    cbpv/plug E M EM.

cbpv/hoisting cbpv/hole.
cbpv/hoisting (cbpv/evctx/bind E _) :-
    cbpv/hoisting E.
cbpv/hoisting (cbpv/evctx/app E _) :-
    cbpv/hoisting E.

cbpv/reduce (cbpv/split (cbpv/pair V1 V2) M) (M V1 V2).
cbpv/reduce (cbpv/case (cbpv/inl V) M1 _) (M1 V).
cbpv/reduce (cbpv/case (cbpv/inr V) _ M2) (M2 V).
cbpv/reduce (cbpv/force (cbpv/thunk M)) M.
cbpv/reduce (cbpv/bind (cbpv/ret V) M) (M V).
cbpv/reduce (cbpv/app (cbpv/fun M) V) (M V).

cbpv/step M M' :-
    cbpv/plug E R M,
    cbpv/reduce R R',
    cbpv/plug E R' M'.

%%% DEL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

del/plug del/hole M M.
del/plug (del/evctx/bind E N) M (del/bind EM N) :-
    del/plug E M EM.
del/plug (del/evctx/app E V) M (del/app EM V) :-
    del/plug E M EM.
del/plug (del/evctx/reset E N) M (del/reset EM N) :-
    del/plug E M EM.

del/hoisting del/hole.
del/hoisting (del/evctx/bind E _) :-
    del/hoisting E.
del/hoisting (del/evctx/app E _) :-
    del/hoisting E.

del/reduce (del/split (del/pair V1 V2) M) (M V1 V2).
del/reduce (del/case (del/inl V) M1 _) (M1 V).
del/reduce (del/case (del/inr V) _ M2) (M2 V).
del/reduce (del/force (del/thunk M)) M.
del/reduce (del/bind (del/ret V) M) (M V).
del/reduce (del/app (del/fun M) V) (M V).
del/reduce (del/reset (del/ret V) N) (N V).
del/reduce (del/reset ESM N) (M (del/thunk (del/fun (x\ del/reset (ER x) N)))) :-
    del/plug E (del/shift M) ESM,
    del/hoisting E,
    pi x\ del/plug E (del/ret x) (ER x).

del/step M M' :-
    del/plug E R M,
    del/reduce R R',
    del/plug E R' M'.

%%% MON %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mon/plug mon/hole M M.
mon/plug (mon/evctx/bind E N) M (mon/bind EM N) :-
    mon/plug E M EM.
mon/plug (mon/evctx/app E V) M (mon/app EM V) :-
    mon/plug E M EM.
mon/plug (mon/evctx/reify E T) M (mon/reify EM T) :-
    mon/plug E M EM.

mon/hoisting mon/hole.
mon/hoisting (mon/evctx/bind E _) :-
    mon/hoisting E.
mon/hoisting (mon/evctx/app E _) :-
    mon/hoisting E.

mon/reduce (mon/split (mon/pair V1 V2) M) (M V1 V2).
mon/reduce (mon/case (mon/inl V) M1 _) (M1 V).
mon/reduce (mon/case (mon/inr V) _ M2) (M2 V).
mon/reduce (mon/force (mon/thunk M)) M.
mon/reduce (mon/bind (mon/ret V) M) (M V).
mon/reduce (mon/app (mon/fun M) V) (M V).
mon/reduce (mon/reify (mon/ret V) (mon/mon Nu _)) (Nu V).
mon/reduce (mon/reify ERN (mon/mon Nu Nb)) (Nb (mon/thunk M) (mon/thunk (mon/fun (x\ mon/reify (ER x) (mon/mon Nu Nb))))) :-
    mon/plug E (mon/reflect M (mon/mon Nu Nb)) ERN,
    mon/hoisting E,
    pi x\ mon/plug E (mon/ret x) (ER x).

mon/step M M' :-
    mon/plug E R M,
    mon/reduce R R',
    mon/plug E R' M'.
