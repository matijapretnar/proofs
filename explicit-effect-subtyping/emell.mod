module emell.
accumulate common.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ml/less_val_ty, ml/less_comp_ty
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ml/less_val_ty ml/unit_ty ml/unit_ty.
% ml/less_val_ty (ml/fun_ty A1 C1) (ml/fun_ty A2 C2) :-
%   ml/less_val_ty A2 A1,
%   ml/less_comp_ty C1 C2.
% ml/less_val_ty (ml/hand_ty A1 C1) (ml/hand_ty A2 C2) :-
%   ml/less_comp_ty A2 A1,
%   ml/less_comp_ty C1 C2.
% ml/less_val_ty (ml/all_ty S A1) (ml/all_ty S A2) :-
%   pi a\ ml/less_val_ty (A1 a) (A2 a).
% ml/less_val_ty (ml/all_dirt A1) (ml/all_dirt A2) :-
%   pi a\ ml/less_val_ty (A1 a) (A2 a).
% ml/less_val_ty (ml/all_skel A1) (ml/all_skel A2) :-
%   pi a\ ml/less_val_ty (A1 a) (A2 a).
% ml/less_val_ty (ml/qual_ty Pi A1) (ml/qual_ty Pi A2) :-
%   ml/less_val_ty A1 A2.
% 
% ml/less_comp_ty (ml/bang A1 D1) (ml/bang A2 D2) :-
%   ml/less_val_ty A1 A2,
%   less_dirt D1 D2.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/of_op
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ml/of_op (ml/cons_sig O A B Sig) O A B.
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
% ml/good_coer_ty (ml/val_ty_coer_ty A1 A2) :-
%   ml/skel_val_ty A1 S,
%   ml/skel_val_ty A2 S.
% ml/good_coer_ty (ml/comp_ty_coer_ty A1 A2) :-
%   ml/skel_comp_ty A1 S,
%   ml/skel_comp_ty A2 S.
% ml/good_coer_ty (ml/dirt_coer_ty D1 D2).
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ml/of_coer
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ml/of_coer (ml/compose_coer Y1 Y2) (ml/val_ty_coer_ty A1 A3) :-
%   ml/of_coer Y1 (ml/val_ty_coer_ty A1 A2),
%   ml/of_coer Y2 (ml/val_ty_coer_ty A2 A3).
% ml/of_coer (ml/compose_coer Y1 Y2) (ml/dirt_coer_ty D1 D3) :-
%   ml/of_coer Y1 (ml/dirt_coer_ty D1 D2),
%   ml/of_coer Y2 (ml/dirt_coer_ty D2 D3).
% ml/of_coer (ml/compose_coer Y1 Y2) (ml/comp_ty_coer_ty B1 B3) :-
%   ml/of_coer Y1 (ml/comp_ty_coer_ty B1 B2),
%   ml/of_coer Y2 (ml/comp_ty_coer_ty B2 B3).
% 
% % ml/of_coer (ml/val_ty_coer A) (ml/val_ty_coer_ty A A).
% ml/of_coer (ml/fun_coer Y1 Y2) (ml/val_ty_coer_ty (ml/fun_ty A1 B1) (ml/fun_ty A2 B2)) :-
%   ml/of_coer Y1 (ml/val_ty_coer_ty A2 A1),
%   ml/of_coer Y2 (ml/comp_ty_coer_ty B1 B2).
% ml/of_coer (ml/hand_coer Y1 Y2) (ml/val_ty_coer_ty (ml/hand_ty B1 B1') (ml/hand_ty B2 B2')) :-
%   ml/of_coer Y1 (ml/comp_ty_coer_ty B2 B1),
%   ml/of_coer Y2 (ml/comp_ty_coer_ty B1' B2').
% 
% ml/of_coer (ml/left_coer Y) (ml/val_ty_coer_ty A2 A1) :-
%   ml/of_coer Y (ml/val_ty_coer_ty (ml/fun_ty A1 _) (ml/fun_ty A2 _)).
% ml/of_coer (ml/left_coer Y) (ml/comp_ty_coer_ty B2 B1) :-
%   ml/of_coer Y (ml/val_ty_coer_ty (ml/hand_ty B1 _) (ml/hand_ty B2 _)).
% ml/of_coer (ml/right_coer Y) (ml/comp_ty_coer_ty B1 B2) :-
%   ml/of_coer Y (ml/val_ty_coer_ty (ml/fun_ty _ B1) (ml/fun_ty _ B2)).
% ml/of_coer (ml/right_coer Y) (ml/comp_ty_coer_ty B1 B2) :-
%   ml/of_coer Y (ml/val_ty_coer_ty (ml/hand_ty _ B1) (ml/hand_ty _ B2)).
% 
% ml/of_coer (ml/app_skel_coer Y S) (ml/val_ty_coer_ty (A1 S) (A2 S)) :-
%   ml/of_coer Y (ml/val_ty_coer_ty (ml/all_skel A1) (ml/all_skel A2)).
% ml/of_coer (ml/app_ty_coer Y A) (ml/val_ty_coer_ty (A1 A) (A2 A)) :-
%   ml/of_coer Y (ml/val_ty_coer_ty (ml/all_ty S A1) (ml/all_ty S A2)),
%   ml/skel_val_ty A S.
% ml/of_coer (ml/app_dirt_coer Y D) (ml/val_ty_coer_ty (A1 D) (A2 D)) :-
%   ml/of_coer Y (ml/val_ty_coer_ty (ml/all_dirt A1) (ml/all_dirt A2)).
% ml/of_coer (ml/app_coer_coer Y1 Y2) (ml/val_ty_coer_ty A1 A2) :-
%   ml/of_coer Y1 (ml/val_ty_coer_ty (ml/qual_ty Pi A1) (ml/qual_ty Pi A2)),
%   ml/of_coer Y2 Pi.
% 
% ml/of_coer (ml/comp_ty_coer Y1 Y2) (ml/comp_ty_coer_ty (ml/bang A1 D1) (ml/bang A2 D2)) :-
%   ml/of_coer Y1 (ml/val_ty_coer_ty A1 A2),
%   ml/of_coer Y2 (ml/dirt_coer_ty D1 D2).
% ml/of_coer (ml/pure_coer Y) (ml/val_ty_coer_ty A1 A2) :-
%   ml/of_coer Y (ml/comp_ty_coer_ty (ml/bang A1 _) (ml/bang A2 _)).
% ml/of_coer (ml/impure_coer Y) (ml/dirt_coer_ty D1 D2) :-
%   ml/of_coer Y (ml/comp_ty_coer_ty (ml/bang _ D1) (ml/bang _ D2)).
% 
% ml/of_coer (ml/dirt_coer D) (ml/dirt_coer_ty D D) :-
%   is_dirt D.
% ml/of_coer (ml/empty_coer D) (ml/dirt_coer_ty empty D).
% ml/of_coer (ml/cons_coer O Y) (ml/dirt_coer_ty (cons O D1) (cons O D2)) :-
%   ml/of_coer Y (ml/dirt_coer_ty D1 D2).
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ml/of_term
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
ml/of_term Sig ml/unit ml/unit_ty.
ml/of_term Sig (ml/fun A C) (ml/fun_ty A B) :-
  pi x\ (ml/of_term Sig x A => ml/of_term Sig (C x) B).
