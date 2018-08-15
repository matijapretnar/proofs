module auto-mam.
accumulate common.

mam/eff-kind (mam/f Eff A) Eff :-
    mam/is-eff Eff.
mam/eff-kind (mam/arrow _ C) Eff :- mam/eff-kind C Eff.
mam/eff-kind (mam/compprod C1 C2) Eff :-
    mam/eff-kind C1 Eff,
    mam/eff-kind C2 Eff.

mam/is-eff mam/empty.

mam/is-valty mam/unitty.
mam/is-valty (mam/prod A1 A2) :-
    mam/is-valty A1,
    mam/is-valty A2.
mam/is-valty (mam/sum As) :-
    mam/is-valtys As.
mam/is-valty (mam/u C) :-
    mam/is-compty C.

mam/is-valtys mam/valtys/nil.
mam/is-valtys (mam/valtys/cons As L A) :-
    mam/is-valtys As,
    mam/is-valty A.

mam/is-compty (mam/f Eff A) :-
    mam/is-eff Eff,
    mam/is-valty A.
mam/is-compty (mam/arrow A C) :-
    mam/is-valty A,
    mam/is-compty C.
mam/is-compty (mam/compprod C1 C2) :-
    mam/is-compty C1,
    mam/is-compty C2.

mam/of-value mam/unit mam/unitty.
mam/of-value (mam/pair V1 V2) (mam/prod A1 A2) :-
    mam/of-value V1 A1,
    mam/of-value V2 A2.
mam/of-value (mam/inj L V) (mam/sum As) :-
    mam/of-value V A,
    mam/valtys/get As L A.
mam/of-value (mam/thunk M) (mam/u C) :- mam/of-comp M C.

mam/of-comp (mam/ret V) (mam/f Eff A) :-
    mam/is-eff Eff,
    mam/of-value V A.
mam/of-comp (mam/fun M) (mam/arrow A C) :-
    mam/is-valty A,
    pi x\ (mam/of-value x A => mam/of-comp (M x) C).
mam/of-comp (mam/split V M) C :-
    mam/of-value V (mam/prod A1 A2),
    pi x1\ pi x2\ (mam/of-value x1 A1 => mam/of-value x2 A2 => mam/of-comp (M x1 x2) C).
mam/of-comp (mam/case V Ms) C :-
    mam/of-value V (mam/sum As),
    mam/of-cases Ms As C.
mam/of-comp (mam/force V) C :- mam/of-value V (mam/u C).
mam/of-comp (mam/bind M N) C :-
    mam/eff-kind C Eff,
    mam/of-comp M (mam/f Eff A),
    pi x\ (mam/of-value x A => mam/of-comp (N x) C).
mam/of-comp (mam/app M V) C :-
    mam/of-comp M (mam/arrow A C),
    mam/of-value V A.
mam/of-comp (mam/comppair M1 M2) (mam/compprod C1 C2) :-
    mam/of-comp M1 C1,
    mam/of-comp M2 C2.
mam/of-comp (mam/prj1 M) C1 :-
    mam/eff-kind C1 Eff,
    mam/eff-kind C2 Eff,
    mam/of-comp M (mam/compprod C1 C2).
mam/of-comp (mam/prj2 M) C2 :-
    mam/eff-kind C1 Eff,
    mam/eff-kind C2 Eff,
    mam/of-comp M (mam/compprod C1 C2).

mam/of-cases mam/cases/nil mam/valtys/nil C :-
    mam/is-compty C.
mam/of-cases (mam/cases/cons Ms L M) (mam/valtys/cons As L A) C :-
    mam/of-cases Ms As C,
    mam/is-valty A,
    pi x\ (mam/of-value x A => mam/of-comp (M x) C).

mam/of-evctx mam/hole C C.
mam/of-evctx (mam/evctx/bind E N) C1 C2 :-
    mam/eff-kind C2 Eff,
    mam/of-evctx E C1 (mam/f Eff A),
    pi x\ (mam/of-value x A => mam/of-comp (N x) C2).
mam/of-evctx (mam/evctx/app E V) C1 C2 :-
    mam/of-evctx E C1 (mam/arrow A C2),
    mam/of-value V A.
mam/of-evctx (mam/evctx/prj1 E) C C1 :-
    mam/eff-kind C1 Eff,
    mam/eff-kind C2 Eff,
    mam/of-evctx E C (mam/compprod C1 C2).
mam/of-evctx (mam/evctx/prj2 E) C C2 :-
    mam/eff-kind C1 Eff,
    mam/eff-kind C2 Eff,
    mam/of-evctx E C (mam/compprod C1 C2).

mam/valtys/get (mam/valtys/cons As L A) L A.
mam/valtys/get (mam/valtys/cons As L' _) L A :-
    label-apart L L',
    mam/valtys/get As L A.

mam/get-case (mam/cases/cons Ms L M) L M.
mam/get-case (mam/cases/cons Ms L' _) L M :-
    label-apart L L',
    mam/get-case Ms L M.

mam/reduce (mam/split (mam/pair V1 V2) M) (M V1 V2).
mam/reduce (mam/case (mam/inj L V) Ms) (M V) :-
    mam/get-case Ms L M.
mam/reduce (mam/force (mam/thunk M)) M.
mam/reduce (mam/bind (mam/ret V) M) (M V).
mam/reduce (mam/app (mam/fun M) V) (M V).
mam/reduce (mam/prj1 (mam/comppair M1 _)) M1.
mam/reduce (mam/prj2 (mam/comppair _ M2)) M2.

mam/plug mam/hole M M.
mam/plug (mam/evctx/bind E N) M (mam/bind EM N) :-
    mam/plug E M EM.
mam/plug (mam/evctx/app E V) M (mam/app EM V) :-
    mam/plug E M EM.
mam/plug (mam/evctx/prj1 E) M (mam/prj1 EM) :-
    mam/plug E M EM.
mam/plug (mam/evctx/prj2 E) M (mam/prj2 EM) :-
    mam/plug E M EM.

mam/hoisting mam/hole.
mam/hoisting (mam/evctx/bind E _) :-
    mam/hoisting E.
mam/hoisting (mam/evctx/app E _) :-
    mam/hoisting E.
mam/hoisting (mam/evctx/prj1 E) :-
    mam/hoisting E.
mam/hoisting (mam/evctx/prj2 E) :-
    mam/hoisting E.

mam/step M M' :-
    mam/plug E R M,
    mam/reduce R R',
    mam/plug E R' M'.

mam/progresses (mam/ret _) _.
mam/progresses (mam/fun _) _.
mam/progresses (mam/comppair M1 M2) _ :-
    mam/progresses M1 _,
    mam/progresses M2 _.
mam/progresses M _ :-
    mam/step M _.

mam/is-evctx mam/hole.
mam/is-evctx (mam/evctx/bind E N) :- mam/is-evctx E.
mam/is-evctx (mam/evctx/app E V) :- mam/is-evctx E.
mam/is-evctx (mam/evctx/prj1 E) :- mam/is-evctx E.
mam/is-evctx (mam/evctx/prj2 E) :- mam/is-evctx E.
