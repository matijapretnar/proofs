module auto-xxx.
accumulate common.

xxx/wf-eff xxx/empty.

xxx/wf-valty xxx/unitty.
xxx/wf-valty (xxx/prod A1 A2) :-
    xxx/wf-valty A1,
    xxx/wf-valty A2.
xxx/wf-valty (xxx/sum As) :-
    xxx/wf-valtys As.
xxx/wf-valty (xxx/u Eff C) :-
    xxx/wf-compty Eff C.

xxx/wf-valtys xxx/valtys/nil.
xxx/wf-valtys (xxx/valtys/cons As L A) :-
    xxx/wf-valtys As,
    xxx/wf-valty A.

xxx/wf-compty Eff (xxx/f A) :-
    xxx/wf-eff Eff,
    xxx/wf-valty A.
xxx/wf-compty Eff (xxx/arrow A C) :-
    xxx/wf-valty A,
    xxx/wf-compty Eff C.
xxx/wf-compty Eff (xxx/compprod C1 C2) :-
    xxx/wf-compty Eff C1,
    xxx/wf-compty Eff C2.

xxx/of-value V A :-
    xxx/of-value' V A,
    xxx/wf-valty A.
xxx/of-value' xxx/unit xxx/unitty.
xxx/of-value' (xxx/pair V1 V2) (xxx/prod A1 A2) :-
    xxx/of-value V1 A1,
    xxx/of-value V2 A2.
xxx/of-value' (xxx/inj L V) (xxx/sum As) :-
    xxx/of-value V A,
    xxx/valtys/get As L A.
xxx/of-value' (xxx/thunk M) (xxx/u Eff C) :-
    xxx/of-comp M Eff C.

xxx/of-comp M Eff C :-
    xxx/of-comp' M Eff C,
    xxx/wf-compty Eff C.
xxx/of-comp' (xxx/ret V) Eff (xxx/f A) :-
    xxx/of-value V A.
xxx/of-comp' (xxx/fun M) Eff (xxx/arrow A C) :-
    pi x\ (xxx/of-value x A => xxx/of-comp (M x) Eff C).
xxx/of-comp' (xxx/split V M) Eff C :-
    xxx/of-value V (xxx/prod A1 A2),
    pi x1\ pi x2\ (xxx/of-value x1 A1 => xxx/of-value x2 A2 => xxx/of-comp (M x1 x2) Eff C).
xxx/of-comp' (xxx/case V Ms) Eff C :-
    xxx/of-value V (xxx/sum As),
    xxx/of-cases Ms Eff As C.
xxx/of-comp' (xxx/force V) Eff C :- xxx/of-value V (xxx/u Eff C).
xxx/of-comp' (xxx/bind M N) Eff C :-
    xxx/of-comp M Eff (xxx/f A),
    pi x\ (xxx/of-value x A => xxx/of-comp (N x) Eff C).
xxx/of-comp' (xxx/app M V) Eff C :-
    xxx/of-comp M Eff (xxx/arrow A C),
    xxx/of-value V A.
xxx/of-comp' (xxx/comppair M1 M2) Eff (xxx/compprod C1 C2) :-
    xxx/of-comp M1 Eff C1,
    xxx/of-comp M2 Eff C2.
xxx/of-comp' (xxx/prj1 M) Eff C1 :-
    xxx/of-comp M Eff (xxx/compprod C1 C2).
xxx/of-comp' (xxx/prj2 M) Eff C2 :-
    xxx/of-comp M Eff (xxx/compprod C1 C2).

xxx/of-cases Ms Eff As C :-
    xxx/of-cases' Ms Eff As C,
    xxx/wf-valtys As,
    xxx/wf-compty Eff C.
xxx/of-cases' xxx/cases/nil Eff xxx/valtys/nil C.
xxx/of-cases' (xxx/cases/cons Ms L M) Eff (xxx/valtys/cons As L A) C :-
    xxx/of-cases Ms Eff As C,
    pi x\ (xxx/of-value x A => xxx/of-comp (M x) Eff C).

