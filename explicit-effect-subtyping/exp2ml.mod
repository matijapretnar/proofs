module exp2ml.
accumulate exp.
accumulate ml.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e2m/sig
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
e2m/sig exp/empty_sig ml/empty_sig.
e2m/sig (exp/cons_sig O A1 A2 Sig_t) (ml/cons_sig O S1 S2 Sig_e) :-
  e2m/val_ty A1 S1,
  e2m/val_ty A2 S2,
  e2m/sig Sig_t Sig_e.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e2m/full_dirt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e2m/full_dirt (cons _ _).
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e2m/val_ty, e2m/comp_ty, e2m/coer_ty
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e2m/val_ty exp/unit_ty ml/unit_ty.
e2m/val_ty (exp/fun_ty A C) (ml/fun_ty A' C') :-
  e2m/val_ty A A',
  e2m/comp_ty C C'.
e2m/val_ty (exp/hand_ty (exp/bang A empty) C) (ml/fun_ty A' C') :-
  e2m/val_ty A A',
  e2m/comp_ty C C'.
e2m/val_ty (exp/hand_ty (exp/bang A D) C) (ml/hand_ty A' C') :-
  e2m/val_ty A A',
  e2m/full_dirt D,
  e2m/comp_ty C C'.
e2m/val_ty (exp/all_skel A) A' :-
  pi s\ e2m/val_ty (A s) A'.
e2m/val_ty (exp/all_ty _ A) (ml/all_ty A') :-
  pi a\ pi a'\ e2m/val_ty a a' => e2m/val_ty (A a) (A' a').
e2m/val_ty (exp/all_dirt A) A' :-
  pi d\ e2m/full_dirt d => e2m/val_ty (A d) A'.
e2m/val_ty (exp/qual_ty (exp/val_ty_coer_ty A1 A2) A) (ml/qual_ty (ml/ty_coer_ty A1' A2') A') :-
  e2m/val_ty A1 A1',
  e2m/val_ty A2 A2',
  e2m/val_ty A A'.
e2m/val_ty (exp/qual_ty (exp/comp_ty_coer_ty C1 C2) A) (ml/qual_ty (ml/ty_coer_ty C1' C2') A') :-
  e2m/comp_ty C1 C1',
  e2m/comp_ty C2 C2',
  e2m/val_ty A A'.
e2m/val_ty (exp/qual_ty (exp/dirt_coer_ty _ _) A) A' :-
  e2m/val_ty A A'.

e2m/comp_ty (exp/bang A empty) A' :-
  e2m/val_ty A A'.
e2m/comp_ty (exp/bang A D) A' :-
  e2m/full_dirt D,
  e2m/val_ty A (ml/comp_ty A').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e2m/val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% UNIT
e2m/val exp/unit ml/unit.
% FUN
e2m/val (exp/fun A Ct) (ml/fun T Cml) :-
  pi x\ pi x'\ (e2m/val x x' => e2m/comp (Ct x) (Cml x')),
  e2m/val_ty A T.
% % HANDLER
% e2m/val (exp/hand Ht) (skel/hand He) :-
%   e2m/hand Ht He.
% % SKELETON LAMBDA
% e2m/val (exp/lam_skel Vt) (skel/lam_ty Ve) :-
%   pi s\ e2m/val (Vt s) (Ve s).
% % SKELETON APPLY
% e2m/val (exp/app_skel Vt S) (skel/app_ty Ve S) :-
%   e2m/val Vt Ve.
% % VALUE TY LAMBDA
% e2m/val (exp/lam_ty S Vt) Ve :-
%   pi t\ (exp/skel_val_ty t S => e2m/val (Vt t) Ve).
% % VALUE TY APPLY
% e2m/val (exp/app_ty Vt _) Ve :-
%   e2m/val Vt Ve.
% % DIRT LAMBDA
% e2m/val (exp/lam_dirt Vt) Ve :-
%   pi d\ e2m/val (Vt d) Ve.
% % DIRT APPLY
% e2m/val (exp/app_dirt Vt _) Ve :-
%   e2m/val Vt Ve.
% % COERCION LAMBDA
% e2m/val (exp/lam_coer _ Vt) Ve :-
%   pi w\ e2m/val (Vt w) Ve.
% % COERCION APPLY
% e2m/val (exp/app_coer Vt _) Ve :-
%   e2m/val Vt Ve.
% % VALUE COERCION
% e2m/val (exp/val_cast Vt _) Ve :-
%   e2m/val Vt Ve.
% 
% % RETURN CASE
% e2m/hand (exp/ret_case A Ct) (skel/ret_case T Ce) :-
%   pi x\ pi x'\ (e2m/val x x' => e2m/comp (Ct x) (Ce x')),
%   exp/skel_val_ty A T.
% % OP CASE
% e2m/hand (exp/op_case O Ct Ht) (skel/op_case O Ce He):-
%   e2m/hand Ht He,
%   pi x\ pi x'\ pi k\ pi k'\ (
%     e2m/val x x' => e2m/val k k' =>
%     e2m/comp (Ct x k) (Ce x' k')).
% 
% % APP
% e2m/comp (exp/app V1t V2t) (skel/app V1e V2e) :-
%   e2m/val V1t V1e,
%   e2m/val V2t V2e.
% % LET
% e2m/comp (exp/let Vt Ct) (skel/let Ve Ce) :-
%   e2m/val Vt Ve,
%   pi x\ pi x'\ (e2m/val x x' => e2m/comp (Ct x) (Ce x')).
% % RETURN
% e2m/comp (exp/ret Vt) (skel/ret Ve) :-
%   e2m/val Vt Ve.
% % OP
% e2m/comp (exp/op O Vt At Ct) (skel/op O Ve Ae Ce) :-
%   e2m/val Vt Ve,
%   exp/skel_val_ty At Ae,
%   pi x\ pi x'\ (e2m/val x x' => e2m/comp (Ct x) (Ce x')).
% % DO
% e2m/comp (exp/do Ct1 Ct2) (skel/do Ce1 Ce2) :-
%   e2m/comp Ct1 Ce1,
%   pi x\ pi x'\ (e2m/val x x' => e2m/comp (Ct2 x) (Ce2 x')).
% % HANDLE
% e2m/comp (exp/with Ct Vt) (skel/with Ce Ve) :-
%   e2m/comp Ct Ce,
%   e2m/val Vt Ve.
% % COMPUTATION COERCION
% e2m/comp (exp/comp_cast Ct _) Ce :-
%   e2m/comp Ct Ce.
