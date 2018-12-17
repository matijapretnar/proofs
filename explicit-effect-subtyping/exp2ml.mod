module exp2ml.
accumulate exp.
accumulate ml.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x_sig
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
x_sig exp/empty_sig ml/empty_sig.
% e2s/sig (exp/cons_sig O A1 A2 Sig_t) (skel/cons_sig O S1 S2 Sig_e) :-
%   exp/skel_val_ty A1 S1,
%   exp/skel_val_ty A2 S2,
%   e2s/sig Sig_t Sig_e.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x_val_ty
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_val_ty exp/unit_ty ml/unit_ty.
x_val_ty (exp/fun_ty A C) (ml/fun_ty A' C') :-
  x_val_ty A A', x_comp_ty C C'.
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% UNIT
x_val exp/unit ml/unit.
% % FUN
x_val (exp/fun A Ct) (ml/fun T Cml) :-
  pi x\ pi x'\ (x_val x x' => x_comp (Ct x) (Cml x')),
  x_val_ty A T.
% % HANDLER
% e2s/val (exp/hand Ht) (skel/hand He) :-
%   e2s/hand Ht He.
% % SKELETON LAMBDA
% e2s/val (exp/lam_skel Vt) (skel/lam_ty Ve) :-
%   pi s\ e2s/val (Vt s) (Ve s).
% % SKELETON APPLY
% e2s/val (exp/app_skel Vt S) (skel/app_ty Ve S) :-
%   e2s/val Vt Ve.
% % VALUE TY LAMBDA
% e2s/val (exp/lam_ty S Vt) Ve :-
%   pi t\ (exp/skel_val_ty t S => e2s/val (Vt t) Ve).
% % VALUE TY APPLY
% e2s/val (exp/app_ty Vt _) Ve :-
%   e2s/val Vt Ve.
% % DIRT LAMBDA
% e2s/val (exp/lam_dirt Vt) Ve :-
%   pi d\ e2s/val (Vt d) Ve.
% % DIRT APPLY
% e2s/val (exp/app_dirt Vt _) Ve :-
%   e2s/val Vt Ve.
% % COERCION LAMBDA
% e2s/val (exp/lam_coer _ Vt) Ve :-
%   pi w\ e2s/val (Vt w) Ve.
% % COERCION APPLY
% e2s/val (exp/app_coer Vt _) Ve :-
%   e2s/val Vt Ve.
% % VALUE COERCION
% e2s/val (exp/val_cast Vt _) Ve :-
%   e2s/val Vt Ve.
% 
% % RETURN CASE
% e2s/hand (exp/ret_case A Ct) (skel/ret_case T Ce) :-
%   pi x\ pi x'\ (e2s/val x x' => e2s/comp (Ct x) (Ce x')),
%   exp/skel_val_ty A T.
% % OP CASE
% e2s/hand (exp/op_case O Ct Ht) (skel/op_case O Ce He):-
%   e2s/hand Ht He,
%   pi x\ pi x'\ pi k\ pi k'\ (
%     e2s/val x x' => e2s/val k k' =>
%     e2s/comp (Ct x k) (Ce x' k')).
% 
% % APP
% e2s/comp (exp/app V1t V2t) (skel/app V1e V2e) :-
%   e2s/val V1t V1e,
%   e2s/val V2t V2e.
% % LET
% e2s/comp (exp/let Vt Ct) (skel/let Ve Ce) :-
%   e2s/val Vt Ve,
%   pi x\ pi x'\ (e2s/val x x' => e2s/comp (Ct x) (Ce x')).
% % RETURN
% e2s/comp (exp/ret Vt) (skel/ret Ve) :-
%   e2s/val Vt Ve.
% % OP
% e2s/comp (exp/op O Vt At Ct) (skel/op O Ve Ae Ce) :-
%   e2s/val Vt Ve,
%   exp/skel_val_ty At Ae,
%   pi x\ pi x'\ (e2s/val x x' => e2s/comp (Ct x) (Ce x')).
% % DO
% e2s/comp (exp/do Ct1 Ct2) (skel/do Ce1 Ce2) :-
%   e2s/comp Ct1 Ce1,
%   pi x\ pi x'\ (e2s/val x x' => e2s/comp (Ct2 x) (Ce2 x')).
% % HANDLE
% e2s/comp (exp/with Ct Vt) (skel/with Ce Ve) :-
%   e2s/comp Ct Ce,
%   e2s/val Vt Ve.
% % COMPUTATION COERCION
% e2s/comp (exp/comp_cast Ct _) Ce :-
%   e2s/comp Ct Ce.