xxx/of-evctx E Eff1 C1 Eff2 C2 :-
    xxx/of-evctx' E Eff1 C1 Eff2 C2,
    xxx/wf-compty Eff1 C1,
    xxx/wf-compty Eff2 C2.
xxx/of-evctx' xxx/hole Eff C Eff C.
xxx/of-evctx' (xxx/evctx/bind E N) Eff1 C1 Eff2 C2 :-
    xxx/of-evctx E Eff1 C1 Eff2 (xxx/f A),
    pi x\ (xxx/of-value x A => xxx/of-comp (N x) Eff2 C2).
xxx/of-evctx' (xxx/evctx/app E V) Eff1 C1 Eff2 C2 :-
    xxx/of-evctx E Eff1 C1 Eff2 (xxx/arrow A C2),
    xxx/of-value V A.
xxx/of-evctx' (xxx/evctx/prj1 E) Eff1 C Eff2 C1 :-
    xxx/of-evctx E Eff1 C Eff2 (xxx/compprod C1 C2).
xxx/of-evctx' (xxx/evctx/prj2 E) Eff1 C Eff2 C2 :-
    xxx/of-evctx E Eff1 C Eff2 (xxx/compprod C1 C2).

xxx/valtys/get (xxx/valtys/cons As L A) L A.
xxx/valtys/get (xxx/valtys/cons As L' _) L A :-
    label-apart L L',
    xxx/valtys/get As L A.

xxx/get-case (xxx/cases/cons Ms L M) L M.
xxx/get-case (xxx/cases/cons Ms L' _) L M :-
    label-apart L L',
    xxx/get-case Ms L M.

xxx/reduce (xxx/split (xxx/pair V1 V2) M) (M V1 V2).
xxx/reduce (xxx/case (xxx/inj L V) Ms) (M V) :-
    xxx/get-case Ms L M.
xxx/reduce (xxx/force (xxx/thunk M)) M.
xxx/reduce (xxx/bind (xxx/ret V) M) (M V).
xxx/reduce (xxx/app (xxx/fun M) V) (M V).
xxx/reduce (xxx/prj1 (xxx/comppair M1 _)) M1.
xxx/reduce (xxx/prj2 (xxx/comppair _ M2)) M2.

xxx/plug xxx/hole M M.
xxx/plug (xxx/evctx/bind E N) M (xxx/bind EM N) :-
    xxx/plug E M EM.
xxx/plug (xxx/evctx/app E V) M (xxx/app EM V) :-
    xxx/plug E M EM.
xxx/plug (xxx/evctx/prj1 E) M (xxx/prj1 EM) :-
    xxx/plug E M EM.
xxx/plug (xxx/evctx/prj2 E) M (xxx/prj2 EM) :-
    xxx/plug E M EM.

xxx/hoisting xxx/hole.
xxx/hoisting (xxx/evctx/bind E _) :-
    xxx/hoisting E.
xxx/hoisting (xxx/evctx/app E _) :-
    xxx/hoisting E.
xxx/hoisting (xxx/evctx/prj1 E) :-
    xxx/hoisting E.
xxx/hoisting (xxx/evctx/prj2 E) :-
    xxx/hoisting E.

xxx/step M M' :-
    xxx/plug E R M,
    xxx/reduce R R',
    xxx/plug E R' M'.

xxx/progresses (xxx/ret _) _.
xxx/progresses (xxx/fun _) _.
xxx/progresses (xxx/comppair M1 M2) _ :-
    xxx/progresses M1 _,
    xxx/progresses M2 _.
xxx/progresses M _ :-
    xxx/step M _.

xxx/is-evctx xxx/hole.
xxx/is-evctx (xxx/evctx/bind E N) :- xxx/is-evctx E.
xxx/is-evctx (xxx/evctx/app E V) :- xxx/is-evctx E.
xxx/is-evctx (xxx/evctx/prj1 E) :- xxx/is-evctx E.
xxx/is-evctx (xxx/evctx/prj2 E) :- xxx/is-evctx E.
