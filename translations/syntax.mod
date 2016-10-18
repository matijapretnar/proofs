module syntax.

cbpv/eff-kind (cbpv/f Eff A) Eff.
cbpv/eff-kind (cbpv/arrow _ C) Eff :- cbpv/eff-kind C Eff.

cbpv/of/value cbpv/unit cbpv/unitty.
cbpv/of/value (cbpv/pair V1 V2) (cbpv/prod A1 A2) :- cbpv/of/value V1 A1, cbpv/of/value V2 A2.
cbpv/of/value (cbpv/inl V) (cbpv/sum A1 _) :- cbpv/of/value V A1.
cbpv/of/value (cbpv/inr V) (cbpv/sum _ A2) :- cbpv/of/value V A2.
cbpv/of/value (cbpv/thunk M) (cbpv/u C) :- cbpv/of/comp M C.

cbpv/of/comp (cbpv/ret V) (cbpv/f _ A) :- cbpv/of/value V A.
cbpv/of/comp (cbpv/fun M) (cbpv/arrow A C) :- pi x\ (cbpv/of/value x A => cbpv/of/comp (M x) C).
cbpv/of/comp (cbpv/split V M) C :-
    cbpv/of/value V (cbpv/prod A1 A2),
    pi x1\ pi x2\ (cbpv/of/value x1 A1 => cbpv/of/value x2 A2 => cbpv/of/comp (M x1 x2) C).
cbpv/of/comp (cbpv/case V M1 M2) C :-
    cbpv/of/value V (cbpv/sum A1 A2),
    pi x\ (cbpv/of/value x A1 => cbpv/of/comp (M1 x) C),
    pi x\ (cbpv/of/value x A2 => cbpv/of/comp (M2 x) C).
cbpv/of/comp (cbpv/force V) C :- cbpv/of/value V (cbpv/u C).
cbpv/of/comp (cbpv/bind M N) C :-
    cbpv/eff-kind C Eff,
    cbpv/of/comp M (cbpv/f Eff A),
    pi x\ (cbpv/of/value x A => cbpv/of/comp (N x) C).
cbpv/of/comp (cbpv/app M V) C :-
    cbpv/of/comp M (cbpv/arrow A C),
    cbpv/of/value V A.

cbpv/of/evctx cbpv/hole C C.
cbpv/of/evctx (cbpv/evctx/bind E N) C1 C2 :-
    cbpv/eff-kind C2 Eff,
    cbpv/of/evctx E C1 (cbpv/f Eff A),
    pi x\ (cbpv/of/value x A => cbpv/of/comp (N x) C2).
cbpv/of/evctx (cbpv/evctx/app E V) C1 C2 :-
    cbpv/of/evctx E C1 (cbpv/arrow A C2),
    cbpv/of/value V A.

cbpv/reduce (cbpv/split (cbpv/pair V1 V2) M) (M V1 V2).
cbpv/reduce (cbpv/case (cbpv/inl V) M1 _) (M1 V).
cbpv/reduce (cbpv/case (cbpv/inr V) _ M2) (M2 V).
cbpv/reduce (cbpv/force (cbpv/thunk M)) M.
cbpv/reduce (cbpv/bind (cbpv/ret V) M) (M V).
cbpv/reduce (cbpv/app (cbpv/fun M) V) (M V).

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

cbpv/step M M' :-
    cbpv/plug E R M,
    cbpv/reduce R R',
    cbpv/plug E R' M'.

cbpv/progresses (cbpv/ret _) _.
cbpv/progresses (cbpv/fun _) _.
cbpv/progresses M _ :-
    cbpv/step M _.


mon/eff-kind (mon/f Eff A) Eff.
mon/eff-kind (mon/arrow _ C) Eff :- mon/eff-kind C Eff.

mon/of/value mon/unit mon/unitty.
mon/of/value (mon/pair V1 V2) (mon/prod A1 A2) :- mon/of/value V1 A1, mon/of/value V2 A2.
mon/of/value (mon/inl V) (mon/sum A1 _) :- mon/of/value V A1.
mon/of/value (mon/inr V) (mon/sum _ A2) :- mon/of/value V A2.
mon/of/value (mon/thunk M) (mon/u C) :- mon/of/comp M C.

mon/of/comp (mon/ret V) (mon/f _ A) :- mon/of/value V A.
mon/of/comp (mon/fun M) (mon/arrow A C) :- pi x\ (mon/of/value x A => mon/of/comp (M x) C).
mon/of/comp (mon/split V M) C :-
    mon/of/value V (mon/prod A1 A2),
    pi x1\ pi x2\ (mon/of/value x1 A1 => mon/of/value x2 A2 => mon/of/comp (M x1 x2) C).
