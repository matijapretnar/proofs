module syntax.

mam/apart mam/z (mam/s _).
mam/apart (mam/s _) mam/z.
mam/apart (mam/s N) (mam/s N') :-
    mam/apart N N'.

mam/label/apart (mam/lbl N) (mam/lbl N') :-
    mam/apart N N'.

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

mam/of/value mam/unit mam/unitty.
mam/of/value (mam/pair V1 V2) (mam/prod A1 A2) :-
    mam/of/value V1 A1,
    mam/of/value V2 A2.
mam/of/value (mam/inj L V) (mam/sum As) :-
    mam/of/value V A,
    mam/valtys/get As L A.
mam/of/value (mam/thunk M) (mam/u C) :- mam/of/comp M C.

mam/of/comp (mam/ret V) (mam/f Eff A) :-
    mam/is-eff Eff,
    mam/of/value V A.
mam/of/comp (mam/fun M) (mam/arrow A C) :-
    mam/is-valty A,
    pi x\ (mam/of/value x A => mam/of/comp (M x) C).
mam/of/comp (mam/split V M) C :-
    mam/of/value V (mam/prod A1 A2),
    pi x1\ pi x2\ (mam/of/value x1 A1 => mam/of/value x2 A2 => mam/of/comp (M x1 x2) C).
mam/of/comp (mam/case V Ms) C :-
    mam/of/value V (mam/sum As),
    mam/of/cases Ms As C.
mam/of/comp (mam/force V) C :- mam/of/value V (mam/u C).
mam/of/comp (mam/bind M N) C :-
    mam/eff-kind C Eff,
    mam/of/comp M (mam/f Eff A),
    pi x\ (mam/of/value x A => mam/of/comp (N x) C).
mam/of/comp (mam/app M V) C :-
    mam/of/comp M (mam/arrow A C),
    mam/of/value V A.
mam/of/comp (mam/comppair M1 M2) (mam/compprod C1 C2) :-
    mam/of/comp M1 C1,
    mam/of/comp M2 C2.
mam/of/comp (mam/prj1 M) C1 :-
    mam/eff-kind C1 Eff,
    mam/eff-kind C2 Eff,
    mam/of/comp M (mam/compprod C1 C2).
mam/of/comp (mam/prj2 M) C2 :-
    mam/eff-kind C1 Eff,
    mam/eff-kind C2 Eff,
    mam/of/comp M (mam/compprod C1 C2).

mam/of/cases mam/cases/nil mam/valtys/nil C.
mam/of/cases (mam/cases/cons Ms L M) (mam/valtys/cons As L A) C :-
    mam/of/cases Ms As C,
    pi x\ (mam/of/value x A => mam/of/comp (M x) C).

mam/of/evctx mam/hole C C.
mam/of/evctx (mam/evctx/bind E N) C1 C2 :-
    mam/eff-kind C2 Eff,
    mam/of/evctx E C1 (mam/f Eff A),
    pi x\ (mam/of/value x A => mam/of/comp (N x) C2).
mam/of/evctx (mam/evctx/app E V) C1 C2 :-
    mam/of/evctx E C1 (mam/arrow A C2),
    mam/of/value V A.
mam/of/evctx (mam/evctx/prj1 E) C C1 :-
    mam/eff-kind C1 Eff,
    mam/eff-kind C2 Eff,
    mam/of/evctx E C (mam/compprod C1 C2).
mam/of/evctx (mam/evctx/prj2 E) C C2 :-
    mam/eff-kind C1 Eff,
    mam/eff-kind C2 Eff,
    mam/of/evctx E C (mam/compprod C1 C2).

mam/valtys/get (mam/valtys/cons As L A) L A.
mam/valtys/get (mam/valtys/cons As L' _) L A :-
    mam/label/apart L L',
    mam/valtys/get As L A.

mam/get-case (mam/cases/cons Ms L M) L M.
mam/get-case (mam/cases/cons Ms L' _) L M :-
    mam/label/apart L L',
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


mon/apart mon/z (mon/s _).
mon/apart (mon/s _) mon/z.
mon/apart (mon/s N) (mon/s N') :-
    mon/apart N N'.

mon/label/apart (mon/lbl N) (mon/lbl N') :-
    mon/apart N N'.

mon/eff-kind (mon/f Eff A) Eff :-
    mon/is-eff Eff.
mon/eff-kind (mon/arrow _ C) Eff :- mon/eff-kind C Eff.
mon/eff-kind (mon/compprod C1 C2) Eff :-
    mon/eff-kind C1 Eff,
    mon/eff-kind C2 Eff.

mon/is-eff mon/empty.

mon/is-valty mon/unitty.
mon/is-valty (mon/prod A1 A2) :-
    mon/is-valty A1,
    mon/is-valty A2.
mon/is-valty (mon/sum As) :-
    mon/is-valtys As.
mon/is-valty (mon/u C) :-
    mon/is-compty C.

mon/is-valtys mon/valtys/nil.
mon/is-valtys (mon/valtys/cons As L A) :-
    mon/is-valtys As,
    mon/is-valty A.

mon/is-compty (mon/f Eff A) :-
    mon/is-eff Eff,
    mon/is-valty A.
mon/is-compty (mon/arrow A C) :-
    mon/is-valty A,
    mon/is-compty C.
mon/is-compty (mon/compprod C1 C2) :-
    mon/is-compty C1,
    mon/is-compty C2.

mon/of/value mon/unit mon/unitty.
mon/of/value (mon/pair V1 V2) (mon/prod A1 A2) :-
    mon/of/value V1 A1,
    mon/of/value V2 A2.
mon/of/value (mon/inj L V) (mon/sum As) :-
    mon/of/value V A,
    mon/valtys/get As L A.
mon/of/value (mon/thunk M) (mon/u C) :- mon/of/comp M C.

mon/of/comp (mon/ret V) (mon/f Eff A) :-
    mon/is-eff Eff,
    mon/of/value V A.
mon/of/comp (mon/fun M) (mon/arrow A C) :-
    mon/is-valty A,
    pi x\ (mon/of/value x A => mon/of/comp (M x) C).
mon/of/comp (mon/split V M) C :-
    mon/of/value V (mon/prod A1 A2),
    pi x1\ pi x2\ (mon/of/value x1 A1 => mon/of/value x2 A2 => mon/of/comp (M x1 x2) C).
mon/of/comp (mon/case V Ms) C :-
    mon/of/value V (mon/sum As),
    mon/of/cases Ms As C.
mon/of/comp (mon/force V) C :- mon/of/value V (mon/u C).
mon/of/comp (mon/bind M N) C :-
    mon/eff-kind C Eff,
    mon/of/comp M (mon/f Eff A),
    pi x\ (mon/of/value x A => mon/of/comp (N x) C).
mon/of/comp (mon/app M V) C :-
    mon/of/comp M (mon/arrow A C),
    mon/of/value V A.
mon/of/comp (mon/comppair M1 M2) (mon/compprod C1 C2) :-
    mon/of/comp M1 C1,
    mon/of/comp M2 C2.
mon/of/comp (mon/prj1 M) C1 :-
    mon/eff-kind C1 Eff,
    mon/eff-kind C2 Eff,
    mon/of/comp M (mon/compprod C1 C2).
mon/of/comp (mon/prj2 M) C2 :-
    mon/eff-kind C1 Eff,
    mon/eff-kind C2 Eff,
    mon/of/comp M (mon/compprod C1 C2).

mon/of/cases mon/cases/nil mon/valtys/nil C.
mon/of/cases (mon/cases/cons Ms L M) (mon/valtys/cons As L A) C :-
    mon/of/cases Ms As C,
    pi x\ (mon/of/value x A => mon/of/comp (M x) C).

mon/of/evctx mon/hole C C.
mon/of/evctx (mon/evctx/bind E N) C1 C2 :-
    mon/eff-kind C2 Eff,
    mon/of/evctx E C1 (mon/f Eff A),
    pi x\ (mon/of/value x A => mon/of/comp (N x) C2).
mon/of/evctx (mon/evctx/app E V) C1 C2 :-
    mon/of/evctx E C1 (mon/arrow A C2),
    mon/of/value V A.
mon/of/evctx (mon/evctx/prj1 E) C C1 :-
    mon/eff-kind C1 Eff,
    mon/eff-kind C2 Eff,
    mon/of/evctx E C (mon/compprod C1 C2).
mon/of/evctx (mon/evctx/prj2 E) C C2 :-
    mon/eff-kind C1 Eff,
    mon/eff-kind C2 Eff,
    mon/of/evctx E C (mon/compprod C1 C2).

mon/valtys/get (mon/valtys/cons As L A) L A.
mon/valtys/get (mon/valtys/cons As L' _) L A :-
    mon/label/apart L L',
    mon/valtys/get As L A.

mon/get-case (mon/cases/cons Ms L M) L M.
mon/get-case (mon/cases/cons Ms L' _) L M :-
    mon/label/apart L L',
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


mon/is-eff (mon/cons Eff C _ _) :-
    mon/is-eff Eff,
    pi a\ mon/is-valty a => mon/is-compty (C a).

mon/plug (mon/evctx/reify E T) M (mon/reify EM T) :-
    mon/plug E M EM.

mon/reduce (mon/reify (mon/ret V) (mon/mon Nu _)) (Nu V).
mon/reduce (mon/reify ERN (mon/mon Nu Nb)) (Nb (mon/thunk N) (mon/thunk (mon/fun (x\ mon/reify (ER x) (mon/mon Nu Nb))))) :-
    mon/plug E (mon/reflect N) ERN,
    mon/hoisting E,
    pi x\ mon/plug E (mon/ret x) (ER x).

mon/of/monad (mon/mon Nu Nb) (mon/cons Eff C Nu Nb) :-
    pi a\ pi x\ (mon/is-valty a => mon/of/value x a => mon/of/comp (Nu x) (C a)),
    pi a\ pi b\ pi x\ pi k\ (mon/is-valty a => mon/is-valty b => mon/of/value x (mon/u (C a)) => mon/of/value k (mon/u (mon/arrow a (C b))) => mon/of/comp (Nb x k) (C b)).

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


del/apart del/z (del/s _).
del/apart (del/s _) del/z.
del/apart (del/s N) (del/s N') :-
    del/apart N N'.

del/label/apart (del/lbl N) (del/lbl N') :-
    del/apart N N'.

del/eff-kind (del/f Eff A) Eff :-
    del/is-eff Eff.
del/eff-kind (del/arrow _ C) Eff :- del/eff-kind C Eff.
del/eff-kind (del/compprod C1 C2) Eff :-
    del/eff-kind C1 Eff,
    del/eff-kind C2 Eff.

del/is-eff del/empty.

del/is-valty del/unitty.
del/is-valty (del/prod A1 A2) :-
    del/is-valty A1,
    del/is-valty A2.
del/is-valty (del/sum As) :-
    del/is-valtys As.
del/is-valty (del/u C) :-
    del/is-compty C.

del/is-valtys del/valtys/nil.
del/is-valtys (del/valtys/cons As L A) :-
    del/is-valtys As,
    del/is-valty A.

del/is-compty (del/f Eff A) :-
    del/is-eff Eff,
    del/is-valty A.
del/is-compty (del/arrow A C) :-
    del/is-valty A,
    del/is-compty C.
del/is-compty (del/compprod C1 C2) :-
    del/is-compty C1,
    del/is-compty C2.

del/of/value del/unit del/unitty.
del/of/value (del/pair V1 V2) (del/prod A1 A2) :-
    del/of/value V1 A1,
    del/of/value V2 A2.
del/of/value (del/inj L V) (del/sum As) :-
    del/of/value V A,
    del/valtys/get As L A.
del/of/value (del/thunk M) (del/u C) :- del/of/comp M C.

del/of/comp (del/ret V) (del/f Eff A) :-
    del/is-eff Eff,
    del/of/value V A.
del/of/comp (del/fun M) (del/arrow A C) :-
    del/is-valty A,
    pi x\ (del/of/value x A => del/of/comp (M x) C).
del/of/comp (del/split V M) C :-
    del/of/value V (del/prod A1 A2),
    pi x1\ pi x2\ (del/of/value x1 A1 => del/of/value x2 A2 => del/of/comp (M x1 x2) C).
del/of/comp (del/case V Ms) C :-
    del/of/value V (del/sum As),
    del/of/cases Ms As C.
del/of/comp (del/force V) C :- del/of/value V (del/u C).
del/of/comp (del/bind M N) C :-
    del/eff-kind C Eff,
    del/of/comp M (del/f Eff A),
    pi x\ (del/of/value x A => del/of/comp (N x) C).
del/of/comp (del/app M V) C :-
    del/of/comp M (del/arrow A C),
    del/of/value V A.
del/of/comp (del/comppair M1 M2) (del/compprod C1 C2) :-
    del/of/comp M1 C1,
    del/of/comp M2 C2.
del/of/comp (del/prj1 M) C1 :-
    del/eff-kind C1 Eff,
    del/eff-kind C2 Eff,
    del/of/comp M (del/compprod C1 C2).
del/of/comp (del/prj2 M) C2 :-
    del/eff-kind C1 Eff,
    del/eff-kind C2 Eff,
    del/of/comp M (del/compprod C1 C2).

del/of/cases del/cases/nil del/valtys/nil C.
del/of/cases (del/cases/cons Ms L M) (del/valtys/cons As L A) C :-
    del/of/cases Ms As C,
    pi x\ (del/of/value x A => del/of/comp (M x) C).

del/of/evctx del/hole C C.
del/of/evctx (del/evctx/bind E N) C1 C2 :-
    del/eff-kind C2 Eff,
    del/of/evctx E C1 (del/f Eff A),
    pi x\ (del/of/value x A => del/of/comp (N x) C2).
del/of/evctx (del/evctx/app E V) C1 C2 :-
    del/of/evctx E C1 (del/arrow A C2),
    del/of/value V A.
del/of/evctx (del/evctx/prj1 E) C C1 :-
    del/eff-kind C1 Eff,
    del/eff-kind C2 Eff,
    del/of/evctx E C (del/compprod C1 C2).
del/of/evctx (del/evctx/prj2 E) C C2 :-
    del/eff-kind C1 Eff,
    del/eff-kind C2 Eff,
    del/of/evctx E C (del/compprod C1 C2).

del/valtys/get (del/valtys/cons As L A) L A.
del/valtys/get (del/valtys/cons As L' _) L A :-
    del/label/apart L L',
    del/valtys/get As L A.

del/get-case (del/cases/cons Ms L M) L M.
del/get-case (del/cases/cons Ms L' _) L M :-
    del/label/apart L L',
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


del/is-eff (del/cons Eff C) :-
    del/is-eff Eff,
    del/is-compty C.

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
    del/is-valty A,
    del/eff-kind C Eff,
    pi k\ (del/of/value k (del/u (del/arrow A C)) => del/of/comp (M k) C).

del/of/evctx (del/evctx/reset E N) C D :-
    del/eff-kind D Eff,
    pi x\ (del/of/value x A => del/of/comp (N x) D),
    del/of/evctx E C (del/f (del/cons Eff D) A).


eff/apart eff/z (eff/s _).
eff/apart (eff/s _) eff/z.
eff/apart (eff/s N) (eff/s N') :-
    eff/apart N N'.

eff/label/apart (eff/lbl N) (eff/lbl N') :-
    eff/apart N N'.

eff/eff-kind (eff/f Eff A) Eff :-
    eff/is-eff Eff.
eff/eff-kind (eff/arrow _ C) Eff :- eff/eff-kind C Eff.
eff/eff-kind (eff/compprod C1 C2) Eff :-
    eff/eff-kind C1 Eff,
    eff/eff-kind C2 Eff.

eff/is-eff eff/empty.

eff/is-valty eff/unitty.
eff/is-valty (eff/prod A1 A2) :-
    eff/is-valty A1,
    eff/is-valty A2.
eff/is-valty (eff/sum As) :-
    eff/is-valtys As.
eff/is-valty (eff/u C) :-
    eff/is-compty C.

eff/is-valtys eff/valtys/nil.
eff/is-valtys (eff/valtys/cons As L A) :-
    eff/is-valtys As,
    eff/is-valty A.

eff/is-compty (eff/f Eff A) :-
    eff/is-eff Eff,
    eff/is-valty A.
eff/is-compty (eff/arrow A C) :-
    eff/is-valty A,
    eff/is-compty C.
eff/is-compty (eff/compprod C1 C2) :-
    eff/is-compty C1,
    eff/is-compty C2.

eff/of/value eff/unit eff/unitty.
eff/of/value (eff/pair V1 V2) (eff/prod A1 A2) :-
    eff/of/value V1 A1,
    eff/of/value V2 A2.
eff/of/value (eff/inj L V) (eff/sum As) :-
    eff/of/value V A,
    eff/valtys/get As L A.
eff/of/value (eff/thunk M) (eff/u C) :- eff/of/comp M C.

eff/of/comp (eff/ret V) (eff/f Eff A) :-
    eff/is-eff Eff,
    eff/of/value V A.
eff/of/comp (eff/fun M) (eff/arrow A C) :-
    eff/is-valty A,
    pi x\ (eff/of/value x A => eff/of/comp (M x) C).
eff/of/comp (eff/split V M) C :-
    eff/of/value V (eff/prod A1 A2),
    pi x1\ pi x2\ (eff/of/value x1 A1 => eff/of/value x2 A2 => eff/of/comp (M x1 x2) C).
eff/of/comp (eff/case V Ms) C :-
    eff/of/value V (eff/sum As),
    eff/of/cases Ms As C.
eff/of/comp (eff/force V) C :- eff/of/value V (eff/u C).
eff/of/comp (eff/bind M N) C :-
    eff/eff-kind C Eff,
    eff/of/comp M (eff/f Eff A),
    pi x\ (eff/of/value x A => eff/of/comp (N x) C).
eff/of/comp (eff/app M V) C :-
    eff/of/comp M (eff/arrow A C),
    eff/of/value V A.
eff/of/comp (eff/comppair M1 M2) (eff/compprod C1 C2) :-
    eff/of/comp M1 C1,
    eff/of/comp M2 C2.
eff/of/comp (eff/prj1 M) C1 :-
    eff/eff-kind C1 Eff,
    eff/eff-kind C2 Eff,
    eff/of/comp M (eff/compprod C1 C2).
eff/of/comp (eff/prj2 M) C2 :-
    eff/eff-kind C1 Eff,
    eff/eff-kind C2 Eff,
    eff/of/comp M (eff/compprod C1 C2).

eff/of/cases eff/cases/nil eff/valtys/nil C.
eff/of/cases (eff/cases/cons Ms L M) (eff/valtys/cons As L A) C :-
    eff/of/cases Ms As C,
    pi x\ (eff/of/value x A => eff/of/comp (M x) C).

eff/of/evctx eff/hole C C.
eff/of/evctx (eff/evctx/bind E N) C1 C2 :-
    eff/eff-kind C2 Eff,
    eff/of/evctx E C1 (eff/f Eff A),
    pi x\ (eff/of/value x A => eff/of/comp (N x) C2).
eff/of/evctx (eff/evctx/app E V) C1 C2 :-
    eff/of/evctx E C1 (eff/arrow A C2),
    eff/of/value V A.
eff/of/evctx (eff/evctx/prj1 E) C C1 :-
    eff/eff-kind C1 Eff,
    eff/eff-kind C2 Eff,
    eff/of/evctx E C (eff/compprod C1 C2).
eff/of/evctx (eff/evctx/prj2 E) C C2 :-
    eff/eff-kind C1 Eff,
    eff/eff-kind C2 Eff,
    eff/of/evctx E C (eff/compprod C1 C2).

eff/valtys/get (eff/valtys/cons As L A) L A.
eff/valtys/get (eff/valtys/cons As L' _) L A :-
    eff/label/apart L L',
    eff/valtys/get As L A.

eff/get-case (eff/cases/cons Ms L M) L M.
eff/get-case (eff/cases/cons Ms L' _) L M :-
    eff/label/apart L L',
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


eff/op/apart (eff/op N) (eff/op N') :-
    eff/apart N N'.

eff/op-sig (eff/cons _ Op A B) Op A B.
eff/op-sig (eff/cons Eff Op' _ _) Op A B :-
    eff/op/apart Op Op',
    eff/op-sig Eff Op A B.

eff/plug (eff/evctx/handle E H) M (eff/handle EM H) :-
    eff/plug E M EM.

eff/get-valcase (eff/valcase M) M.
eff/get-valcase (eff/opcase H _ _) M :-
    eff/get-valcase H M.

eff/get-opcase (eff/opcase H Op M) Op M.
eff/get-opcase (eff/opcase H Op' _) Op M :-
    eff/op/apart Op Op',
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
