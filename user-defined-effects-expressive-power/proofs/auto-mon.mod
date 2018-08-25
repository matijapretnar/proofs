module auto-mon.
accumulate common.

mon/eff-kind C Eff :-
    mon/eff-kind' C Eff,
    mon/wf-compty C,
    mon/wf-eff Eff.
mon/eff-kind' (mon/f Eff A) Eff.
mon/eff-kind' (mon/arrow _ C) Eff :- mon/eff-kind C Eff.
mon/eff-kind' (mon/compprod C1 C2) Eff :-
    mon/eff-kind C1 Eff,
    mon/eff-kind C2 Eff.

mon/wf-eff mon/empty.

mon/wf-valty mon/unitty.
mon/wf-valty (mon/prod A1 A2) :-
    mon/wf-valty A1,
    mon/wf-valty A2.
mon/wf-valty (mon/sum As) :-
    mon/wf-valtys As.
mon/wf-valty (mon/u C) :-
    mon/wf-compty C.

mon/wf-valtys mon/valtys/nil.
mon/wf-valtys (mon/valtys/cons As L A) :-
    mon/wf-valtys As,
    mon/wf-valty A.

mon/wf-compty (mon/f Eff A) :-
    mon/wf-eff Eff,
    mon/wf-valty A.
mon/wf-compty (mon/arrow A C) :-
    mon/wf-valty A,
    mon/wf-compty C.
mon/wf-compty (mon/compprod C1 C2) :-
    mon/wf-compty C1,
    mon/wf-compty C2.

mon/of-value V A :-
    mon/of-value' V A,
    mon/wf-valty A.
mon/of-value' mon/unit mon/unitty.
mon/of-value' (mon/pair V1 V2) (mon/prod A1 A2) :-
    mon/of-value V1 A1,
    mon/of-value V2 A2.
mon/of-value' (mon/inj L V) (mon/sum As) :-
    mon/of-value V A,
    mon/valtys/get As L A.
mon/of-value' (mon/thunk M) (mon/u C) :- mon/of-comp M C.

mon/of-comp M C :-
    mon/of-comp' M C,
    mon/wf-compty C.
mon/of-comp' (mon/ret V) (mon/f Eff A) :-
    mon/of-value V A.
mon/of-comp' (mon/fun M) (mon/arrow A C) :-
    pi x\ (mon/of-value x A => mon/of-comp (M x) C).
mon/of-comp' (mon/split V M) C :-
    mon/of-value V (mon/prod A1 A2),
    pi x1\ pi x2\ (mon/of-value x1 A1 => mon/of-value x2 A2 => mon/of-comp (M x1 x2) C).
mon/of-comp' (mon/case V Ms) C :-
    mon/of-value V (mon/sum As),
    mon/of-cases Ms As C.
mon/of-comp' (mon/force V) C :- mon/of-value V (mon/u C).
mon/of-comp' (mon/bind M N) C :-
    mon/eff-kind C Eff,
    mon/of-comp M (mon/f Eff A),
    pi x\ (mon/of-value x A => mon/of-comp (N x) C).
mon/of-comp' (mon/app M V) C :-
    mon/of-comp M (mon/arrow A C),
    mon/of-value V A.
mon/of-comp' (mon/comppair M1 M2) (mon/compprod C1 C2) :-
    mon/of-comp M1 C1,
    mon/of-comp M2 C2.
mon/of-comp' (mon/prj1 M) C1 :-
    mon/eff-kind C1 Eff,
    mon/eff-kind C2 Eff,
    mon/of-comp M (mon/compprod C1 C2).
mon/of-comp' (mon/prj2 M) C2 :-
    mon/eff-kind C1 Eff,
    mon/eff-kind C2 Eff,
    mon/of-comp M (mon/compprod C1 C2).

mon/of-cases Ms As C :-
    mon/of-cases' Ms As C,
    mon/wf-valtys As,
    mon/wf-compty C.
