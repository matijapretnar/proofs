module source.
accumulate common.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% s/of_op
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s/of_op (s/cons_sig O A B Sig) O A B.
s/of_op (s/cons_sig O1 A1 B1 Sig) O2 A2 B2 :-
    s/of_op Sig O2 A2 B2,
    apart O1 O2.
