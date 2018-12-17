module imp2exp.
accumulate imp.
accumulate exp.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% i2e/val_ty, i2e/comp_ty, i2e/qual_ty, i2e/poly_ty, i2e/cnstr
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i2e/val_ty imp/unit_ty exp/unit_ty.
i2e/val_ty (imp/fun_ty As Bs) (exp/fun_ty At Bt) :-
  i2e/val_ty As At,
  i2e/comp_ty Bs Bt.
i2e/val_ty (imp/hand_ty Bs1 Bs2) (exp/hand_ty Bt1 Bt2) :-
  i2e/comp_ty Bs1 Bt1,
  i2e/comp_ty Bs2 Bt2.

i2e/comp_ty (imp/bang As D) (exp/bang At D) :-
  i2e/val_ty As At.

i2e/qual_ty (imp/plain_qual_ty As) At :-
  i2e/val_ty As At.
i2e/qual_ty (imp/cnstr_qual_ty Pi_s As) (exp/qual_ty Pi_t At) :-
  i2e/cnstr Pi_s Pi_t,
  i2e/qual_ty As At.

i2e/poly_ty (imp/plain_poly_ty Qs) At :-
  i2e/qual_ty Qs At.
i2e/poly_ty (imp/all_skel Ps) (exp/all_skel At) :-
  pi s\ ground_skel s => i2e/poly_ty (Ps s) (At s).
