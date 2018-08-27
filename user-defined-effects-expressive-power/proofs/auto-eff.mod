module auto-eff.
accumulate common.

eff/wf-eff eff/empty.

eff/wf-valty eff/unitty.
eff/wf-valty (eff/prod A1 A2) :-
    eff/wf-valty A1,
    eff/wf-valty A2.
eff/wf-valty (eff/sum As) :-
    eff/wf-valtys As.
eff/wf-valty (eff/u Eff C) :-
    eff/wf-compty Eff C.

eff/wf-valtys eff/valtys/nil.
eff/wf-valtys (eff/valtys/cons As L A) :-
    eff/wf-valtys As,
    eff/wf-valty A.

eff/wf-compty Eff (eff/f A) :-
    eff/wf-eff Eff,
    eff/wf-valty A.
eff/wf-compty Eff (eff/arrow A C) :-
    eff/wf-valty A,
    eff/wf-compty Eff C.
eff/wf-compty Eff (eff/compprod C1 C2) :-
    eff/wf-compty Eff C1,
    eff/wf-compty Eff C2.

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
eff/of-value' (eff/thunk M) (eff/u Eff C) :-
    eff/of-comp M Eff C.

eff/of-comp M Eff C :-
    eff/of-comp' M Eff C,
    eff/wf-compty Eff C.
eff/of-comp' (eff/ret V) Eff (eff/f A) :-
    eff/of-value V A.
eff/of-comp' (eff/fun M) Eff (eff/arrow A C) :-
    pi x\ (eff/of-value x A => eff/of-comp (M x) Eff C).
eff/of-comp' (eff/split V M) Eff C :-
    eff/of-value V (eff/prod A1 A2),
    pi x1\ pi x2\ (eff/of-value x1 A1 => eff/of-value x2 A2 => eff/of-comp (M x1 x2) Eff C).
eff/of-comp' (eff/case V Ms) Eff C :-
    eff/of-value V (eff/sum As),
    eff/of-cases Ms Eff As C.
eff/of-comp' (eff/force V) Eff C :- eff/of-value V (eff/u Eff C).
eff/of-comp' (eff/bind M N) Eff C :-
    eff/of-comp M Eff (eff/f A),
    pi x\ (eff/of-value x A => eff/of-comp (N x) Eff C).
eff/of-comp' (eff/app M V) Eff C :-
    eff/of-comp M Eff (eff/arrow A C),
    eff/of-value V A.
eff/of-comp' (eff/comppair M1 M2) Eff (eff/compprod C1 C2) :-
    eff/of-comp M1 Eff C1,
    eff/of-comp M2 Eff C2.
eff/of-comp' (eff/prj1 M) Eff C1 :-
    eff/of-comp M Eff (eff/compprod C1 C2).
eff/of-comp' (eff/prj2 M) Eff C2 :-
    eff/of-comp M Eff (eff/compprod C1 C2).

eff/of-cases Ms Eff As C :-
    eff/of-cases' Ms Eff As C,
    eff/wf-valtys As,
    eff/wf-compty Eff C.
eff/of-cases' eff/cases/nil Eff eff/valtys/nil C.
eff/of-cases' (eff/cases/cons Ms L M) Eff (eff/valtys/cons As L A) C :-
    eff/of-cases Ms Eff As C,
    pi x\ (eff/of-value x A => eff/of-comp (M x) Eff C).

eff/of-evctx E Eff1 C1 Eff2 C2 :-
    eff/of-evctx' E Eff1 C1 Eff2 C2,
    eff/wf-compty Eff1 C1,
    eff/wf-compty Eff2 C2.
eff/of-evctx' eff/hole Eff C Eff C.
eff/of-evctx' (eff/evctx/bind E N) Eff1 C1 Eff2 C2 :-
    eff/of-evctx E Eff1 C1 Eff2 (eff/f A),
    pi x\ (eff/of-value x A => eff/of-comp (N x) Eff2 C2).
eff/of-evctx' (eff/evctx/app E V) Eff1 C1 Eff2 C2 :-
    eff/of-evctx E Eff1 C1 Eff2 (eff/arrow A C2),
    eff/of-value V A.
eff/of-evctx' (eff/evctx/prj1 E) Eff1 C Eff2 C1 :-
    eff/of-evctx E Eff1 C Eff2 (eff/compprod C1 C2).
eff/of-evctx' (eff/evctx/prj2 E) Eff1 C Eff2 C2 :-
    eff/of-evctx E Eff1 C Eff2 (eff/compprod C1 C2).

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
