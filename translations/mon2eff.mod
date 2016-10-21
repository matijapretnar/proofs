module mon2eff.

accumulate syntax.

mon2eff/nat mon/z eff/z.
mon2eff/nat (mon/s N) (eff/s N') :-
    mon2eff/nat N N'.

mon2eff/label (mon/lbl N) (eff/lbl N') :-
    mon2eff/nat N N'.

mon2eff/value mon/unit eff/unit.
mon2eff/value (mon/pair V1 V2) (eff/pair V1' V2') :-
    mon2eff/value V1 V1',
    mon2eff/value V2 V2'.
mon2eff/value (mon/inj L V) (eff/inj L' V') :-
    mon2eff/label L L',
    mon2eff/value V V'.
mon2eff/value (mon/thunk M) (eff/thunk M') :-
    mon2eff/comp M M'.

mon2eff/comp (mon/ret V) (eff/ret V') :-
    mon2eff/value V V'.
mon2eff/comp (mon/fun M) (eff/fun M') :-
    pi x\ pi x'\
        mon2eff/value x x' =>
        mon2eff/comp (M x) (M' x').
mon2eff/comp (mon/split V M) (eff/split V' M') :-
    mon2eff/value V V',
    pi x1\ pi x2\ pi x1'\ pi x2'\
        mon2eff/value x1 x1' =>
        mon2eff/value x2 x2' =>
        mon2eff/comp (M x1 x2) (M' x1' x2').
mon2eff/comp (mon/case V Ms) (eff/case V' Ms') :-
    mon2eff/value V V',
    mon2eff/cases Ms Ms'.
mon2eff/comp (mon/force V) (eff/force V') :-
    mon2eff/value V V'.
mon2eff/comp (mon/bind M N) (eff/bind M' N') :-
    mon2eff/comp M M',
    pi x\ pi x'\
        mon2eff/value x x' =>
        mon2eff/comp (N x) (N' x').
mon2eff/comp (mon/app M V) (eff/app M' V') :-
    mon2eff/comp M M',
    mon2eff/value V V'.
mon2eff/comp (mon/reify M (mon/mon Nu Nb)) (eff/handle M' (eff/opcase (eff/valcase Nu') (eff/op eff/z) (Nb'))) :-
    mon2eff/comp M M',
    pi x\ pi x'\
        mon2eff/value x x' =>
        mon2eff/comp (Nu x) (Nu' x'),
    pi x\ pi x'\ pi k\ pi k'\
        mon2eff/value x x' =>
        mon2eff/value k k' =>
        mon2eff/comp (Nb x k) (Nb' x' k').
mon2eff/comp (mon/reflect M) (eff/call (eff/op eff/z) (eff/thunk M')) :-
    mon2eff/comp M M'.

mon2eff/cases mon/cases/nil eff/cases/nil.
mon2eff/cases (mon/cases/cons Ms L M) (eff/cases/cons Ms' L' M') :-
    mon2eff/cases Ms Ms',
    mon2eff/label L L',
    pi x\ pi x'\
        mon2eff/value x x' =>
        mon2eff/comp (M x) (M' x').

mon2eff/evctx mon/hole eff/hole.
mon2eff/evctx (mon/evctx/bind E N) (eff/evctx/bind E' N') :-
    mon2eff/evctx E E',
    pi x\ pi x'\
        mon2eff/value x x' =>
        mon2eff/comp (N x) (N' x').
mon2eff/evctx (mon/evctx/app E V) (eff/evctx/app E' V') :-
    mon2eff/evctx E E',
    mon2eff/value V V'.
mon2eff/evctx (mon/evctx/reify E (mon/mon Nu Nb)) (eff/evctx/handle E' (
        eff/opcase (eff/valcase Nu') (eff/op eff/z) (Nb')
    )) :-
    mon2eff/evctx E E',
    pi x\ pi x'\
        mon2eff/value x x' =>
        mon2eff/comp (Nu x) (Nu' x'),
    pi x\ pi x'\ pi k\ pi k'\
        mon2eff/value x x' =>
        mon2eff/value k k' =>
        mon2eff/comp (Nb x k) (Nb' x' k').

eff/is-evctx eff/hole.
eff/is-evctx (eff/evctx/bind E N) :- eff/is-evctx E.
eff/is-evctx (eff/evctx/app E V) :- eff/is-evctx E.
eff/is-evctx (eff/evctx/handle E H) :- eff/is-evctx E.
