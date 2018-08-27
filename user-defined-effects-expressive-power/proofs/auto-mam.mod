module auto-mam.
accumulate common.

mam/wf-eff mam/empty.

mam/wf-valty mam/unitty.
mam/wf-valty (mam/prod A1 A2) :-
    mam/wf-valty A1,
    mam/wf-valty A2.
mam/wf-valty (mam/sum As) :-
    mam/wf-valtys As.
mam/wf-valty (mam/u Eff C) :-
    mam/wf-compty Eff C.

mam/wf-valtys mam/valtys/nil.
mam/wf-valtys (mam/valtys/cons As L A) :-
    mam/wf-valtys As,
    mam/wf-valty A.

mam/wf-compty Eff (mam/f A) :-
    mam/wf-eff Eff,
    mam/wf-valty A.
mam/wf-compty Eff (mam/arrow A C) :-
    mam/wf-valty A,
    mam/wf-compty Eff C.
mam/wf-compty Eff (mam/compprod C1 C2) :-
    mam/wf-compty Eff C1,
    mam/wf-compty Eff C2.

mam/of-value V A :-
    mam/of-value' V A,
    mam/wf-valty A.
mam/of-value' mam/unit mam/unitty.
mam/of-value' (mam/pair V1 V2) (mam/prod A1 A2) :-
    mam/of-value V1 A1,
    mam/of-value V2 A2.
mam/of-value' (mam/inj L V) (mam/sum As) :-
    mam/of-value V A,
    mam/valtys/get As L A.
mam/of-value' (mam/thunk M) (mam/u Eff C) :-
    mam/of-comp M Eff C.

mam/of-comp M Eff C :-
    mam/of-comp' M Eff C,
    mam/wf-compty Eff C.
mam/of-comp' (mam/ret V) Eff (mam/f A) :-
    mam/of-value V A.
mam/of-comp' (mam/fun M) Eff (mam/arrow A C) :-
    pi x\ (mam/of-value x A => mam/of-comp (M x) Eff C).
mam/of-comp' (mam/split V M) Eff C :-
    mam/of-value V (mam/prod A1 A2),
    pi x1\ pi x2\ (mam/of-value x1 A1 => mam/of-value x2 A2 => mam/of-comp (M x1 x2) Eff C).
mam/of-comp' (mam/case V Ms) Eff C :-
    mam/of-value V (mam/sum As),
    mam/of-cases Ms Eff As C.
mam/of-comp' (mam/force V) Eff C :- mam/of-value V (mam/u Eff C).
mam/of-comp' (mam/bind M N) Eff C :-
    mam/of-comp M Eff (mam/f A),
    pi x\ (mam/of-value x A => mam/of-comp (N x) Eff C).
mam/of-comp' (mam/app M V) Eff C :-
    mam/of-comp M Eff (mam/arrow A C),
    mam/of-value V A.
mam/of-comp' (mam/comppair M1 M2) Eff (mam/compprod C1 C2) :-
    mam/of-comp M1 Eff C1,
    mam/of-comp M2 Eff C2.
mam/of-comp' (mam/prj1 M) Eff C1 :-
    mam/of-comp M Eff (mam/compprod C1 C2).
mam/of-comp' (mam/prj2 M) Eff C2 :-
    mam/of-comp M Eff (mam/compprod C1 C2).

mam/of-cases Ms Eff As C :-
    mam/of-cases' Ms Eff As C,
    mam/wf-valtys As,
    mam/wf-compty Eff C.
mam/of-cases' mam/cases/nil Eff mam/valtys/nil C.
mam/of-cases' (mam/cases/cons Ms L M) Eff (mam/valtys/cons As L A) C :-
    mam/of-cases Ms Eff As C,
    pi x\ (mam/of-value x A => mam/of-comp (M x) Eff C).

mam/of-evctx E Eff1 C1 Eff2 C2 :-
    mam/of-evctx' E Eff1 C1 Eff2 C2,
    mam/wf-compty Eff1 C1,
    mam/wf-compty Eff2 C2.
mam/of-evctx' mam/hole Eff C Eff C.
mam/of-evctx' (mam/evctx/bind E N) Eff1 C1 Eff2 C2 :-
    mam/of-evctx E Eff1 C1 Eff2 (mam/f A),
    pi x\ (mam/of-value x A => mam/of-comp (N x) Eff2 C2).
mam/of-evctx' (mam/evctx/app E V) Eff1 C1 Eff2 C2 :-
    mam/of-evctx E Eff1 C1 Eff2 (mam/arrow A C2),
    mam/of-value V A.
mam/of-evctx' (mam/evctx/prj1 E) Eff1 C Eff2 C1 :-
    mam/of-evctx E Eff1 C Eff2 (mam/compprod C1 C2).
mam/of-evctx' (mam/evctx/prj2 E) Eff1 C Eff2 C2 :-
    mam/of-evctx E Eff1 C Eff2 (mam/compprod C1 C2).

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
