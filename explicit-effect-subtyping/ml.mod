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
  pi x\ (ml/wf_ty (A x)).
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
  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/less_ty, ml/less_ty
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/less_ty ml/unit_ty ml/unit_ty.
ml/less_ty (ml/fun_ty A1 C1) (ml/fun_ty A2 C2) :-
  ml/less_ty A2 A1,
  ml/less_ty C1 C2.
ml/less_ty (ml/hand_ty A1 C1) (ml/hand_ty A2 C2) :-
  ml/less_ty A2 A1,
  ml/less_ty C1 C2.
ml/less_ty (ml/hand_ty A1 C1) (ml/fun_ty A2 C2) :-
  ml/less_ty A2 A1,
  ml/less_ty (ml/comp_ty C1) C2.
ml/less_ty (ml/all_ty A1) (ml/all_ty A2) :-
  pi a\ ml/less_ty (A1 a) (A2 a).
ml/less_ty (ml/qual_ty Pi A1) (ml/qual_ty Pi A2) :-
  ml/less_ty A1 A2.

ml/less_ty (ml/comp_ty A1) (ml/comp_ty A2) :-
  ml/less_ty A1 A2.

ml/less_ty A1 (ml/comp_ty A2) :-
  ml/less_ty A1 A2.
ml/less_ty (ml/comp_ty A1) A2 :-
  ml/less_ty A1 A2.

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
ml/of_coer' (ml/pure_coer Y) (ml/ty_coer_ty A1 A2) :-
  ml/of_coer Y (ml/ty_coer_ty (ml/comp_ty A1) (ml/comp_ty A2)).
ml/of_coer' (ml/nruter_coer Y) (ml/ty_coer_ty A1 A2) :-
  ml/of_coer Y (ml/ty_coer_ty A1 (ml/comp_ty A2)).


ml/of_coer' (ml/compose_coer Y1 Y2) (ml/ty_coer_ty A1 A3) :-
  ml/of_coer Y1 (ml/ty_coer_ty A1 A2),
  ml/of_coer Y2 (ml/ty_coer_ty A2 A3).
ml/of_coer' (ml/refl_coer A) (ml/ty_coer_ty A A).
ml/of_coer' (ml/fun_coer Y1 Y2) (ml/ty_coer_ty (ml/fun_ty A1 B1) (ml/fun_ty A2 B2)) :-
  ml/of_coer Y1 (ml/ty_coer_ty A2 A1),
  ml/of_coer Y2 (ml/ty_coer_ty B1 B2).
