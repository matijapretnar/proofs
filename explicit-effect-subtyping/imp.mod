module imp.
accumulate common.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% imp/of_op
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

imp/of_op (imp/cons_sig O A B Sig) O A B.
imp/of_op (imp/cons_sig O1 A1 B1 Sig) O2 A2 B2 :-
    imp/of_op Sig O2 A2 B2,
    apart O1 O2.
