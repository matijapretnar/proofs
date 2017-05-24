module eff2mon.

accumulate syntax.

eff2mon/nat eff/z mon/z.
eff2mon/nat (eff/s N) (mon/s N') :-
    eff2mon/nat N N'.

eff2mon/label (eff/lbl N) (mon/lbl N') :-
    eff2mon/nat N N'.

eff2mon/value eff/unit mon/unit.
eff2mon/value (eff/pair V1 V2) (mon/pair V1' V2') :-
    eff2mon/value V1 V1',
    eff2mon/value V2 V2'.
eff2mon/value (eff/inj L V) (mon/inj L' V') :-
    eff2mon/label L L',
    eff2mon/value V V'.
eff2mon/value (eff/thunk M) (mon/thunk M') :-
    eff2mon/comp M M'.

eff2mon/comp (eff/ret V) (mon/ret V') :-
    eff2mon/value V V'.
eff2mon/comp (eff/fun M) (mon/fun M') :-
    pi x\ pi x'\
        eff2mon/value x x' =>
        eff2mon/comp (M x) (M' x').
eff2mon/comp (eff/split V M) (mon/split V' M') :-
    eff2mon/value V V',
    pi x1\ pi x2\ pi x1'\ pi x2'\
        eff2mon/value x1 x1' =>
        eff2mon/value x2 x2' =>
        eff2mon/comp (M x1 x2) (M' x1' x2').
eff2mon/comp (eff/case V Ms) (mon/case V' Ms') :-
    eff2mon/value V V',
    eff2mon/cases Ms Ms'.
eff2mon/comp (eff/force V) (mon/force V') :-
    eff2mon/value V V'.
eff2mon/comp (eff/bind M N) (mon/bind M' N') :-
    eff2mon/comp M M',
    pi x\ pi x'\
        eff2mon/value x x' =>
        eff2mon/comp (N x) (N' x').
eff2mon/comp (eff/app M V) (mon/app M' V') :-
    eff2mon/comp M M',
    eff2mon/value V V'.
eff2mon/comp (eff/comppair M1 M2) (mon/comppair M1' M2') :-
    eff2mon/comp M1 M1',
    eff2mon/comp M2 M2'.
eff2mon/comp (eff/prj1 M) (mon/prj1 M') :-
    eff2mon/comp M M'.
eff2mon/comp (eff/prj2 M) (mon/prj2 M') :-
    eff2mon/comp M M'.
eff2mon/comp (eff/call (eff/op X) V)
    (mon/reflect (mon/fun k\ mon/fun h\ (mon/app (mon/force h) (mon/inj (mon/lbl X') (mon/pair V' (mon/thunk (mon/fun y\ (mon/app (mon/app (mon/force k) y) h)))))))) :-
    eff2mon/nat X X',
    eff2mon/value V V'.
eff2mon/comp (eff/handle M H) (mon/app (mon/app (
    (mon/reify M' (mon/mon (x\ mon/fun c\ mon/app (mon/force c) x) (m\ f\ mon/fun c\ (mon/app (mon/force m) (mon/thunk (mon/fun y\ (mon/app (mon/app (mon/force f) y) c)))))) )
    ) (mon/thunk (mon/fun x\ (mon/fun h\ (Nu' x))))) (mon/thunk (mon/fun y\ mon/case y Ms'))) :-
    eff2mon/comp M M',
    eff2mon/handler H Nu' Ms'.

eff2mon/cases eff/cases/nil mon/cases/nil.
eff2mon/cases (eff/cases/cons Ms L M) (mon/cases/cons Ms' L' M') :-
    eff2mon/cases Ms Ms',
    eff2mon/label L L',
    pi x\ pi x'\
        eff2mon/value x x' =>
        eff2mon/comp (M x) (M' x').

eff2mon/handler (eff/valcase N) N' mon/cases/nil :-
    pi x\ pi x'\
        eff2mon/value x x' =>
        eff2mon/comp (N x) (N' x').
eff2mon/handler (eff/opcase H (eff/op X) M) Nu
    (mon/cases/cons Ms (mon/lbl X') (p\ mon/split p M')) :-
    eff2mon/handler H Nu Ms,
    eff2mon/nat X X',
    pi x\ pi x'\
    pi k\ pi k'\
        eff2mon/value x x' =>
        eff2mon/value k k' =>
        eff2mon/comp (M x k) (M' x' k').

eff2mon/evctx eff/hole mon/hole.
eff2mon/evctx (eff/evctx/bind E N) (mon/evctx/bind E' N') :-
    eff2mon/evctx E E',
    pi x\ pi x'\
        eff2mon/value x x' =>
        eff2mon/comp (N x) (N' x').
eff2mon/evctx (eff/evctx/app E V) (mon/evctx/app E' V') :-
    eff2mon/evctx E E',
    eff2mon/value V V'.
eff2mon/evctx (eff/evctx/prj1 E) (mon/evctx/prj1 E') :-
    eff2mon/evctx E E'.
eff2mon/evctx (eff/evctx/prj2 E) (mon/evctx/prj2 E') :-
    eff2mon/evctx E E'.
eff2mon/evctx (eff/evctx/handle E H) (
    mon/evctx/app (mon/evctx/app (
    (mon/evctx/reify E' (mon/mon (x\ mon/fun c\ mon/app (mon/force c) x) (m\ f\ mon/fun c\ (mon/app (mon/force m) (mon/thunk (mon/fun y\ (mon/app (mon/app (mon/force f) y) c)))))) )
    ) (mon/thunk (mon/fun x\ (mon/fun h\ (Nu' x))))) (mon/thunk (mon/fun y\ mon/case y Ms'))) :-
    eff2mon/evctx E E',
    eff2mon/handler H Nu' Ms'.

mon/is-evctx mon/hole.
mon/is-evctx (mon/evctx/bind E N) :- mon/is-evctx E.
mon/is-evctx (mon/evctx/app E V) :- mon/is-evctx E.
mon/is-evctx (mon/evctx/prj1 E) :- mon/is-evctx E.
mon/is-evctx (mon/evctx/prj2 E) :- mon/is-evctx E.
mon/is-evctx (mon/evctx/reify E T) :- mon/is-evctx E.
