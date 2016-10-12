module cbpv.

eff-kind (f Eff A) Eff.
eff-kind (arrow _ C) Eff :- eff-kind C Eff.

of/value unit unitty.
of/value (pair V1 V2) (prod A1 A2) :- of/value V1 A1, of/value V2 A2.
of/value (inl V) (sum A1 _) :- of/value V A1.
of/value (inr V) (sum _ A2) :- of/value V A2.
of/value (thunk M) (u C) :- of/comp M C.

of/comp (ret V) (f _ A) :- of/value V A.
of/comp (fun M) (arrow A C) :- pi x\ (of/value x A => of/comp (M x) C).
of/comp (split V M) C :-
    of/value V (prod A1 A2),
    pi x1\ pi x2\ (of/value x1 A1 => of/value x2 A2 => of/comp (M x1 x2) C).
of/comp (case V M1 M2) C :-
    of/value V (sum A1 A2),
    pi x\ (of/value x A1 => of/comp (M1 x) C),
    pi x\ (of/value x A2 => of/comp (M2 x) C).
of/comp (force V) C :- of/value V (u C).
of/comp (bind M N) C :-
    eff-kind C Eff,
    of/comp M (f Eff A),
    pi x\ (of/value x A => of/comp (N x) C).
of/comp (app M V) C :-
    of/comp M (arrow A C),
    of/value V A.

of/evctx hole C C.
of/evctx (evctx/bind E N) C1 C2 :-
    eff-kind C2 Eff,
    of/evctx E C1 (f Eff A),
    pi x\ (of/value x A => of/comp (N x) C2).
of/evctx (evctx/app E V) C1 C2 :-
    of/evctx E C1 (arrow A C2),
    of/value V A.

reduce (split (pair V1 V2) M) (M V1 V2).
reduce (case (inl V) M1 _) (M1 V).
reduce (case (inr V) _ M2) (M2 V).
reduce (force (thunk M)) M.
reduce (bind (ret V) M) (M V).
reduce (app (fun M) V) (M V).

plug hole M M.
plug (evctx/bind E N) M (bind EM N) :-
    plug E M EM.
plug (evctx/app E V) M (app EM V) :-
    plug E M EM.

hoisting hole.
hoisting (evctx/bind E _) :-
    hoisting E.
hoisting (evctx/app E _) :-
    hoisting E.

step M M' :-
    plug E R M,
    reduce R R',
    plug E R' M'.

progresses (ret _) _.
progresses (fun _) _.
progresses M _ :-
    step M _.
