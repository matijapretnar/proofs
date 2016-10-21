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
del2mon/evctx (del/evctx/reset E N) (mon/evctx/app (mon/evctx/reify E' (mon/mon (x\ mon/fun c\ mon/app (mon/force c) x) (m\ f\ mon/fun c\ mon/app (mon/force m) (mon/thunk (mon/fun y\ mon/app (mon/app (mon/force f) y) c))))) (mon/thunk (mon/fun N'))) :-
    del2mon/evctx E E',
    pi x\ pi x'\
        del2mon/value x x' =>
        del2mon/comp (N x) (N' x').

mon/is-evctx mon/hole.
mon/is-evctx (mon/evctx/bind E N) :- mon/is-evctx E.
mon/is-evctx (mon/evctx/app E V) :- mon/is-evctx E.
mon/is-evctx (mon/evctx/reify E T) :- mon/is-evctx E.
