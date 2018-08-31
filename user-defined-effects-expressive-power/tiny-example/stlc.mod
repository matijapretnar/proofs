module stlc.

src/wf src/unitty.
src/wf (src/arrow A B) :-
    src/wf A,
    src/wf B.

src/of M A :-
    src/of' M A,
    src/wf A.
src/of' src/unit src/unitty.
src/of' (src/fun M) (src/arrow A B) :-
    pi x\ src/of x A => src/of (M x) B.
src/of' (src/app M N) B :-
    src/of M (src/arrow A B),
    src/of N A.

trg/wf trg/unitty.
trg/wf (trg/arrow A B) :-
    trg/wf A,
    trg/wf B.

trg/of M A :-
    trg/of' M A,
    trg/wf A.
trg/of' trg/unit trg/unitty.
trg/of' (trg/fun M) (trg/arrow A B) :-
    pi x\ trg/of x A => trg/of (M x) B.
trg/of' (trg/app M N) B :-
    trg/of M (trg/arrow A B),
    trg/of N A.

s2t/ty src/unitty trg/unitty.
s2t/ty (src/arrow A B) (trg/arrow A' B') :-
    s2t/ty A A',
    s2t/ty B B'.

s2t/tm src/unit trg/unit.
s2t/tm (src/app M N) (trg/app M' N') :-
    s2t/tm M M',
    s2t/tm N N'.
s2t/tm (src/fun M) (trg/fun M') :-
    pi x\ pi x'\ s2t/tm x x' => s2t/tm (M x) (M' x').
