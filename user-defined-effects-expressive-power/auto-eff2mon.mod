module auto-eff2mon.
accumulate eff.
accumulate mon.

eff2mon/value eff/unit mon/unit.
eff2mon/value (eff/pair V1 V2) (mon/pair V1' V2') :-
    eff2mon/value V1 V1',
    eff2mon/value V2 V2'.
eff2mon/value (eff/inj L V) (mon/inj L V') :-
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

eff2mon/cases eff/cases/nil mon/cases/nil.
eff2mon/cases (eff/cases/cons Ms L M) (mon/cases/cons Ms' L M') :-
    eff2mon/cases Ms Ms',
    pi x\ pi x'\
        eff2mon/value x x' =>
        eff2mon/comp (M x) (M' x').

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
