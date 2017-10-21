module elaboration.
accumulate source.
accumulate target.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% elb_val_ty, elb_comp_ty, elb_qual_ty, elb_poly_ty, elb_cnstr
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elb_val_ty s/unit_ty t/unit_ty.
elb_val_ty (s/fun_ty As Bs) (t/fun_ty At Bt) :-
  elb_val_ty As At,
  elb_comp_ty Bs Bt.
elb_val_ty (s/hand_ty Bs1 Bs2) (t/hand_ty Bt1 Bt2) :-
  elb_comp_ty Bs1 Bt1,
  elb_comp_ty Bs2 Bt2.

elb_comp_ty (s/bang As D) (t/bang At D) :-
  elb_val_ty As At.

elb_qual_ty (s/plain_qual_ty As) At :-
  elb_val_ty As At.
elb_qual_ty (s/cnstr_qual_ty Pi_s As) (t/qual_ty Pi_t At) :-
  elb_cnstr Pi_s Pi_t,
  elb_qual_ty As At.

elb_poly_ty (s/plain_poly_ty Qs) At :-
  elb_qual_ty Qs At.
elb_poly_ty (s/all_skel Ps) (t/all_skel At) :-
  pi s\ ground_skel s => elb_poly_ty (Ps s) (At s).
elb_poly_ty (s/all_ty S Ps) (t/all_ty S At) :-
  ground_skel S,
  pi a\ pi a'\ elb_val_ty a a' => elb_poly_ty (Ps a) (At a').
elb_poly_ty (s/all_dirt Ps) (t/all_dirt At) :-
  pi d\ elb_poly_ty (Ps d) (At d).

elb_cnstr (s/val_ty_cnstr As1 As2) (t/val_ty_coer_ty At1 At2) :-
  elb_val_ty As1 At1,
  elb_val_ty As2 At2.
elb_cnstr (s/dirt_cnstr D1 D2) (t/dirt_coer_ty D1 D2).
elb_cnstr (s/comp_ty_cnstr Bs1 Bs2) (t/comp_ty_coer_ty Bt1 Bt2) :-
  elb_comp_ty Bs1 Bt1,
  elb_comp_ty Bs2 Bt2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% elb_sig
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elb_sig s/empty_sig t/empty_sig.
elb_sig (s/cons_sig O As1 As2 Sig_s) (t/cons_sig O At1 At2 Sig_t) :-
  elb_val_ty As1 At1,
  elb_val_ty As2 At2,
  elb_sig Sig_s Sig_t.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% elb_var, elb_qual_var, elb_poly_var
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elb_var Sig_s Vs As Vt :-
  elb_qual_var Sig_s Vs (s/plain_qual_ty As) Vt.

elb_qual_var Sig_s Vs As (t/app_coer Vt Y) :-
  elb_qual_var Sig_s Vs (s/cnstr_qual_ty Pi As) Vt,
  elb_cnstr Pi Pi',
  t/of_coer Y Pi'.
elb_qual_var Sig_s Vs Qs Vt :-
  elb_poly_var Sig_s Vs (s/plain_poly_ty Qs) Vt.

elb_poly_var Sig_s Vs (Ps S) (t/app_skel Vt S) :-
  elb_poly_var Sig_s Vs (s/all_skel Ps) Vt,
  ground_skel S.
elb_poly_var Sig_s Vs (Ps As) (t/app_ty Vt At) :-
  ground_skel S,
  elb_val_ty As At,
  t/skel_val_ty At S,
  elb_poly_var Sig_s Vs (s/all_ty S Ps) Vt.
elb_poly_var Sig_s Vs (Ps D) (t/app_dirt Vt D) :-
  elb_poly_var Sig_s Vs (s/all_dirt Ps) Vt.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% elb_val, elb_comp, elb_hand, elb_qual_val, elb_poly_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% VAR
elb_val Sig_s Vs As Vt :-
  elb_var Sig_s Vs As Vt.
% UNIT
elb_val Sig_s s/unit s/unit_ty t/unit.
% FUN
elb_val Sig_s (s/fun Cs) (s/fun_ty As Bs) (t/fun At Ct) :-
  pi x\ pi x'\ (elb_var Sig_s x As x' => elb_comp Sig_s (Cs x) Bs (Ct x')),
  elb_val_ty As At.
% HANDLER
elb_val Sig_s (s/hand Hs) (s/hand_ty (s/bang A D) B) (t/hand Ht) :-
  elb_hand Sig_s Hs A D B Ht.
% VALUE CAST
elb_val Sig_s Vs As2 (t/val_cast Vt Y) :-
  elb_val Sig_s Vs As1 Vt,
  elb_val_ty As1 At1,
  elb_val_ty As2 At2,
  t/of_coer Y (t/val_ty_coer_ty At1 At2).

% RETURN CASE
elb_hand Sig_s (s/ret_case Cs) As1 D (s/bang As2 D) (t/ret_case At1 Ct) :-
  pi x\ pi x'\ (elb_var Sig_s x As1 x' => elb_comp Sig_s (Cs x) (s/bang As2 D) (Ct x')),
  elb_val_ty As1 At1.
% OP CASE
elb_hand Sig_s (s/op_case O C Hs) As (cons O D) Bs (t/op_case O Ct Ht):-
  elb_hand Sig_s Hs As D Bs Ht,
  s/of_op Sig_s O As1 As2,
  pi x\ pi x'\ pi k\ pi k'\ (
    elb_var Sig_s x As1 x' =>
    elb_var Sig_s k (s/fun_ty As2 Bs) k' =>
    elb_comp Sig_s (Cs x k) Bs (Ct x' k')),
  is_op O.

% APP
elb_comp Sig_s (s/app V1s V2s) Bs (t/app V1t V2t) :-
  elb_val Sig_s V1s (s/fun_ty As Bs) V1t,
  elb_val Sig_s V2s As V2t.
% LET
elb_comp Sig_s (s/let Vs Cs) Bs (t/let Vt Ct) :-
  elb_poly_val Sig_s Vs Ss Vt,
  pi x\ pi x'\ (elb_poly_var Sig_s x Ss x' => elb_comp Sig_s (Cs x) Bs (Ct x')).
% RETURN
elb_comp Sig_s (s/ret Vs) (s/bang As empty) (t/ret Vt) :-
  elb_val Sig_s Vs As Vt.
% OP
elb_comp Sig_s (s/op O Vs Cs) (s/bang As D) (t/op O Vt At2 Ct) :-
  s/of_op Sig_s O As1 As2,
  elb_val Sig_s Vs As1 Vt,
  elb_val_ty As2 At2,
  pi x\ pi x'\ (elb_var Sig_s x As2 x' => elb_comp Sig_s (Cs x) (s/bang As D) (Ct x')),
  in_dirt O D,
  is_op O.
% DO
elb_comp Sig_s (s/do Cs1 Cs2) (s/bang As2 D) (t/do Ct1 Ct2) :-
  elb_comp Sig_s Cs1 (s/bang As1 D) Ct1,
  pi x\ pi x'\ (elb_var Sig_s x As1 x' => elb_comp Sig_s (Cs2 x) (s/bang As2 D) (Ct2 x')).
% HANDLE
elb_comp Sig_s (s/with Cs Vs) Bs2 (t/with Ct Vt) :-
  elb_comp Sig_s Cs Bs1 Ct,
  elb_val Sig_s Vs (s/hand_ty Bs1 Bs2) Vt.
% COMPUTATION CAST
elb_comp Sig_s Cs Bs2 (t/comp_cast Ct Y) :-
  elb_comp Sig_s Cs Bs1 Ct,
  elb_comp_ty Bs1 Bt1,
  elb_comp_ty Bs2 Bt2,
  t/of_coer Y (t/comp_ty_coer_ty Bt1 Bt2).

% ASSIGNING QUALIFIED TYPES
elb_qual_val Sig_s Vs (s/plain_qual_ty As) Vt :-
  elb_val Sig_s Vs As Vt.
elb_qual_val Sig_s Vs (s/cnstr_qual_ty Pi_s As) (t/lam_coer Pi_t Vt) :-
  elb_cnstr Pi_s Pi_t,
  pi w\ (t/of_coer w Pi_t => elb_qual_val Sig_s Vs As (Vt w)).

% ASSIGNING POLYTYPES
elb_poly_val Sig_s Vs (s/plain_poly_ty As) Vt :-
  elb_qual_val Sig_s Vs As Vt.
% SKELETON QUANTIFIED POLYTYPE
elb_poly_val Sig_s Vs (s/all_skel Ps) (t/lam_skel Vt) :-
  pi s\ (ground_skel s => elb_poly_val Sig_s Vs (Ps s) (Vt s)).
% VALUE TYPE QUANTIFIED POLYTYPE
elb_poly_val Sig_s Vs (s/all_ty S Ps) (t/lam_ty S Vt) :-
  pi a\ pi a'\ (elb_val_ty a a' => elb_poly_val Sig_s Vs (Ps a) (Vt a')),
  ground_skel S.
% DIRT QUANTIFIED POLYTYPE
elb_poly_val Sig_s Vs (s/all_dirt Ps) (t/lam_dirt Vt) :-
  pi d\ elb_poly_val Sig_s Vs (Ps d) (Vt d).
