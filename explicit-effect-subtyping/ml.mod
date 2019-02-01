module ml.
accumulate common.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/wf_ty, ml/wf_coer_ty
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/wf_ty ml/unit_ty.
ml/wf_ty (ml/fun_ty A B) :-
  ml/wf_ty A,
  ml/wf_ty B.
ml/wf_ty (ml/all_ty A) :-
  pi x\ (ml/wf_ty x => ml/wf_ty (A x)).
ml/wf_ty (ml/hand_ty A B) :-
  ml/wf_ty A,
  ml/wf_ty B.
ml/wf_ty (ml/qual_ty Pi A) :-
  ml/wf_coer_ty Pi,
  ml/wf_ty A.
ml/wf_ty (ml/comp_ty A) :-
  ml/wf_ty A.

ml/wf_coer_ty (ml/ty_coer_ty A B) :-
  ml/wf_ty A,
  ml/wf_ty B.
  

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ml/less_ty, ml/less_ty
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ml/less_ty ml/unit_ty ml/unit_ty.
% ml/less_ty (ml/fun_ty A1 C1) (ml/fun_ty A2 C2) :-
%   ml/less_ty A2 A1,
%   ml/less_ty C1 C2.
% ml/less_ty (ml/hand_ty A1 C1) (ml/hand_ty A2 C2) :-
%   ml/less_ty A2 A1,
%   ml/less_ty C1 C2.
% ml/less_ty (ml/hand_ty A1 C1) (ml/fun_ty A2 C2) :-
%   ml/less_ty A2 A1,
%   ml/less_ty (ml/comp_ty C1) C2.
% ml/less_ty (ml/all_ty A1) (ml/all_ty A2) :-
%   pi a\ ml/less_ty (A1 a) (A2 a).
% ml/less_ty (ml/qual_ty Pi A1) (ml/qual_ty Pi A2) :-
%   ml/less_ty A1 A2.
% 
% ml/less_ty (ml/comp_ty A1) (ml/comp_ty A2) :-
%   ml/less_ty A1 A2.
% 
% ml/less_ty A1 (ml/comp_ty A2) :-
%   ml/less_ty A1 A2.
% ml/less_ty (ml/comp_ty A1) A2 :-
%   ml/less_ty A1 A2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/of_op
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/of_op (ml/cons_sig O A B Sig) O A B :-
  ml/wf_ty A,
  ml/wf_ty B.
ml/of_op (ml/cons_sig O1 A1 B1 Sig) O2 A2 B2 :-
    ml/of_op Sig O2 A2 B2,
    apart O1 O2.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ml/skel_val_ty, ml/skel_comp_ty
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ml/skel_val_ty ml/unit_ty unit_skel.
% ml/skel_val_ty (ml/fun_ty A B) (fun_skel S1 S2) :-
%   ml/skel_val_ty A S1,
%   ml/skel_comp_ty B S2.
% ml/skel_val_ty (ml/hand_ty B1 B2) (hand_skel S1 S2) :-
%   ml/skel_comp_ty B1 S1,
%   ml/skel_comp_ty B2 S2.
% ml/skel_val_ty (ml/all_skel A) (all_skel S) :-
%   pi s\ ml/skel_val_ty (A s) (S s).
% ml/skel_val_ty (ml/all_ty S A) T :-
%   pi a\ ml/skel_val_ty a S => ml/skel_val_ty (A a) T.
% ml/skel_val_ty (ml/all_dirt A) S :-
%   pi d\ ml/skel_val_ty (A d) S.
% ml/skel_val_ty (ml/qual_ty _ A) S :-
%   ml/skel_val_ty A S.
% 
% ml/skel_comp_ty (ml/bang A _) S :-
%   ml/skel_val_ty A S.
% 
% ml/good_coer_ty (ml/ty_coer_ty A1 A2) :-
%   ml/skel_val_ty A1 S,
%   ml/skel_val_ty A2 S.
% ml/good_coer_ty (ml/ty_coer_ty A1 A2) :-
%   ml/skel_comp_ty A1 S,
%   ml/skel_comp_ty A2 S.
% ml/good_coer_ty (ml/dirt_coer_ty D1 D2).
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/of_coer, ml/of_coer'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/of_coer Y Pi :-
  ml/wf_coer_ty Pi,
  ml/of_coer' Y Pi.