ml/of_term Sig (ml/lam_ty V) (ml/all_ty A) :-
  pi x\ (ml/of_term Sig (V x) (A x)).
ml/of_term Sig (ml/app_ty V A1) (A2 A1) :-
  ml/of_term Sig V (ml/all_ty A2).
ml/of_term Sig (ml/cast V Y) A2 :-
  ml/of_term Sig V A1,
  ml/of_coer Y (ml/ty_coer_ty A1 A2).
ml/of_term Sig (ml/lam_coer Pi V) (ml/qual_ty Pi A) :-
  pi w\ (ml/of_coer w Pi => ml/of_term Sig (V w) A).
  % ml/good_coer_ty Pi.
ml/of_term Sig (ml/app_coer V Y) A :-
  ml/of_term Sig V (ml/qual_ty Pi A),
  ml/of_coer Y Pi.

ml/of_term Sig (ml/app V1 V2) B :-
  ml/of_term Sig V1 (ml/fun_ty A B),
  ml/of_term Sig V2 A.
ml/of_term Sig (ml/let V C) B :-
  ml/of_term Sig V A,
  pi x\ (ml/of_term Sig x A => ml/of_term Sig (C x) B).
ml/of_term Sig (ml/op O V A2 C) (ml/comp_ty A) :-
  ml/of_op Sig O A1 A2,
  ml/of_term Sig V A1,
  pi x\ (ml/of_term Sig x A2 => ml/of_term Sig (C x) (ml/comp_ty A)),
  is_op O.
