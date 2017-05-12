module xxx2yyy.

accumulate syntax.

xxx2yyy/nat xxx/z yyy/z.
xxx2yyy/nat (xxx/s N) (yyy/s N') :-
    xxx2yyy/nat N N'.

xxx2yyy/label (xxx/lbl N) (yyy/lbl N') :-
    xxx2yyy/nat N N'.

xxx2yyy/value xxx/unit yyy/unit.
xxx2yyy/value (xxx/pair V1 V2) (yyy/pair V1' V2') :-
    xxx2yyy/value V1 V1',
    xxx2yyy/value V2 V2'.
xxx2yyy/value (xxx/inj L V) (yyy/inj L' V') :-
    xxx2yyy/label L L',
    xxx2yyy/value V V'.
xxx2yyy/value (xxx/thunk M) (yyy/thunk M') :-
    xxx2yyy/comp M M'.

xxx2yyy/comp (xxx/ret V) (yyy/ret V') :-
    xxx2yyy/value V V'.
xxx2yyy/comp (xxx/fun M) (yyy/fun M') :-
    pi x\ pi x'\
        xxx2yyy/value x x' =>
        xxx2yyy/comp (M x) (M' x').
xxx2yyy/comp (xxx/split V M) (yyy/split V' M') :-
    xxx2yyy/value V V',
    pi x1\ pi x2\ pi x1'\ pi x2'\
        xxx2yyy/value x1 x1' =>
        xxx2yyy/value x2 x2' =>
        xxx2yyy/comp (M x1 x2) (M' x1' x2').
xxx2yyy/comp (xxx/case V Ms) (yyy/case V' Ms') :-
    xxx2yyy/value V V',
    xxx2yyy/cases Ms Ms'.
xxx2yyy/comp (xxx/force V) (yyy/force V') :-
    xxx2yyy/value V V'.
xxx2yyy/comp (xxx/bind M N) (yyy/bind M' N') :-
    xxx2yyy/comp M M',
    pi x\ pi x'\
        xxx2yyy/value x x' =>
        xxx2yyy/comp (N x) (N' x').
xxx2yyy/comp (xxx/app M V) (yyy/app M' V') :-
    xxx2yyy/comp M M',
    xxx2yyy/value V V'.

xxx2yyy/cases xxx/cases/nil yyy/cases/nil.
xxx2yyy/cases (xxx/cases/cons Ms L M) (yyy/cases/cons Ms' L' M') :-
    xxx2yyy/cases Ms Ms',
    xxx2yyy/label L L',
    pi x\ pi x'\
        xxx2yyy/value x x' =>
        xxx2yyy/comp (M x) (M' x').

xxx2yyy/evctx xxx/hole yyy/hole.
xxx2yyy/evctx (xxx/evctx/bind E N) (yyy/evctx/bind E' N') :-
    xxx2yyy/evctx E E',
    pi x\ pi x'\
        xxx2yyy/value x x' =>
        xxx2yyy/comp (N x) (N' x').
xxx2yyy/evctx (xxx/evctx/app E V) (yyy/evctx/app E' V') :-
    xxx2yyy/evctx E E',
    xxx2yyy/value V V'.

yyy/is-evctx yyy/hole.
yyy/is-evctx (yyy/evctx/bind E N) :- yyy/is-evctx E.
yyy/is-evctx (yyy/evctx/app E V) :- yyy/is-evctx E.
