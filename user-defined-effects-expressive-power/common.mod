module common.

apart z (s _).
apart (s _) z.
apart (s N) (s N') :-
    apart N N'.

label-apart (lbl N) (lbl N') :-
    apart N N'.