ml/of_term Sig (ml/do C1 C2) (ml/comp_ty A2) :-
  ml/of_term Sig C1 (ml/comp_ty A1),
  pi x\ (ml/of_term Sig x A1 => ml/of_term Sig (C2 x) (ml/comp_ty A2)).
ml/of_term Sig (ml/with C V) B2 :-
  ml/of_term Sig C (ml/comp_ty B1),
  ml/of_term Sig V (ml/hand_ty B1 B2).

ml/of_term Sig (ml/hand H) (ml/hand_ty A B) :-
  ml/of_hand Sig H A B.

ml/of_hand Sig (ml/ret_case A1 C) A1 A2 :-
  pi x\ (ml/of_term Sig x A1 => ml/of_term Sig (C x) A2).
ml/of_hand Sig (ml/op_case O C H) A B :-
  ml/of_hand Sig H A B,
  ml/of_op Sig O A1 A2,
  pi x\ pi k\ (ml/of_term Sig x A1 => ml/of_term Sig k (ml/fun_ty A2 B) => ml/of_term Sig (C x k) B),
  is_op O.
 
 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ml/term_val
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ml/term_val ml/unit.
% ml/term_val (ml/hand H).
% ml/term_val (ml/fun A M).
% ml/term_val (ml/lam_ty S M).
% ml/term_val (ml/lam_skel M).
% ml/term_val (ml/lam_dirt M).
% ml/term_val (ml/lam_coer Pi M).
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ml/result_val
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ml/result_val V :-
%   ml/term_val V.
% ml/result_val (ml/val_cast V Cv) :-
%   ml/term_val V.
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ml/result_comp
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ml/result_comp (ml/ret V) :-
%   ml/term_val V.
% ml/result_comp (ml/comp_cast (ml/ret V) Cc) :-
%   ml/term_val V.
% ml/result_comp (ml/op O V _ C) :-
%   ml/result_val V.
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ml/step_val
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ml/step_val (ml/val_cast V C) (ml/val_cast V' C) :-
%     ml/step_val V V'.
% ml/step_val (ml/val_cast (ml/val_cast V C1) C2) (ml/val_cast V (ml/compose_coer C1 C2)) :-
%     ml/result_val V.
% ml/step_val (ml/app_skel V A) (ml/app_skel V' A) :-
%     ml/step_val V V'.
% ml/step_val (ml/app_ty V A) (ml/app_ty V' A) :-
%     ml/step_val V V'.
% ml/step_val (ml/app_dirt V A) (ml/app_dirt V' A) :-
%     ml/step_val V V'.
% ml/step_val (ml/app_coer V A) (ml/app_coer V' A) :-
%     ml/step_val V V'.
% ml/step_val (ml/app_skel (ml/val_cast V Y) A) (ml/val_cast (ml/app_skel V A) (ml/app_skel_coer Y A)) :-
%     ml/term_val V.
% ml/step_val (ml/app_ty (ml/val_cast V Y) A) (ml/val_cast (ml/app_ty V A) (ml/app_ty_coer Y A)) :-
%     ml/term_val V.
% ml/step_val (ml/app_dirt (ml/val_cast V Y) A) (ml/val_cast (ml/app_dirt V A) (ml/app_dirt_coer Y A)) :-
%     ml/term_val V.
% ml/step_val (ml/app_coer (ml/val_cast V Y) A) (ml/val_cast (ml/app_coer V A) (ml/app_coer_coer Y A)) :-
%     ml/term_val V.
% ml/step_val (ml/app_skel (ml/lam_skel M) S) (M S).
% ml/step_val (ml/app_ty (ml/lam_ty S M) A) (M A) :-
%     ml/skel_val_ty A S.
% ml/step_val (ml/app_dirt (ml/lam_dirt M) A) (M A).
% ml/step_val (ml/app_coer (ml/lam_coer Pi M) A) (M A).
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ml/get_ret_case
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ml/get_ret_case (ml/ret_case _ M) M.
% ml/get_ret_case (ml/op_case _ _ H) M :-
%     ml/get_ret_case H M.
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ml/get_op_case
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ml/get_op_case (ml/ret_case _ _) O A (x\ k\ ml/op O x A (y\ ml/app k y)).
% ml/get_op_case (ml/op_case O M H) O _ M :-
%     is_op O.
% ml/get_op_case (ml/op_case O' _ H) O A M :-
%     apart O O',
%     ml/get_op_case H O A M.
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ml/step_comp
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ml/step_comp (ml/comp_cast C Y) (ml/comp_cast C' Y) :-
%     ml/step_comp C C'.
% ml/step_comp (ml/comp_cast (ml/comp_cast C Y1) Y2) (ml/comp_cast C (ml/compose_coer Y1 Y2)) :-
%     ml/result_comp C.
% ml/step_comp (ml/app V1 V2) (ml/app V1' V2) :-
%     ml/step_val V1 V1'.
% ml/step_comp (ml/app (ml/val_cast V1 Vc) V2) (ml/comp_cast (ml/app V1 (ml/val_cast V2 (ml/left_coer Vc))) (ml/right_coer Vc)) :-
%     ml/term_val V1.
% ml/step_comp (ml/app V1 V2) (ml/app V1 V2') :-
%     ml/term_val V1,
%     ml/step_val V2 V2'.
% ml/step_comp (ml/app (ml/fun A M) V) (M V) :-
%     ml/result_val V.
% ml/step_comp (ml/let V C) (ml/let V' C) :-
%     ml/step_val V V'.
% ml/step_comp (ml/let V C) (C V) :-
%     ml/result_val V.
% ml/step_comp (ml/ret V) (ml/ret V') :-
%     ml/step_val V V'.
% ml/step_comp (ml/ret (ml/val_cast V Y)) (ml/comp_cast (ml/ret V) (ml/comp_ty_coer Y (ml/empty_coer empty))).
% ml/step_comp (ml/op O V B C) (ml/op O V' B C) :-
%     ml/step_val V V'.
% ml/step_comp (ml/comp_cast (ml/op O V B C) Y) (ml/op O V B (y\ ml/comp_cast (C y) Y)) :-
%     ml/result_val V.
% ml/step_comp (ml/do C1 C2) (ml/do C1' C2) :-
%     ml/step_comp C1 C1'.
% ml/step_comp (ml/do (ml/comp_cast (ml/ret V) Y) C2) (C2 (ml/val_cast V (ml/pure_coer Y))) :-
%     ml/term_val V.
% ml/step_comp (ml/do (ml/ret V) C2) (C2 V) :-
%     ml/term_val V.
% ml/step_comp (ml/do (ml/op O V B C1) C2) (ml/op O V B (y\ ml/do (C1 y) C2)) :-
%     ml/result_val V.
% ml/step_comp (ml/with C V) (ml/with C V') :-
%     ml/step_val V V'.
% ml/step_comp (ml/with C (ml/val_cast V Y)) (ml/comp_cast (ml/with (ml/comp_cast C (ml/left_coer Y)) V) (ml/right_coer Y)) :-
%     ml/term_val V.
% ml/step_comp (ml/with C V) (ml/with C' V) :-
%     ml/term_val V,
%     ml/step_comp C C'.
% ml/step_comp (ml/with (ml/ret V) (ml/hand H)) (Cr V) :-
%     ml/term_val V,
%     ml/get_ret_case H Cr.
% ml/step_comp (ml/with (ml/comp_cast (ml/ret V) Y) (ml/hand H)) (Cr (ml/val_cast V (ml/pure_coer Y))) :-
%     ml/term_val V,
%     ml/get_ret_case H Cr.
% ml/step_comp (ml/with (ml/op O V B C) (ml/hand H)) (Cop V (ml/fun B (y\ ml/with (C y) (ml/hand H)))) :-
%     ml/result_val V,
%     ml/get_op_case H O B Cop.
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ml/progress_val
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ml/progress_val V :-
%     ml/result_val V.
% ml/progress_val V :-
%     ml/step_val V V'.
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ml/progress_comp
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% ml/progress_comp C :-
%     ml/result_comp C.
% ml/progress_comp C :-
%     ml/step_comp C C'.
