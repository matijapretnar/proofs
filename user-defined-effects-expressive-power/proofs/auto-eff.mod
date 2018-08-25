module auto-eff.
accumulate common.

eff/eff-kind C Eff :-
    eff/eff-kind' C Eff,
    eff/wf-compty C,
    eff/wf-eff Eff.
eff/eff-kind' (eff/f Eff A) Eff.
eff/eff-kind' (eff/arrow _ C) Eff :- eff/eff-kind C Eff.
eff/eff-kind' (eff/compprod C1 C2) Eff :-
    eff/eff-kind C1 Eff,
    eff/eff-kind C2 Eff.

eff/wf-eff eff/empty.

eff/wf-valty eff/unitty.
eff/wf-valty (eff/prod A1 A2) :-
    eff/wf-valty A1,
    eff/wf-valty A2.
eff/wf-valty (eff/sum As) :-
    eff/wf-valtys As.
eff/wf-valty (eff/u C) :-
    eff/wf-compty C.

eff/wf-valtys eff/valtys/nil.
eff/wf-valtys (eff/valtys/cons As L A) :-
    eff/wf-valtys As,
    eff/wf-valty A.

eff/wf-compty (eff/f Eff A) :-
    eff/wf-eff Eff,
    eff/wf-valty A.
eff/wf-compty (eff/arrow A C) :-
    eff/wf-valty A,
    eff/wf-compty C.
eff/wf-compty (eff/compprod C1 C2) :-
    eff/wf-compty C1,
    eff/wf-compty C2.

eff/of-value V A :-
    eff/of-value' V A,
    eff/wf-valty A.
eff/of-value' eff/unit eff/unitty.
eff/of-value' (eff/pair V1 V2) (eff/prod A1 A2) :-
    eff/of-value V1 A1,
    eff/of-value V2 A2.
eff/of-value' (eff/inj L V) (eff/sum As) :-
    eff/of-value V A,
    eff/valtys/get As L A.
eff/of-value' (eff/thunk M) (eff/u C) :- eff/of-comp M C.

eff/of-comp M C :-
    eff/of-comp' M C,
    eff/wf-compty C.
eff/of-comp' (eff/ret V) (eff/f Eff A) :-
    eff/of-value V A.
eff/of-comp' (eff/fun M) (eff/arrow A C) :-
    pi x\ (eff/of-value x A => eff/of-comp (M x) C).
eff/of-comp' (eff/split V M) C :-
    eff/of-value V (eff/prod A1 A2),
    pi x1\ pi x2\ (eff/of-value x1 A1 => eff/of-value x2 A2 => eff/of-comp (M x1 x2) C).
eff/of-comp' (eff/case V Ms) C :-
    eff/of-value V (eff/sum As),
    eff/of-cases Ms As C.
eff/of-comp' (eff/force V) C :- eff/of-value V (eff/u C).
eff/of-comp' (eff/bind M N) C :-
    eff/eff-kind C Eff,
    eff/of-comp M (eff/f Eff A),
    pi x\ (eff/of-value x A => eff/of-comp (N x) C).
eff/of-comp' (eff/app M V) C :-
    eff/of-comp M (eff/arrow A C),
    eff/of-value V A.
eff/of-comp' (eff/comppair M1 M2) (eff/compprod C1 C2) :-
    eff/of-comp M1 C1,
    eff/of-comp M2 C2.
eff/of-comp' (eff/prj1 M) C1 :-
    eff/eff-kind C1 Eff,
    eff/eff-kind C2 Eff,
    eff/of-comp M (eff/compprod C1 C2).
eff/of-comp' (eff/prj2 M) C2 :-
    eff/eff-kind C1 Eff,
    eff/eff-kind C2 Eff,
    eff/of-comp M (eff/compprod C1 C2).

eff/of-cases Ms As C :-
    eff/of-cases' Ms As C,
    eff/wf-valtys As,
    eff/wf-compty C.
