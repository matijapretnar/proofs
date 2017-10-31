module erasure.
accumulate target.
accumulate erased.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ers_sig
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ers_sig t/empty_sig e/empty_sig.
ers_sig (t/cons_sig O A1 A2 Sig_t) (e/cons_sig O S1 S2 Sig_e) :-
  t/skel_val_ty A1 S1,
  t/skel_val_ty A2 S2,
  ers_sig Sig_t Sig_e.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ers_val, ers_comp, ers_hand
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% UNIT
ers_val t/unit e/unit.
% FUN
ers_val (t/fun A Ct) (e/fun T Ce) :-
  pi x\ pi x'\ (ers_val x x' => ers_comp (Ct x) (Ce x')),
  t/skel_val_ty A T.
% HANDLER
ers_val (t/hand Ht) (e/hand He) :-
  ers_hand Ht He.
% SKELETON LAMBDA
ers_val (t/lam_skel Vt) (e/lam_ty Ve) :-
  pi s\ ers_val (Vt s) (Ve s).
% SKELETON APPLY
ers_val (t/app_skel Vt S) (e/app_ty Ve S) :-
  ers_val Vt Ve.
% VALUE TY LAMBDA
ers_val (t/lam_ty S Vt) Ve :-
  pi t\ (t/skel_val_ty t S => ers_val (Vt t) Ve).
% VALUE TY APPLY
ers_val (t/app_ty Vt _) Ve :-
  ers_val Vt Ve.
% DIRT LAMBDA
ers_val (t/lam_dirt Vt) Ve :-
  pi d\ ers_val (Vt d) Ve.
% DIRT APPLY
ers_val (t/app_dirt Vt _) Ve :-
  ers_val Vt Ve.
% COERCION LAMBDA
ers_val (t/lam_coer _ Vt) Ve :-
  pi w\ ers_val (Vt w) Ve.
% COERCION APPLY
ers_val (t/app_coer Vt _) Ve :-
  ers_val Vt Ve.
% VALUE COERCION
ers_val (t/val_cast Vt _) Ve :-
  ers_val Vt Ve.

% RETURN CASE
ers_hand (t/ret_case A Ct) (e/ret_case T Ce) :-
  pi x\ pi x'\ (ers_val x x' => ers_comp (Ct x) (Ce x')),
  t/skel_val_ty A T.
% OP CASE
ers_hand (t/op_case O Ct Ht) (e/op_case O Ce He):-
  ers_hand Ht He,
  pi x\ pi x'\ pi k\ pi k'\ (
    ers_val x x' => ers_val k k' =>
    ers_comp (Ct x k) (Ce x' k')).

% APP
ers_comp (t/app V1t V2t) (e/app V1e V2e) :-
  ers_val V1t V1e,
  ers_val V2t V2e.
% LET
ers_comp (t/let Vt Ct) (e/let Ve Ce) :-
  ers_val Vt Ve,
  pi x\ pi x'\ (ers_val x x' => ers_comp (Ct x) (Ce x')).
% RETURN
ers_comp (t/ret Vt) (e/ret Ve) :-
  ers_val Vt Ve.
% OP
ers_comp (t/op O Vt At Ct) (e/op O Ve Ae Ce) :-
  ers_val Vt Ve,
  t/skel_val_ty At Ae,
  pi x\ pi x'\ (ers_val x x' => ers_comp (Ct x) (Ce x')).
% DO
ers_comp (t/do Ct1 Ct2) (e/do Ce1 Ce2) :-
  ers_comp Ct1 Ce1,
  pi x\ pi x'\ (ers_val x x' => ers_comp (Ct2 x) (Ce2 x')).
% HANDLE
ers_comp (t/with Ct Vt) (e/with Ce Ve) :-
  ers_comp Ct Ce,
  ers_val Vt Ve.
% COMPUTATION COERCION
ers_comp (t/comp_cast Ct _) Ce :-
  ers_comp Ct Ce.
