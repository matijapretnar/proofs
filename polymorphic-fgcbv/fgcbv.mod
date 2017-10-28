module fgcbv.

% TYPING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

concrete (plain A) A.
concrete (all S) A' :-
  concrete (S A) A'.

of/value tru bool.
of/value fls bool.
of/value (fun M) (arrow A C) :-
  pi x\ (of/value x A => of/comp (M x) C).
of/value V A :-
  pof/value V S,
  concrete S A.

of/comp (cond V M1 M2) C :-
  of/value V bool,
  of/comp M1 C,
  of/comp M2 C.
of/comp (app V1 V2) C :-
  of/value V1 (arrow A C),
  of/value V2 A.
of/comp (ret V) (f A Eff) :-
  of/value V A.
of/comp (bind M N) (f A Eff) :-
  pof/comp M S Eff,
  pi x\ (pof/value x S => of/comp (N x) (f A Eff)).

pof/comp M (plain A) Eff :-
  of/comp M (f A Eff).
pof/comp M (all S) Eff :-
  pi a\ pof/comp M (S a) Eff.

% SEMANTICS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

step (cond tru M1 M2) M1.
step (cond fls M1 M2) M2.
step (app (fun M) V) (M V).
step (bind (ret V) N) (N V).
step (bind M N) (bind M' N) :-
  step M M'.

progresses (ret _).
progresses M :-
  step M _.
