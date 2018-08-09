module eff2mon.
accumulate auto-eff2mon.

eff2mon/comp (eff/call (eff/op X) V)
    (mon/reflect (mon/fun k\ mon/fun h\ (mon/app (mon/force h) (mon/inj (lbl X) (mon/pair V' (mon/thunk (mon/fun y\ (mon/app (mon/app (mon/force k) y) h)))))))) :-
    eff2mon/value V V'.
eff2mon/comp (eff/handle M H) (mon/app (mon/app (
    (mon/reify M' (mon/mon (x\ mon/fun c\ mon/app (mon/force c) x) (m\ f\ mon/fun c\ (mon/app (mon/force m) (mon/thunk (mon/fun y\ (mon/app (mon/app (mon/force f) y) c)))))) )
    ) (mon/thunk (mon/fun x\ (mon/fun h\ (Nu' x))))) (mon/thunk (mon/fun y\ mon/case y Ms'))) :-
    eff2mon/comp M M',
    eff2mon/handler H Nu' Ms'.

eff2mon/handler (eff/valcase N) N' mon/cases/nil :-
    pi x\ pi x'\
        eff2mon/value x x' =>
        eff2mon/comp (N x) (N' x').
eff2mon/handler (eff/opcase H (eff/op X) M) Nu
    (mon/cases/cons Ms (lbl X) (p\ mon/split p M')) :-
    eff2mon/handler H Nu Ms,
    pi x\ pi x'\
    pi k\ pi k'\
        eff2mon/value x x' =>
        eff2mon/value k k' =>
        eff2mon/comp (M x k) (M' x' k').

eff2mon/evctx (eff/evctx/handle E H) (
    mon/evctx/app (mon/evctx/app (
    (mon/evctx/reify E' (mon/mon (x\ mon/fun c\ mon/app (mon/force c) x) (m\ f\ mon/fun c\ (mon/app (mon/force m) (mon/thunk (mon/fun y\ (mon/app (mon/app (mon/force f) y) c)))))) )
    ) (mon/thunk (mon/fun x\ (mon/fun h\ (Nu' x))))) (mon/thunk (mon/fun y\ mon/case y Ms'))) :-
    eff2mon/evctx E E',
    eff2mon/handler H Nu' Ms'.
