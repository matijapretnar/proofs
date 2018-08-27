module auto-del.
accumulate common.

del/wf-eff del/empty.

del/wf-valty del/unitty.
del/wf-valty (del/prod A1 A2) :-
    del/wf-valty A1,
    del/wf-valty A2.
del/wf-valty (del/sum As) :-
    del/wf-valtys As.
del/wf-valty (del/u Eff C) :-
    del/wf-compty Eff C.

del/wf-valtys del/valtys/nil.
del/wf-valtys (del/valtys/cons As L A) :-
    del/wf-valtys As,
    del/wf-valty A.

del/wf-compty Eff (del/f A) :-
    del/wf-eff Eff,
    del/wf-valty A.
del/wf-compty Eff (del/arrow A C) :-
    del/wf-valty A,
    del/wf-compty Eff C.
del/wf-compty Eff (del/compprod C1 C2) :-
    del/wf-compty Eff C1,
    del/wf-compty Eff C2.

del/of-value V A :-
    del/of-value' V A,
    del/wf-valty A.
del/of-value' del/unit del/unitty.
del/of-value' (del/pair V1 V2) (del/prod A1 A2) :-
    del/of-value V1 A1,
    del/of-value V2 A2.
del/of-value' (del/inj L V) (del/sum As) :-
    del/of-value V A,
    del/valtys/get As L A.
del/of-value' (del/thunk M) (del/u Eff C) :-
    del/of-comp M Eff C.

del/of-comp M Eff C :-
    del/of-comp' M Eff C,
    del/wf-compty Eff C.
del/of-comp' (del/ret V) Eff (del/f A) :-
    del/of-value V A.
del/of-comp' (del/fun M) Eff (del/arrow A C) :-
    pi x\ (del/of-value x A => del/of-comp (M x) Eff C).
del/of-comp' (del/split V M) Eff C :-
    del/of-value V (del/prod A1 A2),
    pi x1\ pi x2\ (del/of-value x1 A1 => del/of-value x2 A2 => del/of-comp (M x1 x2) Eff C).
del/of-comp' (del/case V Ms) Eff C :-
    del/of-value V (del/sum As),
    del/of-cases Ms Eff As C.
del/of-comp' (del/force V) Eff C :- del/of-value V (del/u Eff C).
del/of-comp' (del/bind M N) Eff C :-
    del/of-comp M Eff (del/f A),
    pi x\ (del/of-value x A => del/of-comp (N x) Eff C).
del/of-comp' (del/app M V) Eff C :-
    del/of-comp M Eff (del/arrow A C),
    del/of-value V A.
del/of-comp' (del/comppair M1 M2) Eff (del/compprod C1 C2) :-
    del/of-comp M1 Eff C1,
    del/of-comp M2 Eff C2.
del/of-comp' (del/prj1 M) Eff C1 :-
    del/of-comp M Eff (del/compprod C1 C2).
del/of-comp' (del/prj2 M) Eff C2 :-
    del/of-comp M Eff (del/compprod C1 C2).

del/of-cases Ms Eff As C :-
    del/of-cases' Ms Eff As C,
    del/wf-valtys As,
    del/wf-compty Eff C.
del/of-cases' del/cases/nil Eff del/valtys/nil C.
del/of-cases' (del/cases/cons Ms L M) Eff (del/valtys/cons As L A) C :-
    del/of-cases Ms Eff As C,
    pi x\ (del/of-value x A => del/of-comp (M x) Eff C).

del/of-evctx E Eff1 C1 Eff2 C2 :-
    del/of-evctx' E Eff1 C1 Eff2 C2,
    del/wf-compty Eff1 C1,
    del/wf-compty Eff2 C2.
del/of-evctx' del/hole Eff C Eff C.
del/of-evctx' (del/evctx/bind E N) Eff1 C1 Eff2 C2 :-
    del/of-evctx E Eff1 C1 Eff2 (del/f A),
    pi x\ (del/of-value x A => del/of-comp (N x) Eff2 C2).
del/of-evctx' (del/evctx/app E V) Eff1 C1 Eff2 C2 :-
    del/of-evctx E Eff1 C1 Eff2 (del/arrow A C2),
    del/of-value V A.
del/of-evctx' (del/evctx/prj1 E) Eff1 C Eff2 C1 :-
    del/of-evctx E Eff1 C Eff2 (del/compprod C1 C2).
del/of-evctx' (del/evctx/prj2 E) Eff1 C Eff2 C2 :-
    del/of-evctx E Eff1 C Eff2 (del/compprod C1 C2).

del/valtys/get (del/valtys/cons As L A) L A.
del/valtys/get (del/valtys/cons As L' _) L A :-
    label-apart L L',
    del/valtys/get As L A.

del/get-case (del/cases/cons Ms L M) L M.
del/get-case (del/cases/cons Ms L' _) L M :-
    label-apart L L',
    del/get-case Ms L M.

del/reduce (del/split (del/pair V1 V2) M) (M V1 V2).
del/reduce (del/case (del/inj L V) Ms) (M V) :-
    del/get-case Ms L M.
del/reduce (del/force (del/thunk M)) M.
del/reduce (del/bind (del/ret V) M) (M V).
del/reduce (del/app (del/fun M) V) (M V).
del/reduce (del/prj1 (del/comppair M1 _)) M1.
del/reduce (del/prj2 (del/comppair _ M2)) M2.

del/plug del/hole M M.
del/plug (del/evctx/bind E N) M (del/bind EM N) :-
    del/plug E M EM.
del/plug (del/evctx/app E V) M (del/app EM V) :-
    del/plug E M EM.
del/plug (del/evctx/prj1 E) M (del/prj1 EM) :-
    del/plug E M EM.
del/plug (del/evctx/prj2 E) M (del/prj2 EM) :-
    del/plug E M EM.

del/hoisting del/hole.
del/hoisting (del/evctx/bind E _) :-
    del/hoisting E.
del/hoisting (del/evctx/app E _) :-
    del/hoisting E.
del/hoisting (del/evctx/prj1 E) :-
    del/hoisting E.
del/hoisting (del/evctx/prj2 E) :-
    del/hoisting E.

del/step M M' :-
    del/plug E R M,
    del/reduce R R',
    del/plug E R' M'.

del/progresses (del/ret _) _.
del/progresses (del/fun _) _.
del/progresses (del/comppair M1 M2) _ :-
    del/progresses M1 _,
    del/progresses M2 _.
del/progresses M _ :-
    del/step M _.

del/is-evctx del/hole.
del/is-evctx (del/evctx/bind E N) :- del/is-evctx E.
del/is-evctx (del/evctx/app E V) :- del/is-evctx E.
del/is-evctx (del/evctx/prj1 E) :- del/is-evctx E.
del/is-evctx (del/evctx/prj2 E) :- del/is-evctx E.