ml/of_coer' (ml/comp_ty_coer Y) (ml/ty_coer_ty (ml/comp_ty A1) (ml/comp_ty A2)) :-
  ml/of_coer Y (ml/ty_coer_ty A1 A2).
ml/of_coer' (ml/return_coer Y) (ml/ty_coer_ty A1 (ml/comp_ty A2)) :-
  ml/of_coer Y (ml/ty_coer_ty A1 A2).
ml/of_coer' (ml/unsafe_coer Y) (ml/ty_coer_ty (ml/comp_ty A1) A2) :-
  ml/of_coer Y (ml/ty_coer_ty A1 A2).

ml/of_coer' (ml/unit_refl_coer) (ml/ty_coer_ty ml/unit_ty ml/unit_ty).
ml/of_coer' (ml/fun_coer Y1 Y2) (ml/ty_coer_ty (ml/fun_ty A1 B1) (ml/fun_ty A2 B2)) :-
  ml/of_coer Y1 (ml/ty_coer_ty A2 A1),
  ml/of_coer Y2 (ml/ty_coer_ty B1 B2).
ml/of_coer' (ml/hand_coer Y1 Y2) (ml/ty_coer_ty (ml/hand_ty B1 B1') (ml/hand_ty B2 B2')) :-
  ml/of_coer Y1 (ml/ty_coer_ty (ml/comp_ty B2) (ml/comp_ty  B1)),
  ml/of_coer Y2 (ml/ty_coer_ty (ml/comp_ty B1') (ml/comp_ty B2')).
ml/of_coer' (ml/hand2fun_coer Y1 Y2) (ml/ty_coer_ty (ml/hand_ty B1 B1') (ml/fun_ty B2 B2')) :-
  ml/of_coer Y1 (ml/ty_coer_ty B2 B1),
  ml/of_coer Y2 (ml/ty_coer_ty (ml/comp_ty B1') B2').

ml/of_coer' (ml/lam_ty_coer Y) (ml/ty_coer_ty (ml/all_ty A) (ml/all_ty B)) :-
  pi x\ (ml/wf_ty x => ml/of_coer (Y x) (ml/ty_coer_ty (A x) (B x))).
ml/of_coer' (ml/lam_coer_coer Pi Y) (ml/ty_coer_ty (ml/qual_ty Pi A) (ml/qual_ty Pi B)) :-
  ml/of_coer Y (ml/ty_coer_ty A B).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/of_term
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/of_term Sig T A :-
  ml/wf_ty A,
  ml/of_term' Sig T A.
 
ml/of_term' Sig ml/unit ml/unit_ty.
ml/of_term' Sig (ml/fun A T) (ml/fun_ty A B) :-
  pi x\ (ml/of_term Sig x A => ml/of_term Sig (T x) B).
ml/of_term' Sig (ml/lam_ty T) (ml/all_ty A) :-
  pi x\ (ml/wf_ty x => ml/of_term Sig (T x) (A x)).
ml/of_term' Sig (ml/app_ty T A1) (A2 A1) :-
  ml/of_term Sig T (ml/all_ty A2),
  ml/wf_ty A1.
ml/of_term' Sig (ml/cast T Y) A2 :-
  ml/of_term Sig T A1,
  ml/of_coer Y (ml/ty_coer_ty A1 A2).
ml/of_term' Sig (ml/hand H) (ml/hand_ty A B) :-
  ml/of_hand Sig H A B.
ml/of_term' Sig (ml/lam_coer Pi T) (ml/qual_ty Pi A) :-
  pi w\ (ml/of_coer w Pi => ml/of_term Sig (T w) A).
ml/of_term' Sig (ml/app_coer T Y) A :-
  ml/of_term Sig T (ml/qual_ty Pi A),
  ml/of_coer Y Pi.

ml/of_hand Sig H A B :-
  ml/wf_ty A,
  ml/wf_ty B,
  ml/of_hand' Sig H A B.

ml/of_hand' Sig (ml/ret_case A1 T) A1 A2 :-
  pi x\ (ml/of_term Sig x A1 => ml/of_term Sig (T x) (ml/comp_ty A2)).
ml/of_hand' Sig (ml/op_case O T H) A B :-
  ml/of_hand Sig H A B,
  ml/of_op Sig O A1 A2,
  pi x\ pi k\ (ml/of_term Sig x A1 => ml/of_term Sig k (ml/fun_ty A2 (ml/comp_ty B)) => ml/of_term Sig (T x k) (ml/comp_ty B)),
  is_op O.

ml/of_term' Sig (ml/app T1 T2) B :-
  ml/of_term Sig T1 (ml/fun_ty A B),
  ml/of_term Sig T2 A.
ml/of_term' Sig (ml/let T C) B :-
  ml/of_term Sig T A,
  pi x\ (ml/of_term Sig x A => ml/of_term Sig (C x) B).
ml/of_term' Sig (ml/ret V) (ml/comp_ty A) :-
  ml/of_term Sig V A.
ml/of_term' Sig (ml/op O T A2 C) (ml/comp_ty A) :-
  ml/of_op Sig O A1 A2,
  ml/of_term Sig T A1,
  pi x\ (ml/of_term Sig x A2 => ml/of_term Sig (C x) (ml/comp_ty A)),
  is_op O.
ml/of_term' Sig (ml/do C1 C2) (ml/comp_ty A2) :-
  ml/of_term Sig C1 (ml/comp_ty A1),
  pi x\ (ml/of_term Sig x A1 => ml/of_term Sig (C2 x) (ml/comp_ty A2)).
ml/of_term' Sig (ml/with C T) (ml/comp_ty B2) :-
  ml/of_term Sig C (ml/comp_ty B1),
  ml/of_term Sig T (ml/hand_ty B1 B2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/val ml/unit.
ml/val (ml/hand H).
ml/val (ml/fun A M).
ml/val (ml/lam_ty M).
ml/val (ml/lam_coer Pi M).
ml/val (ml/cast V (ml/fun_coer Y1 Y2)) :-
  ml/val V.
ml/val (ml/cast V (ml/hand_coer Y1 Y2)) :-
  ml/val V.
ml/val (ml/cast V (ml/hand2fun_coer Y1 Y2)) :-
  ml/val V.
ml/val (ml/cast V (ml/lam_ty_coer Y)) :-
  ml/val V.
ml/val (ml/cast V (ml/lam_coer_coer Pi Y)) :-
  ml/val V.

ml/val (ml/ret V) :-
  ml/val V.
ml/val(ml/op O V _ C) :-
  ml/val V.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/step
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/step (ml/app V1 V2) (ml/app V1' V2) :-
    ml/step V1 V1'.
ml/step (ml/app V1 V2) (ml/app V1 V2') :-
    ml/val V1,
    ml/step V2 V2'.
ml/step (ml/app (ml/fun A M) V) (M V) :-
    ml/val V.

ml/step (ml/app_ty V A) (ml/app_ty V' A) :-
    ml/step V V'.
ml/step (ml/app_ty (ml/lam_ty M) A) (M A).

ml/step (ml/app_coer V Y) (ml/app_coer V' Y) :-
    ml/step V V'.
ml/step (ml/app_coer (ml/lam_coer Pi M) Y) (M Y).

ml/step (ml/let V M) (ml/let V' M) :-
    ml/step V V'.
ml/step (ml/let V M) (M V) :-
    ml/val V.

ml/step (ml/ret V) (ml/ret V') :-
    ml/step V V'.

ml/step (ml/op O V B M) (ml/op O V' B M) :-
    ml/step V V'.

ml/step (ml/do V M) (ml/do V' M) :-
    ml/step V V'.
ml/step (ml/do (ml/ret V) M) (M V) :-
    ml/val V.
ml/step (ml/do (ml/op O V B M1) M2) (ml/op O V B (y\ ml/do (M1 y) M2)) :-
    ml/val V.

ml/step (ml/with C V) (ml/with C V') :-
    ml/step V V'.
ml/step (ml/with C V) (ml/with C' V) :-
    ml/val V,
    ml/step C C'.
ml/step (ml/with (ml/ret V) (ml/hand H)) (Cr V) :-
    ml/val V,
    ml/get_ret_case H Cr.
ml/step (ml/with (ml/op O V B C) (ml/hand H)) (Cop V (ml/fun B (y\ ml/with (C y) (ml/hand H)))) :-
    ml/val V,
    ml/get_op_case H O B Cop.

ml/step (ml/cast V C) (ml/cast V' C) :-
    ml/step V V'.

ml/step (ml/cast V ml/unit_refl_coer) V :-
  ml/val V. 
ml/step (ml/cast (ml/ret V) (ml/comp_ty_coer Y)) (ml/ret (ml/cast V Y)) :-
  ml/val V.
ml/step (ml/cast (ml/op O V A M) (ml/comp_ty_coer Y))
        (ml/op O V A (x\ (ml/cast (M x) (ml/comp_ty_coer Y)))) :-
  ml/val V.
ml/step (ml/cast V (ml/return_coer Y)) (ml/ret (ml/cast V Y)) :-
  ml/val V.
ml/step (ml/cast (ml/ret V) (ml/unsafe_coer Y)) (ml/cast V Y) :-
  ml/val V.

ml/step (ml/app (ml/cast V1 (ml/fun_coer Y1 Y2)) V2) (ml/cast (ml/app V1 (ml/cast V2 Y1)) Y2) :-
  ml/val V1.

ml/step (ml/with V1 (ml/cast V2 (ml/hand_coer Y1 Y2))) (ml/cast (ml/with (ml/cast V1 Y1) V2) Y2) :-
  ml/val V1,
  ml/val V2.

ml/step (ml/app (ml/cast V1 (ml/hand2fun_coer Y1 Y2)) V2) (ml/cast (ml/with (ml/ret (ml/cast V2 Y1)) V1) Y2) :-
  ml/val V1,
  ml/val V2.

ml/step (ml/app_ty (ml/cast V (ml/lam_ty_coer Y)) A) (ml/cast (ml/app_ty V A) (Y A)) :-
  ml/val V.

ml/step (ml/app_coer (ml/cast V (ml/lam_coer_coer _ Y1)) Y2) (ml/cast (ml/app_coer V Y2) Y1) :-
  ml/val V.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/get_ret_case
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/get_ret_case (ml/ret_case _ M) M.
ml/get_ret_case (ml/op_case _ _ H) M :-
    ml/get_ret_case H M.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/get_op_case
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/get_op_case (ml/op_case O M H) O _ M :-
    is_op O.
ml/get_op_case (ml/op_case O' _ H) O A M :-
    apart O O',
    ml/get_op_case H O A M.
ml/get_op_case (ml/ret_case _ _) O A (x\ k\ ml/op O x A (y\ ml/app k y)).
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/stuck
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/stuck (ml/cast (ml/op O V B C) (ml/unsafe_coer Y)) :-
    ml/val V.
ml/stuck (ml/app_ty V A) :-
    ml/stuck V.
ml/stuck (ml/cast V Y) :-
  ml/stuck V.
ml/stuck (ml/app_coer V Y) :-
  ml/stuck V.
ml/stuck (ml/app V1 V2) :-
  ml/val V1,
  ml/stuck V2.
ml/stuck (ml/app V1 V2) :-
  ml/stuck V1.
ml/stuck (ml/let V M) :-
  ml/stuck V.
ml/stuck (ml/ret V) :-
  ml/stuck V.
ml/stuck (ml/op O V A M) :-
  ml/stuck V.
ml/stuck (ml/do V M) :-
  ml/stuck V.
ml/stuck (ml/with V1 V2) :-
  ml/stuck V2.
ml/stuck (ml/with V1 V2) :-
  ml/val V2,
  ml/stuck V1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/progress
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/progress V :-
    ml/val V.
ml/progress V :-
    ml/step V V'.
ml/progress V :-
    ml/stuck V.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/converges, ml/normal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/converges V :-
  ml/val V.
ml/converges V :-
  ml/step V V',
  ml/converges V'.

ml/normal V ml/unit_ty :-
    ml/converges V.
ml/normal V (ml/fun_ty _ _) :-
    ml/converges V.
ml/normal V (ml/hand_ty _ _) :-
    ml/converges V.
ml/normal V (ml/comp_ty _) :-
    ml/converges V.
ml/normal V (ml/all_ty A) :-
    ml/converges V,
    pi t\ ml/wf_ty t => ml/normal (ml/app_ty V t) (A t).
ml/normal V (ml/qual_ty (ml/ty_coer_ty A1 A2) A) :-
    ml/converges V,
    ml/wf_ty A1,
    ml/wf_ty A2,
    pi w\ ml/of_coer w (ml/ty_coer_ty A1 A2) => ml/normal (ml/app_coer V w) A.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Logical Relations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/lr_val Sig A V1 V2 :-
  ml/val V1,
  ml/val V2,
  ml/of_term Sig V1 A,
  ml/of_term Sig V2 A,
  ml/lr_val' Sig A V1 V2.

ml/lr_val' Sig ml/unit_ty ml/unit ml/unit.
ml/lr_val' Sig (ml/fun_ty A B) V1 V2 :-
  pi x1\ pi x2\  ml/lr_val Sig A x1 x2 => ml/lr_exp Sig B (ml/app V1 x1) (ml/app V2 x2).
ml/lr_val' Sig (ml/all_ty T) V1 V2 :-
  pi a\ ml/lr_exp Sig (T a) (ml/app_ty V1 a) (ml/app_ty V2 a).
ml/lr_val' Sig (ml/hand_ty A B) V1 V2 :-
  pi x1\ pi x2\ ml/lr_val Sig (ml/comp_ty A) x1 x2 => ml/lr_exp Sig (ml/comp_ty B) (ml/with x1 V1) (ml/with x2 V2).
ml/lr_val' Sig (ml/qual_ty Pi A) V1 V2 :-
  pi y\ ml/of_coer Y Pi => ml/lr_exp Sig A (ml/app_coer V1 y) (ml/app_coer V2 y).
ml/lr_val' Sig (ml/comp_ty A) (ml/ret V1) (ml/ret V2) :-
  ml/lr_val Sig A V1 V2.
ml/lr_val' Sig (ml/comp_ty A) (ml/op O V11 B2 V12) (ml/op O V21 B2 V22) :-
  ml/of_op Sig O B1 B2,
  ml/lr_val Sig B1 V11 V21,
  pi x1\ pi x2\ ml/lr_val Sig B2 x1 x2 => ml/lr_exp Sig (ml/comp_ty A) (V12 x1) (V22 x2).

ml/lr_exp Sig A V1 V2 :-
  ml/of_term Sig V1 A,
  ml/of_term Sig V2 A,
  ml/steps V1 V1',
  ml/steps V2 V2',
  ml/lr_val Sig A V1' V2'.