eff/of-cases' eff/cases/nil eff/valtys/nil C.
eff/of-cases' (eff/cases/cons Ms L M) (eff/valtys/cons As L A) C :-
    eff/of-cases Ms As C,
    pi x\ (eff/of-value x A => eff/of-comp (M x) C).

eff/of-evctx E C1 C2 :-
    eff/of-evctx' E C1 C2,
    eff/wf-compty C1,
    eff/wf-compty C2.
eff/of-evctx' eff/hole C C.
eff/of-evctx' (eff/evctx/bind E N) C1 C2 :-
    eff/eff-kind C2 Eff,
    eff/of-evctx E C1 (eff/f Eff A),
    pi x\ (eff/of-value x A => eff/of-comp (N x) C2).
eff/of-evctx' (eff/evctx/app E V) C1 C2 :-
    eff/of-evctx E C1 (eff/arrow A C2),
    eff/of-value V A.
eff/of-evctx' (eff/evctx/prj1 E) C C1 :-
    eff/eff-kind C1 Eff,
    eff/eff-kind C2 Eff,
    eff/of-evctx E C (eff/compprod C1 C2).
eff/of-evctx' (eff/evctx/prj2 E) C C2 :-
    eff/eff-kind C1 Eff,
    eff/eff-kind C2 Eff,
    eff/of-evctx E C (eff/compprod C1 C2).

eff/valtys/get (eff/valtys/cons As L A) L A.
eff/valtys/get (eff/valtys/cons As L' _) L A :-
    label-apart L L',
    eff/valtys/get As L A.

eff/get-case (eff/cases/cons Ms L M) L M.
eff/get-case (eff/cases/cons Ms L' _) L M :-
    label-apart L L',
    eff/get-case Ms L M.

eff/reduce (eff/split (eff/pair V1 V2) M) (M V1 V2).
eff/reduce (eff/case (eff/inj L V) Ms) (M V) :-
    eff/get-case Ms L M.
eff/reduce (eff/force (eff/thunk M)) M.
eff/reduce (eff/bind (eff/ret V) M) (M V).
eff/reduce (eff/app (eff/fun M) V) (M V).
eff/reduce (eff/prj1 (eff/comppair M1 _)) M1.
eff/reduce (eff/prj2 (eff/comppair _ M2)) M2.

eff/plug eff/hole M M.
eff/plug (eff/evctx/bind E N) M (eff/bind EM N) :-
    eff/plug E M EM.
eff/plug (eff/evctx/app E V) M (eff/app EM V) :-
    eff/plug E M EM.
eff/plug (eff/evctx/prj1 E) M (eff/prj1 EM) :-
    eff/plug E M EM.
eff/plug (eff/evctx/prj2 E) M (eff/prj2 EM) :-
    eff/plug E M EM.

eff/hoisting eff/hole.
eff/hoisting (eff/evctx/bind E _) :-
    eff/hoisting E.
eff/hoisting (eff/evctx/app E _) :-
    eff/hoisting E.
eff/hoisting (eff/evctx/prj1 E) :-
    eff/hoisting E.
eff/hoisting (eff/evctx/prj2 E) :-
    eff/hoisting E.

eff/step M M' :-
    eff/plug E R M,
    eff/reduce R R',
    eff/plug E R' M'.

eff/progresses (eff/ret _) _.
eff/progresses (eff/fun _) _.
eff/progresses (eff/comppair M1 M2) _ :-
    eff/progresses M1 _,
    eff/progresses M2 _.
eff/progresses M _ :-
    eff/step M _.

eff/is-evctx eff/hole.
eff/is-evctx (eff/evctx/bind E N) :- eff/is-evctx E.
eff/is-evctx (eff/evctx/app E V) :- eff/is-evctx E.
eff/is-evctx (eff/evctx/prj1 E) :- eff/is-evctx E.
eff/is-evctx (eff/evctx/prj2 E) :- eff/is-evctx E.