ml/of_coer' (ml/hand_coer Y1 Y2) (ml/ty_coer_ty (ml/hand_ty B1 B1') (ml/hand_ty B2 B2')) :-
  ml/of_coer Y1 (ml/ty_coer_ty (ml/comp_ty B2) (ml/comp_ty  B1)),
  ml/of_coer Y2 (ml/ty_coer_ty (ml/comp_ty B1') (ml/comp_ty B2')).
ml/of_coer' (ml/hand2fun_coer Y1 Y2) (ml/ty_coer_ty (ml/hand_ty B1 B1') (ml/fun_ty B2 B2')) :-
  ml/of_coer Y1 (ml/ty_coer_ty B2 B1),
  ml/of_coer Y2 (ml/ty_coer_ty (ml/comp_ty B1') B2').

ml/of_coer' (ml/left_coer Y) (ml/ty_coer_ty A2 A1) :-
  ml/of_coer Y (ml/ty_coer_ty (ml/fun_ty A1 _) (ml/fun_ty A2 _)).
ml/of_coer' (ml/left_coer Y) (ml/ty_coer_ty (ml/comp_ty B2) (ml/comp_ty B1)) :-
  ml/of_coer Y (ml/ty_coer_ty (ml/hand_ty B1 _) (ml/hand_ty B2 _)).
ml/of_coer' (ml/left_coer Y) (ml/ty_coer_ty B2 B1) :-
  ml/of_coer Y (ml/ty_coer_ty (ml/hand_ty (ml/comp_ty B1) _) (ml/fun_ty B2 _)).
ml/of_coer' (ml/right_coer Y) (ml/ty_coer_ty B1 B2) :-
  ml/of_coer Y (ml/ty_coer_ty (ml/fun_ty _ B1) (ml/fun_ty _ B2)).
ml/of_coer' (ml/right_coer Y) (ml/ty_coer_ty (ml/comp_ty B1) (ml/comp_ty B2)) :-
  ml/of_coer Y (ml/ty_coer_ty (ml/hand_ty _ B1) (ml/hand_ty _ B2)).
ml/of_coer' (ml/right_coer Y) (ml/ty_coer_ty (ml/comp_ty B1) B2) :-
  ml/of_coer Y (ml/ty_coer_ty (ml/hand_ty _ (ml/comp_ty B1)) (ml/fun_ty _ B2)).

ml/of_coer' (ml/app_ty_coer Y A) (ml/ty_coer_ty (A1 A) (A2 A)) :-
  ml/of_coer Y (ml/ty_coer_ty (ml/all_ty A1) (ml/all_ty A2)).
ml/of_coer' (ml/app_coer_coer Y1 Y2) (ml/ty_coer_ty A1 A2) :-
  ml/of_coer Y1 (ml/ty_coer_ty (ml/qual_ty Pi A1) (ml/qual_ty Pi A2)),
  ml/of_coer Y2 Pi.

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
  pi x\ (ml/of_term Sig (T x) (A x)).
ml/of_term' Sig (ml/app_ty T A1) (A2 A1) :-
  ml/of_term Sig T (ml/all_ty A2).
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
ml/val (ml/op O V _ M).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/result
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/result V :-
  ml/val V.
ml/result (ml/cast V Cv) :-
  ml/val V.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/result (more)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/result (ml/ret V) :-
  ml/val V.
ml/result (ml/cast (ml/ret V) Cc) :-
  ml/val V.
ml/result (ml/op O V _ C) :-
  ml/result V.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/step
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/step (ml/cast V C) (ml/cast V' C) :-
    ml/step V V'.
ml/step (ml/cast (ml/cast V Y1) Y2) (ml/cast V (ml/compose_coer Y1 Y2)) :-
    ml/result V.
ml/step (ml/app_ty V A) (ml/app_ty V' A) :-
    ml/step V V'.
ml/step (ml/app_coer V Y) (ml/app_coer V' Y) :-
    ml/step V V'.
% BROKEN DUE TO UNSAFE COERCE
% ml/step (ml/app_ty (ml/cast V Y) A) (ml/cast (ml/app_ty V A) (ml/app_ty_coer Y A)) :-
%     ml/val V.
% FIX:
ml/step (ml/app_ty (ml/cast (ml/lam_ty M) Y) A) (ml/cast (M A) (ml/app_ty_coer Y A)).
% BROKEN DUE TO UNSAFE COERCE
% ml/step (ml/app_coer (ml/cast V Y1) Y2) (ml/cast (ml/app_coer V Y2) (ml/app_coer_coer Y1 Y2)) :-
%     ml/val V.
% FIX:
ml/step (ml/app_coer (ml/cast (ml/lam_coer Pi M) Y1) Y2) (ml/cast (M Y2) (ml/app_coer_coer Y1 Y2)).
ml/step (ml/app_ty (ml/lam_ty M) A) (M A).
ml/step (ml/app_coer (ml/lam_coer Pi M) A) (M A).

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
% ml/step (more)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/step (ml/app V1 V2) (ml/app V1' V2) :-
    ml/step V1 V1'.
ml/step (ml/app V1 V2) (ml/app V1 V2') :-
    ml/val V1,
    ml/step V2 V2'.
ml/step (ml/app (ml/fun A M) V) (M V) :-
    ml/result V.
ml/step (ml/let V C) (ml/let V' C) :-
    ml/step V V'.
ml/step (ml/let V C) (C V) :-
    ml/result V.
ml/step (ml/ret V) (ml/ret V') :-
    ml/step V V'.
ml/step (ml/op O V B C) (ml/op O V' B C) :-
    ml/step V V'.
ml/step (ml/do C1 C2) (ml/do C1' C2) :-
    ml/step C1 C1'.
ml/step (ml/do (ml/cast (ml/ret V) Y) C2) (C2 (ml/cast V (ml/pure_coer Y))) :-
    ml/val V.
ml/step (ml/do (ml/ret V) C2) (C2 V) :-
    ml/val V.
ml/step (ml/do (ml/op O V B C1) C2) (ml/op O V B (y\ ml/do (C1 y) C2)) :-
    ml/result V.
ml/step (ml/with C V) (ml/with C V') :-
    ml/step V V'.
ml/step (ml/with C V) (ml/with C' V) :-
    ml/val V,
    ml/step C C'.
ml/step (ml/with (ml/ret V) (ml/hand H)) (Cr V) :-
    ml/val V,
    ml/get_ret_case H Cr.
ml/step (ml/with (ml/op O V B C) (ml/hand H)) (Cop V (ml/fun B (y\ ml/with (C y) (ml/hand H)))) :-
    ml/result V,
    ml/get_op_case H O B Cop.

ml/step (ml/cast V Y) (ml/cast V Y') :-
  ml/val V,
  ml/step_coer Y Y'.
ml/step (ml/cast V (ml/refl_coer A)) V :-
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
% BROKEN LIKE BEFORE?
% ml/step (ml/app (ml/cast V1 Vc) V2) (ml/cast (ml/app V1 (ml/cast V2 (ml/left_coer Vc))) (ml/right_coer Vc)) :-
%     ml/val V1.
% FIX:
ml/step (ml/app (ml/cast (ml/fun A M) Y) V2) (ml/cast (M (ml/cast V2 (ml/left_coer Y))) (ml/right_coer Y)).

% SLOW PROOF SEARCH
ml/step (ml/ret (ml/cast V Y)) (ml/cast (ml/ret V) (ml/comp_ty_coer Y)).
% PROBLEMATIC RULES -- TODO:
ml/step (ml/cast (ml/op O V B C) Y) (ml/op O V B (y\ ml/cast (C y) Y)) :-
    ml/result V.
ml/step (ml/with C (ml/cast V Y)) (ml/cast (ml/with (ml/cast C (ml/left_coer Y)) V) (ml/right_coer Y)) :-
    ml/val V.
ml/step (ml/with (ml/cast (ml/ret V) Y) (ml/hand H)) (Cr (ml/cast V (ml/pure_coer Y))) :-
    ml/val V,
    ml/get_ret_case H Cr.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/step_coer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/step_coer (ml/left_coer Y) (ml/left_coer Y') :-
  ml/step_coer Y Y'.
ml/step_coer (ml/left_coer (ml/refl_coer (ml/fun_ty A B))) (ml/refl_coer A).
ml/step_coer (ml/left_coer (ml/refl_coer (ml/hand_ty A B))) (ml/refl_coer (ml/comp_ty A)).
ml/step_coer (ml/left_coer (ml/fun_coer Y1 Y2)) Y1 :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/step_coer (ml/left_coer (ml/hand_coer Y1 Y2)) Y1 :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/step_coer  (ml/left_coer (ml/hand2fun_coer Y1 Y2)) Y1 :-
  ml/val_coer Y1,
  ml/val_coer Y2.

ml/step_coer (ml/right_coer Y) (ml/right_coer Y') :-
  ml/step_coer Y Y'.
ml/step_coer (ml/right_coer (ml/refl_coer (ml/fun_ty A B))) (ml/refl_coer B).
ml/step_coer (ml/right_coer (ml/refl_coer (ml/hand_ty A B))) (ml/refl_coer (ml/comp_ty B)).
ml/step_coer (ml/right_coer (ml/fun_coer Y1 Y2)) Y2 :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/step_coer (ml/right_coer (ml/hand_coer Y1 Y2)) Y2 :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/step_coer  (ml/right_coer (ml/hand2fun_coer Y1 Y2)) Y2 :-
  ml/val_coer Y1,
  ml/val_coer Y2.

ml/step_coer (ml/pure_coer Y) (ml/pure_coer Y') :-
  ml/step_coer Y Y'.
ml/step_coer (ml/pure_coer (ml/refl_coer (ml/comp_ty A))) (ml/refl_coer A).
ml/step_coer (ml/pure_coer (ml/comp_ty_coer Y)) Y :-
  ml/val_coer Y.
ml/step_coer (ml/pure_coer (ml/return_coer (ml/refl_coer (ml/comp_ty A)))) (ml/return_coer (ml/refl_coer A)).
ml/step_coer (ml/pure_coer (ml/return_coer (ml/comp_ty_coer Y))) (ml/pure_coer Y) :-
  ml/val_coer Y.
ml/step_coer (ml/pure_coer (ml/return_coer (ml/return_coer Y))) (ml/return_coer (ml/pure_coer (ml/return_coer Y))) :-
  ml/val_coer Y.
ml/step_coer (ml/pure_coer (ml/return_coer (ml/unsafe_coer Y))) Y :-
  ml/val_coer Y.
ml/step_coer (ml/pure_coer (ml/unsafe_coer (ml/refl_coer (ml/comp_ty A)))) (ml/unsafe_coer (ml/refl_coer A)).
ml/step_coer (ml/pure_coer (ml/unsafe_coer (ml/comp_ty_coer Y))) (ml/unsafe_coer Y) :-
  ml/val_coer Y.
ml/step_coer (ml/pure_coer (ml/unsafe_coer (ml/return_coer Y))) Y :-
  ml/val_coer Y.
ml/step_coer  (ml/pure_coer (ml/unsafe_coer (ml/unsafe_coer Y))) (ml/unsafe_coer (ml/pure_coer (ml/unsafe_coer Y))) :-
  ml/val_coer Y.
 
ml/step_coer (ml/nruter_coer Y) (ml/nruter_coer Y') :-
  ml/step_coer Y Y'.
ml/step_coer (ml/nruter_coer (ml/return_coer Y)) Y :-
  ml/val_coer Y.
ml/step_coer (ml/nruter_coer (ml/refl_coer (ml/comp_ty A))) (ml/unsafe_coer (ml/refl_coer A)).
ml/step_coer (ml/nruter_coer (ml/comp_ty_coer Y)) (ml/unsafe_coer Y) :-
  ml/val_coer Y.
ml/step_coer (ml/nruter_coer (ml/unsafe_coer Y)) (ml/unsafe_coer (ml/nruter_coer Y)) :-
  ml/val_coer Y.

ml/step_coer (ml/app_ty_coer Y A) (ml/app_ty_coer Y' A) :-
  ml/step_coer Y Y'.
ml/step_coer (ml/app_ty_coer (ml/refl_coer (ml/all_ty B)) A) (ml/refl_coer (B A)).

ml/step_coer (ml/app_coer_coer Y1 Y2) (ml/app_coer_coer Y1' Y2) :-
  ml/step_coer Y1 Y1'.
ml/step_coer (ml/app_coer_coer (ml/refl_coer (ml/qual_ty Pi A)) Y2) (ml/refl_coer A).

ml/step_coer (ml/compose_coer Y1 Y2) (ml/compose_coer Y1' Y2) :-
  ml/step_coer Y1 Y1'.
ml/step_coer (ml/compose_coer Y1 Y2) (ml/compose_coer Y1 Y2') :-
  ml/step_coer Y2 Y2'.
ml/step_coer (ml/compose_coer (ml/refl_coer _) Y) Y :-
  ml/val_coer Y.
ml/step_coer (ml/compose_coer (ml/fun_coer Y1 Y2) (ml/refl_coer _)) (ml/fun_coer Y1 Y2) :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/step_coer (ml/compose_coer (ml/fun_coer Y1 Y2) (ml/fun_coer Y3 Y4)) (ml/fun_coer (ml/compose_coer Y3 Y1) (ml/compose_coer Y2 Y4)) :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/step_coer (ml/compose_coer (ml/fun_coer Y1 Y2) (ml/return_coer Y3)) (ml/return_coer (ml/compose_coer (ml/fun_coer Y1 Y2) Y3)) :-
  ml/val_coer Y1,
  ml/val_coer Y2,
  ml/val_coer Y3.
ml/step_coer (ml/compose_coer (ml/hand_coer Y1 Y2) (ml/refl_coer _)) (ml/hand_coer Y1 Y2) :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/step_coer (ml/compose_coer (ml/hand_coer Y1 Y2) (ml/hand_coer Y3 Y4)) (ml/hand_coer (ml/compose_coer Y3 Y1) (ml/compose_coer Y2 Y4)) :-
  ml/val_coer Y1,
  ml/val_coer Y2,
  ml/val_coer Y3,
  ml/val_coer Y4.
ml/step_coer (ml/compose_coer (ml/hand_coer Y1 Y2) (ml/hand2fun_coer Y3 Y4)) (ml/hand2fun_coer (ml/pure_coer (ml/compose_coer Y3 Y1)) (ml/compose_coer Y2 Y4)) :-
  ml/val_coer Y1,
  ml/val_coer Y2,
  ml/val_coer Y3,
  ml/val_coer Y4.
ml/step_coer (ml/compose_coer (ml/hand_coer Y1 Y2) (ml/return_coer Y3)) (ml/return_coer (ml/compose_coer (ml/hand_coer Y1 Y2) Y3)) :-
  ml/val_coer Y1,
  ml/val_coer Y2,
  ml/val_coer Y3.
ml/step_coer (ml/compose_coer (ml/hand2fun_coer Y1 Y2) (ml/refl_coer _)) (ml/hand2fun_coer Y1 Y2) :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/step_coer (ml/compose_coer (ml/hand2fun_coer Y1 Y2) (ml/fun_coer Y3 Y4)) (ml/hand2fun_coer (ml/compose_coer Y3 Y1) (ml/compose_coer Y2 Y4)) :-
  ml/val_coer Y1,
  ml/val_coer Y2,
  ml/val_coer Y3,
  ml/val_coer Y4.
ml/step_coer (ml/compose_coer (ml/hand2fun_coer Y1 Y2) (ml/return_coer Y3)) (ml/return_coer (ml/compose_coer (ml/hand2fun_coer Y1 Y2) Y3)) :-
  ml/val_coer Y1,
  ml/val_coer Y2,
  ml/val_coer Y3.
ml/step_coer (ml/compose_coer (ml/comp_ty_coer Y) (ml/refl_coer A)) (ml/comp_ty_coer Y) :-
  ml/val_coer Y.
ml/step_coer (ml/compose_coer (ml/comp_ty_coer Y1) (ml/comp_ty_coer Y2)) (ml/comp_ty_coer (ml/compose_coer Y1 Y2)) :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/step_coer (ml/compose_coer (ml/comp_ty_coer Y1) (ml/return_coer Y2)) (ml/return_coer (ml/compose_coer (ml/comp_ty_coer Y1) Y2)) :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/step_coer (ml/compose_coer (ml/comp_ty_coer Y1) (ml/unsafe_coer Y2)) (ml/unsafe_coer (ml/compose_coer Y1 Y2)) :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/step_coer (ml/compose_coer (ml/return_coer Y) (ml/refl_coer A)) (ml/return_coer Y) :-
  ml/val_coer Y.
ml/step_coer (ml/compose_coer (ml/return_coer Y1) (ml/comp_ty_coer Y2)) (ml/return_coer (ml/compose_coer Y1 Y2)) :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/step_coer (ml/compose_coer (ml/return_coer Y1) (ml/return_coer Y2)) (ml/return_coer (ml/compose_coer Y1 (ml/return_coer Y2))) :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/step_coer (ml/compose_coer (ml/return_coer Y1) (ml/unsafe_coer Y2)) (ml/compose_coer Y1 Y2) :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/step_coer (ml/compose_coer (ml/unsafe_coer Y1) Y2) (ml/unsafe_coer (ml/compose_coer Y1 Y2)) :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/step_coer (ml/fun_coer Y1 Y2)       (ml/fun_coer Y1' Y2) :-
  ml/step_coer Y1 Y1'.
ml/step_coer (ml/fun_coer Y1 Y2)       (ml/fun_coer Y1 Y2') :-
  ml/step_coer Y2 Y2'.
ml/step_coer (ml/hand_coer Y1 Y2)      (ml/hand_coer Y1' Y2) :-
  ml/step_coer Y1 Y1'.
ml/step_coer (ml/hand_coer Y1 Y2)      (ml/hand_coer Y1' Y2) :-
  ml/step_coer Y2 Y2'.
ml/step_coer (ml/hand2fun_coer Y1 Y2)  (ml/hand2fun_coer Y1' Y2) :-
  ml/step_coer Y1 Y1'.
ml/step_coer (ml/hand2fun_coer Y1 Y2)  (ml/hand2fun_coer Y1 Y2') :-
  ml/step_coer Y2 Y2'.
ml/step_coer (ml/comp_ty_coer Y)       (ml/comp_ty_coer Y') :-
  ml/step_coer Y Y'.
ml/step_coer (ml/return_coer Y)        (ml/return_coer Y') :-
  ml/step_coer Y Y'.
ml/step_coer (ml/unsafe_coer Y)        (ml/unsafe_coer Y') :-
  ml/step_coer Y Y'.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/progress
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/val_coer (ml/refl_coer _).
ml/val_coer (ml/fun_coer Y1 Y2) :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/val_coer (ml/hand_coer Y1 Y2) :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/val_coer (ml/hand2fun_coer Y1 Y2) :-
  ml/val_coer Y1,
  ml/val_coer Y2.
ml/val_coer (ml/comp_ty_coer Y) :-
  ml/val_coer Y.
ml/val_coer (ml/return_coer Y) :-
  ml/val_coer Y.
ml/val_coer (ml/unsafe_coer Y) :-
  ml/val_coer Y.

ml/progress_coer Y :-
  ml/val_coer Y.
ml/progress_coer Y :-
  ml/step_coer Y Y'.

ml/progress V :-
    ml/result V.
ml/progress V :-
    ml/step V V'.