i2e/poly_ty (imp/all_ty S Ps) (exp/all_ty S At) :-
  ground_skel S,
  pi a\ pi a'\ i2e/val_ty a a' => i2e/poly_ty (Ps a) (At a').
i2e/poly_ty (imp/all_dirt Ps) (exp/all_dirt At) :-
  pi d\ i2e/poly_ty (Ps d) (At d).

i2e/cnstr (imp/val_ty_cnstr As1 As2) (exp/val_ty_coer_ty At1 At2) :-
  i2e/val_ty As1 At1,
  i2e/val_ty As2 At2.
i2e/cnstr (imp/dirt_cnstr D1 D2) (exp/dirt_coer_ty D1 D2).
i2e/cnstr (imp/comp_ty_cnstr Bs1 Bs2) (exp/comp_ty_coer_ty Bt1 Bt2) :-
  i2e/comp_ty Bs1 Bt1,
  i2e/comp_ty Bs2 Bt2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% i2e/sig
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i2e/sig imp/empty_sig exp/empty_sig.
i2e/sig (imp/cons_sig O As1 As2 Sig_s) (exp/cons_sig O At1 At2 Sig_t) :-
  i2e/val_ty As1 At1,
  i2e/val_ty As2 At2,
  i2e/sig Sig_s Sig_t.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% i2e/var, i2e/qual_var, i2e/poly_var
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i2e/var Sig_s Vs As Vt :-
  i2e/qual_var Sig_s Vs (imp/plain_qual_ty As) Vt.

i2e/qual_var Sig_s Vs As (exp/app_coer Vt Y) :-
  i2e/qual_var Sig_s Vs (imp/cnstr_qual_ty Pi As) Vt,
  i2e/cnstr Pi Pi',
  exp/of_coer Y Pi'.
i2e/qual_var Sig_s Vs Qs Vt :-
  i2e/poly_var Sig_s Vs (imp/plain_poly_ty Qs) Vt.

i2e/poly_var Sig_s Vs (Ps S) (exp/app_skel Vt S) :-
  i2e/poly_var Sig_s Vs (imp/all_skel Ps) Vt,
  ground_skel S.
i2e/poly_var Sig_s Vs (Ps As) (exp/app_ty Vt At) :-
  ground_skel S,
  i2e/val_ty As At,
  exp/skel_val_ty At S,
  i2e/poly_var Sig_s Vs (imp/all_ty S Ps) Vt.
i2e/poly_var Sig_s Vs (Ps D) (exp/app_dirt Vt D) :-
  i2e/poly_var Sig_s Vs (imp/all_dirt Ps) Vt.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% i2e/val, i2e/comp, i2e/hand, i2e/qual_val, i2e/poly_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% VAR
i2e/val Sig_s Vs As Vt :-
  i2e/var Sig_s Vs As Vt.
% UNIT
i2e/val Sig_s imp/unit imp/unit_ty exp/unit.
% FUN
i2e/val Sig_s (imp/fun Cs) (imp/fun_ty As Bs) (exp/fun At Ct) :-
  pi x\ pi x'\ (i2e/var Sig_s x As x' => i2e/comp Sig_s (Cs x) Bs (Ct x')),
  i2e/val_ty As At.
% HANDLER
i2e/val Sig_s (imp/hand Hs) (imp/hand_ty (imp/bang A D) B) (exp/hand Ht) :-
  i2e/hand Sig_s Hs A D B Ht.
% VALUE CAST
i2e/val Sig_s Vs As2 (exp/val_cast Vt Y) :-
  i2e/val Sig_s Vs As1 Vt,
  i2e/val_ty As1 At1,
  i2e/val_ty As2 At2,
  exp/of_coer Y (exp/val_ty_coer_ty At1 At2).

% RETURN CASE
i2e/hand Sig_s (imp/ret_case Cs) As1 D (imp/bang As2 D) (exp/ret_case At1 Ct) :-
  pi x\ pi x'\ (i2e/var Sig_s x As1 x' => i2e/comp Sig_s (Cs x) (imp/bang As2 D) (Ct x')),
  i2e/val_ty As1 At1.
% OP CASE
i2e/hand Sig_s (imp/op_case O C Hs) As (cons O D) Bs (exp/op_case O Ct Ht):-
  i2e/hand Sig_s Hs As D Bs Ht,
  imp/of_op Sig_s O As1 As2,
  pi x\ pi x'\ pi k\ pi k'\ (
    i2e/var Sig_s x As1 x' =>
    i2e/var Sig_s k (imp/fun_ty As2 Bs) k' =>
    i2e/comp Sig_s (Cs x k) Bs (Ct x' k')),
  is_op O.

% APP
i2e/comp Sig_s (imp/app V1s V2s) Bs (exp/app V1t V2t) :-
  i2e/val Sig_s V1s (imp/fun_ty As Bs) V1t,
  i2e/val Sig_s V2s As V2t.
% LET
i2e/comp Sig_s (imp/let Vs Cs) Bs (exp/let Vt Ct) :-
  i2e/poly_val Sig_s Vs Ss Vt,
  pi x\ pi x'\ (i2e/poly_var Sig_s x Ss x' => i2e/comp Sig_s (Cs x) Bs (Ct x')).
% RETURN
i2e/comp Sig_s (imp/ret Vs) (imp/bang As empty) (exp/ret Vt) :-
  i2e/val Sig_s Vs As Vt.
% OP
i2e/comp Sig_s (imp/op O Vs Cs) (imp/bang As D) (exp/op O Vt At2 Ct) :-
  imp/of_op Sig_s O As1 As2,
  i2e/val Sig_s Vs As1 Vt,
  i2e/val_ty As2 At2,
  pi x\ pi x'\ (i2e/var Sig_s x As2 x' => i2e/comp Sig_s (Cs x) (imp/bang As D) (Ct x')),
  in_dirt O D,
  is_op O.
% DO
i2e/comp Sig_s (imp/do Cs1 Cs2) (imp/bang As2 D) (exp/do Ct1 Ct2) :-
  i2e/comp Sig_s Cs1 (imp/bang As1 D) Ct1,
  pi x\ pi x'\ (i2e/var Sig_s x As1 x' => i2e/comp Sig_s (Cs2 x) (imp/bang As2 D) (Ct2 x')).
% HANDLE
i2e/comp Sig_s (imp/with Cs Vs) Bs2 (exp/with Ct Vt) :-
  i2e/comp Sig_s Cs Bs1 Ct,
  i2e/val Sig_s Vs (imp/hand_ty Bs1 Bs2) Vt.
% COMPUTATION CAST
i2e/comp Sig_s Cs Bs2 (exp/comp_cast Ct Y) :-
  i2e/comp Sig_s Cs Bs1 Ct,
  i2e/comp_ty Bs1 Bt1,
  i2e/comp_ty Bs2 Bt2,
  exp/of_coer Y (exp/comp_ty_coer_ty Bt1 Bt2).

% ASSIGNING QUALIFIED TYPES
i2e/qual_val Sig_s Vs (imp/plain_qual_ty As) Vt :-
  i2e/val Sig_s Vs As Vt.
i2e/qual_val Sig_s Vs (imp/cnstr_qual_ty Pi_s As) (exp/lam_coer Pi_t Vt) :-
  i2e/cnstr Pi_s Pi_t,
  pi w\ (exp/of_coer w Pi_t => i2e/qual_val Sig_s Vs As (Vt w)),
  exp/good_coer_ty Pi_t.

% ASSIGNING POLYTYPES
i2e/poly_val Sig_s Vs (imp/plain_poly_ty As) Vt :-
  i2e/qual_val Sig_s Vs As Vt.
% SKELETON QUANTIFIED POLYTYPE
i2e/poly_val Sig_s Vs (imp/all_skel Ps) (exp/lam_skel Vt) :-
  pi s\ (ground_skel s => i2e/poly_val Sig_s Vs (Ps s) (Vt s)).
% VALUE TYPE QUANTIFIED POLYTYPE
i2e/poly_val Sig_s Vs (imp/all_ty S Ps) (exp/lam_ty S Vt) :-
  pi a\ pi a'\ (i2e/val_ty a a' => i2e/poly_val Sig_s Vs (Ps a) (Vt a')),
  ground_skel S.
% DIRT QUANTIFIED POLYTYPE
i2e/poly_val Sig_s Vs (imp/all_dirt Ps) (exp/lam_dirt Vt) :-
  pi d\ i2e/poly_val Sig_s Vs (Ps d) (Vt d).