mon/of/comp (mon/case V M1 M2) C :-
    mon/of/value V (mon/sum A1 A2),
    pi x\ (mon/of/value x A1 => mon/of/comp (M1 x) C),
    pi x\ (mon/of/value x A2 => mon/of/comp (M2 x) C).
mon/of/comp (mon/force V) C :- mon/of/value V (mon/u C).
mon/of/comp (mon/bind M N) C :-
    mon/eff-kind C Eff,
    mon/of/comp M (mon/f Eff A),
    pi x\ (mon/of/value x A => mon/of/comp (N x) C).
mon/of/comp (mon/app M V) C :-
    mon/of/comp M (mon/arrow A C),
    mon/of/value V A.

mon/of/evctx mon/hole C C.
mon/of/evctx (mon/evctx/bind E N) C1 C2 :-
    mon/eff-kind C2 Eff,
    mon/of/evctx E C1 (mon/f Eff A),
    pi x\ (mon/of/value x A => mon/of/comp (N x) C2).
mon/of/evctx (mon/evctx/app E V) C1 C2 :-
    mon/of/evctx E C1 (mon/arrow A C2),
    mon/of/value V A.

mon/reduce (mon/split (mon/pair V1 V2) M) (M V1 V2).
mon/reduce (mon/case (mon/inl V) M1 _) (M1 V).
mon/reduce (mon/case (mon/inr V) _ M2) (M2 V).
mon/reduce (mon/force (mon/thunk M)) M.
mon/reduce (mon/bind (mon/ret V) M) (M V).
mon/reduce (mon/app (mon/fun M) V) (M V).

mon/plug mon/hole M M.
mon/plug (mon/evctx/bind E N) M (mon/bind EM N) :-
    mon/plug E M EM.
mon/plug (mon/evctx/app E V) M (mon/app EM V) :-
    mon/plug E M EM.

mon/hoisting mon/hole.
mon/hoisting (mon/evctx/bind E _) :-
    mon/hoisting E.
mon/hoisting (mon/evctx/app E _) :-
    mon/hoisting E.

mon/step M M' :-
    mon/plug E R M,
    mon/reduce R R',
    mon/plug E R' M'.

mon/progresses (mon/ret _) _.
mon/progresses (mon/fun _) _.
mon/progresses M _ :-
    mon/step M _.


mon/plug (mon/evctx/reify E T) M (mon/reify EM T) :-
    mon/plug E M EM.

mon/reduce (mon/reify (mon/ret V) (mon/mon Nu _)) (Nu V).
mon/reduce (mon/reify ERN (mon/mon Nu Nb)) (Nb (mon/thunk N) (mon/thunk (mon/fun (x\ mon/reify (ER x) (mon/mon Nu Nb))))) :-
    mon/plug E (mon/reflect N) ERN,
    mon/hoisting E,
    pi x\ mon/plug E (mon/ret x) (ER x).

mon/of/monad (mon/mon Nu Nb) (mon/cons Eff C Nu Nb) :-
    pi a\ pi x\ (mon/of/value x a => mon/of/comp (Nu x) (C a)),
    pi a\ pi b\ pi x\ pi k\ (mon/of/value x (mon/u (C a)) => mon/of/value k (mon/u (mon/arrow a (C b))) => mon/of/comp (Nb x k) (C b)).

mon/of/comp (mon/reify N T) (C A) :-
    mon/of/monad T (mon/cons Eff C Nu Nb),
    mon/of/comp N (mon/f (mon/cons Eff C Nu Nb) A).
mon/of/comp (mon/reflect N) (mon/f (mon/cons Eff C Nu Nb) A) :-
    mon/of/comp N (C A).

mon/of/evctx (mon/evctx/reify E T) D (C A) :-
    mon/of/monad T (mon/cons Eff C Nu Nb),
    mon/of/evctx E D (mon/f (mon/cons Eff C Nu Nb) A).

mon/progresses ES C :-
    mon/eff-kind C (mon/cons _ _ _ _),
    mon/hoisting E,
    mon/plug E (mon/reflect _) ES.


del/eff-kind (del/f Eff A) Eff.
del/eff-kind (del/arrow _ C) Eff :- del/eff-kind C Eff.

del/of/value del/unit del/unitty.
del/of/value (del/pair V1 V2) (del/prod A1 A2) :- del/of/value V1 A1, del/of/value V2 A2.
del/of/value (del/inl V) (del/sum A1 _) :- del/of/value V A1.
del/of/value (del/inr V) (del/sum _ A2) :- del/of/value V A2.
del/of/value (del/thunk M) (del/u C) :- del/of/comp M C.

