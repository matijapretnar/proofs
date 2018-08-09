module del2mon.
accumulate auto-del2mon.

del2mon/comp (del/reset M N) (mon/app (mon/reify M' (mon/mon (x\ mon/fun c\ mon/app (mon/force c) x) (m\ f\ mon/fun c\ mon/app (mon/force m) (mon/thunk (mon/fun y\ mon/app (mon/app (mon/force f) y) c))))) (mon/thunk (mon/fun N'))) :-
    del2mon/comp M M',
    pi x\ pi x'\
        del2mon/value x x' =>
        del2mon/comp (N x) (N' x').
del2mon/comp (del/shift M) (mon/reflect (mon/fun M')) :-
    pi k\ pi k'\
        del2mon/value k k' =>
        del2mon/comp (M k) (M' k').
del2mon/evctx (del/evctx/reset E N) (mon/evctx/app (mon/evctx/reify E' (mon/mon (x\ mon/fun c\ mon/app (mon/force c) x) (m\ f\ mon/fun c\ mon/app (mon/force m) (mon/thunk (mon/fun y\ mon/app (mon/app (mon/force f) y) c))))) (mon/thunk (mon/fun N'))) :-
    del2mon/evctx E E',
    pi x\ pi x'\
        del2mon/value x x' =>
        del2mon/comp (N x) (N' x').

del2mon/eff del/empty mon/empty.
del2mon/eff (del/cons Eff C) (mon/cons Eff'
    (a\ mon/arrow (mon/u (mon/arrow a C')) C')
    (x\ mon/fun c\ mon/app (mon/force c) x)
    (m\ f\ mon/fun c\ mon/app (mon/force m) (mon/thunk (mon/fun y\ mon/app (mon/app (mon/force f) y) c)))
) :- 
    del2mon/compty C C',
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
del2mon/valtys (del/valtys/cons As L A) (mon/valtys/cons As' L A') :-
    del2mon/valtys As As',
    del2mon/valty A A'.

