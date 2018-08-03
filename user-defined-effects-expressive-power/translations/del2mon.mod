module del2mon.

accumulate syntax.

del2mon/nat del/z mon/z.
del2mon/nat (del/s N) (mon/s N') :-
    del2mon/nat N N'.

del2mon/label (del/lbl N) (mon/lbl N') :-
    del2mon/nat N N'.

del2mon/value del/unit mon/unit.
del2mon/value (del/pair V1 V2) (mon/pair V1' V2') :-
    del2mon/value V1 V1',
    del2mon/value V2 V2'.
del2mon/value (del/inj L V) (mon/inj L' V') :-
    del2mon/label L L',
    del2mon/value V V'.
del2mon/value (del/thunk M) (mon/thunk M') :-
    del2mon/comp M M'.

del2mon/comp (del/ret V) (mon/ret V') :-
    del2mon/value V V'.
del2mon/comp (del/fun M) (mon/fun M') :-
    pi x\ pi x'\
        del2mon/value x x' =>
        del2mon/comp (M x) (M' x').
del2mon/comp (del/split V M) (mon/split V' M') :-
    del2mon/value V V',
    pi x1\ pi x2\ pi x1'\ pi x2'\
        del2mon/value x1 x1' =>
        del2mon/value x2 x2' =>
        del2mon/comp (M x1 x2) (M' x1' x2').
del2mon/comp (del/case V Ms) (mon/case V' Ms') :-
    del2mon/value V V',
    del2mon/cases Ms Ms'.
del2mon/comp (del/force V) (mon/force V') :-
    del2mon/value V V'.
del2mon/comp (del/bind M N) (mon/bind M' N') :-
    del2mon/comp M M',
    pi x\ pi x'\
        del2mon/value x x' =>
        del2mon/comp (N x) (N' x').
del2mon/comp (del/app M V) (mon/app M' V') :-
    del2mon/comp M M',
    del2mon/value V V'.
del2mon/comp (del/comppair M1 M2) (mon/comppair M1' M2') :-
    del2mon/comp M1 M1',
    del2mon/comp M2 M2'.
del2mon/comp (del/prj1 M) (mon/prj1 M') :-
    del2mon/comp M M'.
del2mon/comp (del/prj2 M) (mon/prj2 M') :-
    del2mon/comp M M'.
del2mon/comp (del/reset M N) (mon/app (mon/reify M' (mon/mon (x\ mon/fun c\ mon/app (mon/force c) x) (m\ f\ mon/fun c\ mon/app (mon/force m) (mon/thunk (mon/fun y\ mon/app (mon/app (mon/force f) y) c))))) (mon/thunk (mon/fun N'))) :-
    del2mon/comp M M',
    pi x\ pi x'\
        del2mon/value x x' =>
        del2mon/comp (N x) (N' x').
del2mon/comp (del/shift M) (mon/reflect (mon/fun M')) :-
    pi k\ pi k'\
        del2mon/value k k' =>
        del2mon/comp (M k) (M' k').

del2mon/cases del/cases/nil mon/cases/nil.
del2mon/cases (del/cases/cons Ms L M) (mon/cases/cons Ms' L' M') :-
    del2mon/cases Ms Ms',
    del2mon/label L L',
    pi x\ pi x'\
        del2mon/value x x' =>
        del2mon/comp (M x) (M' x').

del2mon/evctx del/hole mon/hole.
del2mon/evctx (del/evctx/bind E N) (mon/evctx/bind E' N') :-
    del2mon/evctx E E',
    pi x\ pi x'\
        del2mon/value x x' =>
        del2mon/comp (N x) (N' x').
del2mon/evctx (del/evctx/app E V) (mon/evctx/app E' V') :-
    del2mon/evctx E E',
    del2mon/value V V'.
del2mon/evctx (del/evctx/prj1 E) (mon/evctx/prj1 E') :-
    del2mon/evctx E E'.
del2mon/evctx (del/evctx/prj2 E) (mon/evctx/prj2 E') :-
    del2mon/evctx E E'.
del2mon/evctx (del/evctx/reset E N) (mon/evctx/app (mon/evctx/reify E' (mon/mon (x\ mon/fun c\ mon/app (mon/force c) x) (m\ f\ mon/fun c\ mon/app (mon/force m) (mon/thunk (mon/fun y\ mon/app (mon/app (mon/force f) y) c))))) (mon/thunk (mon/fun N'))) :-
    del2mon/evctx E E',
    pi x\ pi x'\
        del2mon/value x x' =>
        del2mon/comp (N x) (N' x').

mon/is-evctx mon/hole.
mon/is-evctx (mon/evctx/bind E N) :- mon/is-evctx E.
mon/is-evctx (mon/evctx/app E V) :- mon/is-evctx E.
mon/is-evctx (mon/evctx/prj1 E) :- mon/is-evctx E.
mon/is-evctx (mon/evctx/prj2 E) :- mon/is-evctx E.
mon/is-evctx (mon/evctx/reify E T) :- mon/is-evctx E.

del2mon/eff del/empty mon/empty.
del2mon/eff (del/cons Eff C) (mon/cons Eff'
    (a\ mon/arrow (mon/u (mon/arrow a (C' a))) (C' a))
    (x\ mon/fun c\ mon/app (mon/force c) x)
    (m\ f\ mon/fun c\ mon/app (mon/force m) (mon/thunk (mon/fun y\ mon/app (mon/app (mon/force f) y) c)))
) :- 
    pi a\ pi a'\ del2mon/valty a a' => del2mon/compty (C a) (C' a'),
    del2mon/eff Eff Eff'.

del2mon/valty del/unitty mon/unitty.
del2mon/valty (del/prod A1 A2) (mon/prod A1' A2') :-
    del2mon/valty A1 A1',
    del2mon/valty A2 A2'.
del2mon/valty (del/sum As) (mon/sum As') :-
    del2mon/valtys As As'.
del2mon/valty (del/u C) (mon/u C') :-
    del2mon/compty C C'.

del2mon/compty (del/f Eff A) (mon/f Eff' A') :-
    del2mon/eff Eff Eff',
    del2mon/valty A A'.
del2mon/compty (del/arrow A C) (mon/arrow A' C') :-
    del2mon/valty A A',
    del2mon/compty C C'.
del2mon/compty (del/compprod C1 C2) (mon/compprod C1' C2') :-
    del2mon/compty C1 C1',
    del2mon/compty C2 C2'.

del2mon/valtys del/valtys/nil mon/valtys/nil.
del2mon/valtys (del/valtys/cons As L A) (mon/valtys/cons As' L' A') :-
    del2mon/valtys As As',
    del2mon/label L L',
    del2mon/valty A A'.

