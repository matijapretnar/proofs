module exp.
accumulate common.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp/of_op
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp/of_op (exp/cons_sig O A B Sig) O A B.
exp/of_op (exp/cons_sig O1 A1 B1 Sig) O2 A2 B2 :-
    exp/of_op Sig O2 A2 B2,
    apart O1 O2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp/skel_val_ty, exp/skel_comp_ty
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp/skel_val_ty exp/unit_ty unit_skel.
exp/skel_val_ty (exp/fun_ty A B) (fun_skel S1 S2) :-
  exp/skel_val_ty A S1,
  exp/skel_comp_ty B S2.
exp/skel_val_ty (exp/hand_ty B1 B2) (hand_skel S1 S2) :-
  exp/skel_comp_ty B1 S1,
  exp/skel_comp_ty B2 S2.
exp/skel_val_ty (exp/all_skel A) (all_skel S) :-
  pi s\ exp/skel_val_ty (A s) (S s).
exp/skel_val_ty (exp/all_ty S A) T :-
  pi a\ exp/skel_val_ty a S => exp/skel_val_ty (A a) T.
exp/skel_val_ty (exp/all_dirt A) S :-
  pi d\ exp/skel_val_ty (A d) S.
exp/skel_val_ty (exp/qual_ty _ A) S :-
  exp/skel_val_ty A S.

exp/skel_comp_ty (exp/bang A _) S :-
  exp/skel_val_ty A S.

exp/good_coer_ty (exp/val_ty_coer_ty A1 A2) :-
  exp/skel_val_ty A1 S,
  exp/skel_val_ty A2 S.
exp/good_coer_ty (exp/comp_ty_coer_ty A1 A2) :-
  exp/skel_comp_ty A1 S,
  exp/skel_comp_ty A2 S.