del/of/comp (del/ret V) (del/f _ A) :- del/of/value V A.
del/of/comp (del/fun M) (del/arrow A C) :- pi x\ (del/of/value x A => del/of/comp (M x) C).
del/of/comp (del/split V M) C :-
    del/of/value V (del/prod A1 A2),
    pi x1\ pi x2\ (del/of/value x1 A1 => del/of/value x2 A2 => del/of/comp (M x1 x2) C).
del/of/comp (del/case V M1 M2) C :-
    del/of/value V (del/sum A1 A2),
    pi x\ (del/of/value x A1 => del/of/comp (M1 x) C),
    pi x\ (del/of/value x A2 => del/of/comp (M2 x) C).
del/of/comp (del/force V) C :- del/of/value V (del/u C).
del/of/comp (del/bind M N) C :-
    del/eff-kind C Eff,
    del/of/comp M (del/f Eff A),
    pi x\ (del/of/value x A => del/of/comp (N x) C).
del/of/comp (del/app M V) C :-
    del/of/comp M (del/arrow A C),
    del/of/value V A.

del/of/evctx del/hole C C.
del/of/evctx (del/evctx/bind E N) C1 C2 :-
    del/eff-kind C2 Eff,
    del/of/evctx E C1 (del/f Eff A),
    pi x\ (del/of/value x A => del/of/comp (N x) C2).
del/of/evctx (del/evctx/app E V) C1 C2 :-
    del/of/evctx E C1 (del/arrow A C2),
    del/of/value V A.

del/reduce (del/split (del/pair V1 V2) M) (M V1 V2).
del/reduce (del/case (del/inl V) M1 _) (M1 V).
del/reduce (del/case (del/inr V) _ M2) (M2 V).
del/reduce (del/force (del/thunk M)) M.
del/reduce (del/bind (del/ret V) M) (M V).
del/reduce (del/app (del/fun M) V) (M V).

del/plug del/hole M M.
del/plug (del/evctx/bind E N) M (del/bind EM N) :-
    del/plug E M EM.
del/plug (del/evctx/app E V) M (del/app EM V) :-
    del/plug E M EM.

del/hoisting del/hole.
del/hoisting (del/evctx/bind E _) :-
    del/hoisting E.
del/hoisting (del/evctx/app E _) :-
    del/hoisting E.

del/step M M' :-
    del/plug E R M,
    del/reduce R R',
    del/plug E R' M'.

del/progresses (del/ret _) _.
del/progresses (del/fun _) _.
del/progresses M _ :-
    del/step M _.


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

del/of/comp (del/reset M N) C :-
    del/eff-kind C Eff,
    pi x\ (del/of/value x A => del/of/comp (N x) C),
    del/of/comp M (del/f (del/cons Eff C) A).
del/of/comp (del/shift M) (del/f (del/cons Eff C) A) :-
    del/eff-kind C Eff,
    pi k\ (del/of/value k (del/u (del/arrow A C)) => del/of/comp (M k) C).

del/of/evctx (del/evctx/reset E N) C D :-
    del/eff-kind D Eff,
    pi x\ (del/of/value x A => del/of/comp (N x) D),
    del/of/evctx E C (del/f (del/cons Eff D) A).


eff/eff-kind (eff/f Eff A) Eff.
eff/eff-kind (eff/arrow _ C) Eff :- eff/eff-kind C Eff.

eff/of/value eff/unit eff/unitty.
eff/of/value (eff/pair V1 V2) (eff/prod A1 A2) :- eff/of/value V1 A1, eff/of/value V2 A2.
eff/of/value (eff/inl V) (eff/sum A1 _) :- eff/of/value V A1.
eff/of/value (eff/inr V) (eff/sum _ A2) :- eff/of/value V A2.
eff/of/value (eff/thunk M) (eff/u C) :- eff/of/comp M C.

eff/of/comp (eff/ret V) (eff/f _ A) :- eff/of/value V A.
eff/of/comp (eff/fun M) (eff/arrow A C) :- pi x\ (eff/of/value x A => eff/of/comp (M x) C).
eff/of/comp (eff/split V M) C :-
    eff/of/value V (eff/prod A1 A2),
    pi x1\ pi x2\ (eff/of/value x1 A1 => eff/of/value x2 A2 => eff/of/comp (M x1 x2) C).