mon/of-cases' mon/cases/nil mon/valtys/nil C.
mon/of-cases' (mon/cases/cons Ms L M) (mon/valtys/cons As L A) C :-
    mon/of-cases Ms As C,
    pi x\ (mon/of-value x A => mon/of-comp (M x) C).

mon/of-evctx E C1 C2 :-
    mon/of-evctx' E C1 C2,
    mon/wf-compty C1,
    mon/wf-compty C2.
mon/of-evctx' mon/hole C C.
mon/of-evctx' (mon/evctx/bind E N) C1 C2 :-
    mon/eff-kind C2 Eff,
    mon/of-evctx E C1 (mon/f Eff A),
    pi x\ (mon/of-value x A => mon/of-comp (N x) C2).
mon/of-evctx' (mon/evctx/app E V) C1 C2 :-
    mon/of-evctx E C1 (mon/arrow A C2),
    mon/of-value V A.
mon/of-evctx' (mon/evctx/prj1 E) C C1 :-
    mon/eff-kind C1 Eff,
    mon/eff-kind C2 Eff,
    mon/of-evctx E C (mon/compprod C1 C2).
mon/of-evctx' (mon/evctx/prj2 E) C C2 :-
    mon/eff-kind C1 Eff,
    mon/eff-kind C2 Eff,
    mon/of-evctx E C (mon/compprod C1 C2).

mon/valtys/get (mon/valtys/cons As L A) L A.
mon/valtys/get (mon/valtys/cons As L' _) L A :-
    label-apart L L',
    mon/valtys/get As L A.

mon/get-case (mon/cases/cons Ms L M) L M.
mon/get-case (mon/cases/cons Ms L' _) L M :-
    label-apart L L',
    mon/get-case Ms L M.

mon/reduce (mon/split (mon/pair V1 V2) M) (M V1 V2).
mon/reduce (mon/case (mon/inj L V) Ms) (M V) :-
    mon/get-case Ms L M.
mon/reduce (mon/force (mon/thunk M)) M.
mon/reduce (mon/bind (mon/ret V) M) (M V).
mon/reduce (mon/app (mon/fun M) V) (M V).
mon/reduce (mon/prj1 (mon/comppair M1 _)) M1.
mon/reduce (mon/prj2 (mon/comppair _ M2)) M2.

mon/plug mon/hole M M.
mon/plug (mon/evctx/bind E N) M (mon/bind EM N) :-
    mon/plug E M EM.
mon/plug (mon/evctx/app E V) M (mon/app EM V) :-
    mon/plug E M EM.
mon/plug (mon/evctx/prj1 E) M (mon/prj1 EM) :-
    mon/plug E M EM.
mon/plug (mon/evctx/prj2 E) M (mon/prj2 EM) :-
    mon/plug E M EM.

mon/hoisting mon/hole.
mon/hoisting (mon/evctx/bind E _) :-
    mon/hoisting E.
mon/hoisting (mon/evctx/app E _) :-
    mon/hoisting E.
mon/hoisting (mon/evctx/prj1 E) :-
    mon/hoisting E.
mon/hoisting (mon/evctx/prj2 E) :-
    mon/hoisting E.

mon/step M M' :-
    mon/plug E R M,
    mon/reduce R R',
    mon/plug E R' M'.

mon/progresses (mon/ret _) _.
mon/progresses (mon/fun _) _.
mon/progresses (mon/comppair M1 M2) _ :-
    mon/progresses M1 _,
    mon/progresses M2 _.
mon/progresses M _ :-
    mon/step M _.

mon/is-evctx mon/hole.
mon/is-evctx (mon/evctx/bind E N) :- mon/is-evctx E.
mon/is-evctx (mon/evctx/app E V) :- mon/is-evctx E.
mon/is-evctx (mon/evctx/prj1 E) :- mon/is-evctx E.
mon/is-evctx (mon/evctx/prj2 E) :- mon/is-evctx E.