exp/good_coer_ty (exp/dirt_coer_ty D1 D2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp/of_coer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp/of_coer exp/unit_refl_coer (exp/val_ty_coer_ty exp/unit_ty exp/unit_ty).
exp/of_coer (exp/fun_coer Y1 Y2) (exp/val_ty_coer_ty (exp/fun_ty A1 B1) (exp/fun_ty A2 B2)) :-
  exp/of_coer Y1 (exp/val_ty_coer_ty A2 A1),
  exp/of_coer Y2 (exp/comp_ty_coer_ty B1 B2).
exp/of_coer (exp/hand_coer Y1 Y2) (exp/val_ty_coer_ty (exp/hand_ty B1 B1') (exp/hand_ty B2 B2')) :-
  exp/of_coer Y1 (exp/comp_ty_coer_ty B2 B1),
  exp/of_coer Y2 (exp/comp_ty_coer_ty B1' B2').

exp/of_coer (exp/lam_skel_coer Y) (exp/val_ty_coer_ty (exp/all_skel A1) (exp/all_skel A2)) :-
  pi s\ exp/of_coer (Y s) (exp/val_ty_coer_ty (A1 s) (A2 s)).
exp/of_coer (exp/lam_ty_coer Y) (exp/val_ty_coer_ty (exp/all_ty S A1) (exp/all_ty S A2)) :-
  pi a\ exp/skel_val_ty a S => exp/of_coer (Y a) (exp/val_ty_coer_ty (A1 a) (A2 a)).
exp/of_coer (exp/lam_dirt_coer Y) (exp/val_ty_coer_ty (exp/all_dirt A1) (exp/all_dirt A2)) :-
  pi d\ exp/of_coer (Y d) (exp/val_ty_coer_ty (A1 d) (A2 d)).
exp/of_coer (exp/lam_coer_coer Pi Y) (exp/val_ty_coer_ty (exp/qual_ty Pi A1) (exp/qual_ty Pi A2)) :-
  exp/of_coer Y (exp/val_ty_coer_ty A1 A2).

exp/of_coer (exp/comp_ty_coer Y1 Y2) (exp/comp_ty_coer_ty (exp/bang A1 D1) (exp/bang A2 D2)) :-
  exp/of_coer Y1 (exp/val_ty_coer_ty A1 A2),
  exp/of_coer Y2 (exp/dirt_coer_ty D1 D2).

exp/of_coer (exp/dirt_coer D) (exp/dirt_coer_ty D D) :-
  is_dirt D.
exp/of_coer (exp/empty_coer D) (exp/dirt_coer_ty empty D).
exp/of_coer (exp/cons_coer O Y) (exp/dirt_coer_ty (cons O D1) (cons O D2)) :-
  exp/of_coer Y (exp/dirt_coer_ty D1 D2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp/of_val, exp/of_hand, exp/of_comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp/of_val Sig exp/unit exp/unit_ty.
exp/of_val Sig (exp/fun A C) (exp/fun_ty A B) :-
  pi x\ (exp/of_val Sig x A => exp/of_comp Sig (C x) B).
exp/of_val Sig (exp/hand H) (exp/hand_ty (exp/bang A D) B) :-
  exp/of_hand Sig H A D B.

exp/of_val Sig (exp/lam_skel V) (exp/all_skel A) :-
  pi s\ (exp/of_val Sig (V s) (A s)).
exp/of_val Sig (exp/app_skel V S) (A S) :-
  exp/of_val Sig V (exp/all_skel A).
exp/of_val Sig (exp/lam_ty S V) (exp/all_ty S A) :-
  pi x\ (exp/skel_val_ty x S => exp/of_val Sig (V x) (A x)).
exp/of_val Sig (exp/app_ty V A1) (A2 A1) :-
  exp/of_val Sig V (exp/all_ty S A2),
  exp/skel_val_ty A1 S.
exp/of_val Sig (exp/lam_dirt V) (exp/all_dirt A) :-
  pi d\ (exp/of_val Sig (V d) (A d)).
exp/of_val Sig (exp/app_dirt V D) (A D) :-
  exp/of_val Sig V (exp/all_dirt A).
exp/of_val Sig (exp/lam_coer Pi V) (exp/qual_ty Pi A) :-
  pi w\ (exp/of_coer w Pi => exp/of_val Sig (V w) A),
  exp/good_coer_ty Pi.
exp/of_val Sig (exp/app_coer V Y) A :-
  exp/of_val Sig V (exp/qual_ty Pi A),
  exp/of_coer Y Pi.

exp/of_val Sig (exp/val_cast V Y) A2 :-
  exp/of_val Sig V A1,
  exp/of_coer Y (exp/val_ty_coer_ty A1 A2).

exp/of_hand Sig (exp/ret_case A1 C) A1 D (exp/bang A2 D) :-
  pi x\ (exp/of_val Sig x A1 => exp/of_comp Sig (C x) (exp/bang A2 D)).
exp/of_hand Sig (exp/op_case O C H) A (cons O D) B :-
  exp/of_hand Sig H A D B,
  exp/of_op Sig O A1 A2,
  pi x\ pi k\ (exp/of_val Sig x A1 => exp/of_val Sig k (exp/fun_ty A2 B) => exp/of_comp Sig (C x k) B),
  is_op O.

exp/of_comp Sig (exp/app V1 V2) B :-
  exp/of_val Sig V1 (exp/fun_ty A B),
  exp/of_val Sig V2 A.
exp/of_comp Sig (exp/let V C) B :-
  exp/of_val Sig V A,
  pi x\ (exp/of_val Sig x A => exp/of_comp Sig (C x) B).
exp/of_comp Sig (exp/ret V) (exp/bang A empty) :-
  exp/of_val Sig V A.
exp/of_comp Sig (exp/op O V A2 C) (exp/bang A D) :-
  exp/of_op Sig O A1 A2,
  exp/of_val Sig V A1,
  pi x\ (exp/of_val Sig x A2 => exp/of_comp Sig (C x) (exp/bang A D)),
  in_dirt O D,
  is_op O.
exp/of_comp Sig (exp/do C1 C2) (exp/bang A2 D) :-
  exp/of_comp Sig C1 (exp/bang A1 D),
  pi x\ (exp/of_val Sig x A1 => exp/of_comp Sig (C2 x) (exp/bang A2 D)).
exp/of_comp Sig (exp/with C V) B2 :-
  exp/of_comp Sig C B1,
  exp/of_val Sig V (exp/hand_ty B1 B2).
exp/of_comp Sig (exp/comp_cast C Y) B2 :-
  exp/of_comp Sig C B1,
  exp/of_coer Y (exp/comp_ty_coer_ty B1 B2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp/term_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp/term_val exp/unit.
exp/term_val (exp/hand H).
exp/term_val (exp/fun A M).
exp/term_val (exp/lam_ty S M).
exp/term_val (exp/lam_skel M).
exp/term_val (exp/lam_dirt M).
exp/term_val (exp/lam_coer Pi M).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp/result_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp/result_val V :-
  exp/term_val V.
exp/result_val (exp/val_cast V (exp/fun_coer _ _)) :-
  exp/result_val V.
exp/result_val (exp/val_cast V (exp/hand_coer _ _)) :-
  exp/result_val V.
exp/result_val (exp/val_cast V (exp/lam_skel_coer _)) :-
  exp/result_val V.
exp/result_val (exp/val_cast V (exp/lam_ty_coer _)) :-
  exp/result_val V.
exp/result_val (exp/val_cast V (exp/lam_dirt_coer _)) :-
  exp/result_val V.
exp/result_val (exp/val_cast V (exp/lam_coer_coer _ _)) :-
  exp/result_val V.

exp/terminal_comp (exp/ret V) :-
  exp/result_val V.
exp/terminal_comp (exp/comp_cast C (exp/comp_ty_coer Y1 Y2)) :-
  exp/terminal_comp C.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp/result_comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp/result_comp C :-
  exp/terminal_comp C.
exp/result_comp (exp/op O V _ C) :-
  exp/result_val V.

exp/extract_value (exp/comp_cast C (exp/comp_ty_coer Y _)) (exp/val_cast V Y) :-
  exp/extract_value C V.
exp/extract_value (exp/ret V) V :-
  exp/result_val V.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp/step_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp/step_val (exp/val_cast V C) (exp/val_cast V' C) :-
    exp/step_val V V'.
exp/step_val (exp/val_cast V exp/unit_refl_coer) V :-
    exp/result_val V.
exp/step_val (exp/app_skel V A) (exp/app_skel V' A) :-
    exp/step_val V V'.
exp/step_val (exp/app_ty V A) (exp/app_ty V' A) :-
    exp/step_val V V'.
exp/step_val (exp/app_dirt V A) (exp/app_dirt V' A) :-
    exp/step_val V V'.
exp/step_val (exp/app_coer V A) (exp/app_coer V' A) :-
    exp/step_val V V'.
exp/step_val (exp/app_skel (exp/val_cast V (exp/lam_skel_coer Y)) S) (exp/val_cast (exp/app_skel V S) (Y S)) :-
    exp/result_val V.
exp/step_val (exp/app_ty (exp/val_cast V (exp/lam_ty_coer Y)) A) (exp/val_cast (exp/app_ty V A) (Y A)) :-
    exp/result_val V.
exp/step_val (exp/app_dirt (exp/val_cast V (exp/lam_dirt_coer Y)) D) (exp/val_cast (exp/app_dirt V D) (Y D)) :-
    exp/result_val V.
exp/step_val (exp/app_coer (exp/val_cast V (exp/lam_coer_coer _ Y1)) Y2) (exp/val_cast (exp/app_coer V Y2) Y1) :-
    exp/result_val V.
exp/step_val (exp/app_skel (exp/lam_skel M) S) (M S).
exp/step_val (exp/app_ty (exp/lam_ty S M) A) (M A) :-
    exp/skel_val_ty A S.
exp/step_val (exp/app_dirt (exp/lam_dirt M) A) (M A).
exp/step_val (exp/app_coer (exp/lam_coer Pi M) A) (M A).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp/get_ret_case
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp/get_ret_case (exp/ret_case _ M) M.
exp/get_ret_case (exp/op_case _ _ H) M :-
    exp/get_ret_case H M.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp/get_op_case
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp/get_op_case (exp/ret_case _ _) O A (x\ k\ exp/op O x A (y\ exp/app k y)).
exp/get_op_case (exp/op_case O M H) O _ M :-
    is_op O.
exp/get_op_case (exp/op_case O' _ H) O A M :-
    apart O O',
    exp/get_op_case H O A M.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp/step_comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp/step_comp (exp/comp_cast C Y) (exp/comp_cast C' Y) :-
    exp/step_comp C C'.
exp/step_comp (exp/app V1 V2) (exp/app V1' V2) :-
    exp/step_val V1 V1'.
exp/step_comp (exp/app (exp/val_cast V1 (exp/fun_coer Vc1 Vc2)) V2) (exp/comp_cast (exp/app V1 (exp/val_cast V2 Vc1)) Vc2) :-
    exp/result_val V1.
exp/step_comp (exp/app V1 V2) (exp/app V1 V2') :-
    exp/term_val V1,
    exp/step_val V2 V2'.
exp/step_comp (exp/app (exp/fun A M) V) (M V) :-
    exp/result_val V.
exp/step_comp (exp/let V C) (exp/let V' C) :-
    exp/step_val V V'.
exp/step_comp (exp/let V C) (C V) :-
    exp/result_val V.
exp/step_comp (exp/ret V) (exp/ret V') :-
    exp/step_val V V'.
exp/step_comp (exp/op O V B C) (exp/op O V' B C) :-
    exp/step_val V V'.
exp/step_comp (exp/comp_cast (exp/op O V B C) Y) (exp/op O V B (y\ exp/comp_cast (C y) Y)) :-
    exp/result_val V.
exp/step_comp (exp/do C1 C2) (exp/do C1' C2) :-
    exp/step_comp C1 C1'.
exp/step_comp (exp/do C1 C2) (C2 V) :-
    exp/extract_value C1 V.
exp/step_comp (exp/do (exp/op O V B C1) C2) (exp/op O V B (y\ exp/do (C1 y) C2)) :-
    exp/result_val V.
exp/step_comp (exp/with C V) (exp/with C V') :-
    exp/step_val V V'.
exp/step_comp (exp/with C (exp/val_cast V (exp/hand_coer Y1 Y2))) (exp/comp_cast (exp/with (exp/comp_cast C Y1) V) Y2) :-
    exp/result_val V.
exp/step_comp (exp/with C V) (exp/with C' V) :-
    exp/term_val V,
    exp/step_comp C C'.
exp/step_comp (exp/with C (exp/hand H)) (Cr V) :-
    exp/extract_value C V,
    exp/get_ret_case H Cr.
exp/step_comp (exp/with (exp/op O V B C) (exp/hand H)) (Cop V (exp/fun B (y\ exp/with (C y) (exp/hand H)))) :-
    exp/result_val V,
    exp/get_op_case H O B Cop.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp/progress_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp/progress_val V :-
    exp/result_val V.
exp/progress_val V :-
    exp/step_val V V'.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exp/progress_comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exp/progress_comp C :-
    exp/result_comp C.
exp/progress_comp C :-
    exp/step_comp C C'.