eff/of/comp (eff/case V M1 M2) C :-
    eff/of/value V (eff/sum A1 A2),
    pi x\ (eff/of/value x A1 => eff/of/comp (M1 x) C),
    pi x\ (eff/of/value x A2 => eff/of/comp (M2 x) C).
eff/of/comp (eff/force V) C :- eff/of/value V (eff/u C).
eff/of/comp (eff/bind M N) C :-
    eff/eff-kind C Eff,
    eff/of/comp M (eff/f Eff A),
    pi x\ (eff/of/value x A => eff/of/comp (N x) C).
eff/of/comp (eff/app M V) C :-
    eff/of/comp M (eff/arrow A C),
    eff/of/value V A.

eff/of/evctx eff/hole C C.
eff/of/evctx (eff/evctx/bind E N) C1 C2 :-
    eff/eff-kind C2 Eff,
    eff/of/evctx E C1 (eff/f Eff A),
    pi x\ (eff/of/value x A => eff/of/comp (N x) C2).
eff/of/evctx (eff/evctx/app E V) C1 C2 :-
    eff/of/evctx E C1 (eff/arrow A C2),
    eff/of/value V A.

eff/reduce (eff/split (eff/pair V1 V2) M) (M V1 V2).
eff/reduce (eff/case (eff/inl V) M1 _) (M1 V).
eff/reduce (eff/case (eff/inr V) _ M2) (M2 V).
eff/reduce (eff/force (eff/thunk M)) M.
eff/reduce (eff/bind (eff/ret V) M) (M V).
eff/reduce (eff/app (eff/fun M) V) (M V).

eff/plug eff/hole M M.
eff/plug (eff/evctx/bind E N) M (eff/bind EM N) :-
    eff/plug E M EM.
eff/plug (eff/evctx/app E V) M (eff/app EM V) :-
    eff/plug E M EM.

eff/hoisting eff/hole.
eff/hoisting (eff/evctx/bind E _) :-
    eff/hoisting E.
eff/hoisting (eff/evctx/app E _) :-
    eff/hoisting E.

eff/step M M' :-
    eff/plug E R M,
    eff/reduce R R',
    eff/plug E R' M'.

eff/progresses (eff/ret _) _.
eff/progresses (eff/fun _) _.
eff/progresses M _ :-
    eff/step M _.


eff/apart eff/op/z (eff/op/s _).
eff/apart (eff/op/s _) eff/op/z.
eff/apart (eff/op/s Op) (eff/op/s Op') :-
    eff/apart Op Op'.

eff/op-sig (eff/cons _ Op A B) Op A B.
eff/op-sig (eff/cons Eff Op' _ _) Op A B :-
    eff/apart Op Op',
    eff/op-sig Eff Op A B.

eff/plug (eff/evctx/handle E H) M (eff/handle EM H) :-
    eff/plug E M EM.

eff/get-valcase (eff/valcase M) M.
eff/get-valcase (eff/opcase H _ _) M :-
    eff/get-valcase H M.

eff/get-opcase (eff/opcase H Op M) Op M.
eff/get-opcase (eff/opcase H Op' _) Op M :-
    eff/apart Op Op',
    eff/get-opcase H Op M.

eff/reduce (eff/handle (eff/ret V) H) (M V) :-
    eff/get-valcase H M.
eff/reduce (eff/handle EOp H) (M V (eff/thunk (eff/fun x\ eff/handle (ER x) H))) :-
    eff/plug E (eff/call Op V) EOp,
    pi x\ eff/plug E (eff/ret x) (ER x),
    eff/hoisting E,
    eff/get-opcase H Op M.


eff/of/handler (eff/valcase M) A eff/empty C :-
    pi x\ (eff/of/value x A => eff/of/comp (M x) C).
eff/of/handler (eff/opcase H Op M) A (eff/cons Eff Op A1 A2) C :-
    eff/of/handler H A Eff C,
    pi x\ pi k\ (eff/of/value x A1 => eff/of/value k (eff/u (eff/arrow A2 C)) => eff/of/comp (M x k) C).

eff/of/comp (eff/call Op V) (eff/f Eff B) :-
    eff/op-sig Eff Op A B,
    eff/of/value V A.
eff/of/comp (eff/handle M H) C :-
    eff/of/comp M (eff/f Eff A),
    eff/of/handler H A Eff C.

eff/of/evctx (eff/evctx/handle E H) C C' :-
    eff/of/evctx E C (eff/f Eff A),
    eff/of/handler H A Eff C'.

eff/progresses EOp C :-
    eff/eff-kind C Eff,
    eff/op-sig Eff Op _ _,
    eff/plug E (eff/call Op _) EOp,
    eff/hoisting E.
