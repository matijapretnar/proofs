module target.
accumulate common.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t/less_val_ty, t/less_comp_ty
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t/less_val_ty t/unit_ty t/unit_ty.
t/less_val_ty (t/fun_ty A1 C1) (t/fun_ty A2 C2) :-
  t/less_val_ty A2 A1,
  t/less_comp_ty C1 C2.
t/less_val_ty (t/hand_ty A1 C1) (t/hand_ty A2 C2) :-
  t/less_comp_ty A2 A1,
  t/less_comp_ty C1 C2.
t/less_val_ty (t/all_ty S A1) (t/all_ty S A2) :-
  pi a\ t/less_val_ty (A1 a) (A2 a).
t/less_val_ty (t/all_dirt A1) (t/all_dirt A2) :-
  pi a\ t/less_val_ty (A1 a) (A2 a).
t/less_val_ty (t/all_skel A1) (t/all_skel A2) :-
  pi a\ t/less_val_ty (A1 a) (A2 a).
t/less_val_ty (t/qual_ty Pi A1) (t/qual_ty Pi A2) :-
  t/less_val_ty A1 A2.

t/less_comp_ty (t/bang A1 D1) (t/bang A2 D2) :-
  t/less_val_ty A1 A2,
  less_dirt D1 D2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t/of_op
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t/of_op (t/cons_sig O A B Sig) O A B.
t/of_op (t/cons_sig O1 A1 B1 Sig) O2 A2 B2 :-
    t/of_op Sig O2 A2 B2,
    apart O1 O2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t/skel_val_ty, t/skel_comp_ty
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t/skel_val_ty t/unit_ty unit_skel.
t/skel_val_ty (t/fun_ty A B) (fun_skel S1 S2) :-
  t/skel_val_ty A S1,
  t/skel_comp_ty B S2.
t/skel_val_ty (t/hand_ty B1 B2) (hand_skel S1 S2) :-
  t/skel_comp_ty B1 S1,
  t/skel_comp_ty B2 S2.
t/skel_val_ty (t/all_skel A) (all_skel S) :-
  pi s\ t/skel_val_ty (A s) (S s).
t/skel_val_ty (t/all_ty S A) T :-
  pi a\ t/skel_val_ty a S => t/skel_val_ty (A a) T.
t/skel_val_ty (t/all_dirt A) S :-
  pi d\ t/skel_val_ty (A d) S.
t/skel_val_ty (t/qual_ty _ A) S :-
  t/skel_val_ty A S.

t/skel_comp_ty (t/bang A _) S :-
  t/skel_val_ty A S.

t/good_coer_ty (t/val_ty_coer_ty A1 A2).
t/good_coer_ty (t/comp_ty_coer_ty A1 A2).
t/good_coer_ty (t/dirt_coer_ty D1 D2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t/of_coer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t/of_coer (t/compose_coer Y1 Y2) (t/val_ty_coer_ty A1 A3) :-
  t/of_coer Y1 (t/val_ty_coer_ty A1 A2),
  t/of_coer Y2 (t/val_ty_coer_ty A2 A3).
t/of_coer (t/compose_coer Y1 Y2) (t/dirt_coer_ty D1 D3) :-
  t/of_coer Y1 (t/dirt_coer_ty D1 D2),
  t/of_coer Y2 (t/dirt_coer_ty D2 D3).
t/of_coer (t/compose_coer Y1 Y2) (t/comp_ty_coer_ty B1 B3) :-
  t/of_coer Y1 (t/comp_ty_coer_ty B1 B2),
  t/of_coer Y2 (t/comp_ty_coer_ty B2 B3).

% t/of_coer (t/val_ty_coer A) (t/val_ty_coer_ty A A).
t/of_coer (t/fun_coer Y1 Y2) (t/val_ty_coer_ty (t/fun_ty A1 B1) (t/fun_ty A2 B2)) :-
  t/of_coer Y1 (t/val_ty_coer_ty A2 A1),
  t/of_coer Y2 (t/comp_ty_coer_ty B1 B2).
t/of_coer (t/hand_coer Y1 Y2) (t/val_ty_coer_ty (t/hand_ty B1 B1') (t/hand_ty B2 B2')) :-
  t/of_coer Y1 (t/comp_ty_coer_ty B2 B1),
  t/of_coer Y2 (t/comp_ty_coer_ty B1' B2').

t/of_coer (t/left_coer Y) (t/val_ty_coer_ty A2 A1) :-
  t/of_coer Y (t/val_ty_coer_ty (t/fun_ty A1 _) (t/fun_ty A2 _)).
t/of_coer (t/left_coer Y) (t/comp_ty_coer_ty B2 B1) :-
  t/of_coer Y (t/val_ty_coer_ty (t/hand_ty B1 _) (t/hand_ty B2 _)).
t/of_coer (t/right_coer Y) (t/comp_ty_coer_ty B1 B2) :-
  t/of_coer Y (t/val_ty_coer_ty (t/fun_ty _ B1) (t/fun_ty _ B2)).
t/of_coer (t/right_coer Y) (t/comp_ty_coer_ty B1 B2) :-
  t/of_coer Y (t/val_ty_coer_ty (t/hand_ty _ B1) (t/hand_ty _ B2)).

t/of_coer (t/app_skel_coer Y S) (t/val_ty_coer_ty (A1 S) (A2 S)) :-
  t/of_coer Y (t/val_ty_coer_ty (t/all_skel A1) (t/all_skel A2)).
t/of_coer (t/app_ty_coer Y A) (t/val_ty_coer_ty (A1 A) (A2 A)) :-
  t/of_coer Y (t/val_ty_coer_ty (t/all_ty S A1) (t/all_ty S A2)),
  t/skel_val_ty A S.
t/of_coer (t/app_dirt_coer Y D) (t/val_ty_coer_ty (A1 D) (A2 D)) :-
  t/of_coer Y (t/val_ty_coer_ty (t/all_dirt A1) (t/all_dirt A2)).
t/of_coer (t/app_coer_coer Y1 Y2) (t/val_ty_coer_ty A1 A2) :-
  t/of_coer Y1 (t/val_ty_coer_ty (t/qual_ty Pi A1) (t/qual_ty Pi A2)),
  t/of_coer Y2 Pi.

t/of_coer (t/comp_ty_coer Y1 Y2) (t/comp_ty_coer_ty (t/bang A1 D1) (t/bang A2 D2)) :-
  t/of_coer Y1 (t/val_ty_coer_ty A1 A2),
  t/of_coer Y2 (t/dirt_coer_ty D1 D2).
t/of_coer (t/pure_coer Y) (t/val_ty_coer_ty A1 A2) :-
  t/of_coer Y (t/comp_ty_coer_ty (t/bang A1 _) (t/bang A2 _)).
t/of_coer (t/impure_coer Y) (t/dirt_coer_ty D1 D2) :-
  t/of_coer Y (t/comp_ty_coer_ty (t/bang _ D1) (t/bang _ D2)).

t/of_coer (t/dirt_coer D) (t/dirt_coer_ty D D) :-
  is_dirt D.
t/of_coer (t/empty_coer D) (t/dirt_coer_ty empty D).
t/of_coer (t/cons_coer O Y) (t/dirt_coer_ty (cons O D1) (cons O D2)) :-
  t/of_coer Y (t/dirt_coer_ty D1 D2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t/of_val, t/of_hand, t/of_comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t/of_val Sig t/unit t/unit_ty.
t/of_val Sig (t/fun A C) (t/fun_ty A B) :-
  pi x\ (t/of_val Sig x A => t/of_comp Sig (C x) B).
t/of_val Sig (t/hand H) (t/hand_ty (t/bang A D) B) :-
  t/of_hand Sig H A D B.

t/of_val Sig (t/lam_skel V) (t/all_skel A) :-
  pi s\ (t/of_val Sig (V s) (A s)).
t/of_val Sig (t/app_skel V S) (A S) :-
  t/of_val Sig V (t/all_skel A).
t/of_val Sig (t/lam_ty S V) (t/all_ty S A) :-
  pi x\ (t/skel_val_ty x S => t/of_val Sig (V x) (A x)).
t/of_val Sig (t/app_ty V A1) (A2 A1) :-
  t/of_val Sig V (t/all_ty S A2),
  t/skel_val_ty A1 S.
t/of_val Sig (t/lam_dirt V) (t/all_dirt A) :-
  pi d\ (t/of_val Sig (V d) (A d)).
t/of_val Sig (t/app_dirt V D) (A D) :-
  t/of_val Sig V (t/all_dirt A).
t/of_val Sig (t/lam_coer Pi V) (t/qual_ty Pi A) :-
  pi w\ (t/of_coer w Pi => t/of_val Sig (V w) A),
  t/good_coer_ty Pi.
t/of_val Sig (t/app_coer V Y) A :-
  t/of_val Sig V (t/qual_ty Pi A),
  t/of_coer Y Pi.

t/of_val Sig (t/val_cast V Y) A2 :-
  t/of_val Sig V A1,
  t/of_coer Y (t/val_ty_coer_ty A1 A2).

t/of_hand Sig (t/ret_case A1 C) A1 D (t/bang A2 D) :-
  pi x\ (t/of_val Sig x A1 => t/of_comp Sig (C x) (t/bang A2 D)).
t/of_hand Sig (t/op_case O C H) A (cons O D) B :-
  t/of_hand Sig H A D B,
  t/of_op Sig O A1 A2,
  pi x\ pi k\ (t/of_val Sig x A1 => t/of_val Sig k (t/fun_ty A2 B) => t/of_comp Sig (C x k) B),
  is_op O.

t/of_comp Sig (t/app V1 V2) B :-
  t/of_val Sig V1 (t/fun_ty A B),
  t/of_val Sig V2 A.
t/of_comp Sig (t/let V C) B :-
  t/of_val Sig V A,
  pi x\ (t/of_val Sig x A => t/of_comp Sig (C x) B).
t/of_comp Sig (t/ret V) (t/bang A empty) :-
  t/of_val Sig V A.
t/of_comp Sig (t/op O V A2 C) (t/bang A D) :-
  t/of_op Sig O A1 A2,
  t/of_val Sig V A1,
  pi x\ (t/of_val Sig x A2 => t/of_comp Sig (C x) (t/bang A D)),
  in_dirt O D,
  is_op O.
t/of_comp Sig (t/do C1 C2) (t/bang A2 D) :-
  t/of_comp Sig C1 (t/bang A1 D),
  pi x\ (t/of_val Sig x A1 => t/of_comp Sig (C2 x) (t/bang A2 D)).
t/of_comp Sig (t/with C V) B2 :-
  t/of_comp Sig C B1,
  t/of_val Sig V (t/hand_ty B1 B2).
t/of_comp Sig (t/comp_cast C Y) B2 :-
  t/of_comp Sig C B1,
  t/of_coer Y (t/comp_ty_coer_ty B1 B2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t/term_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t/term_val t/unit.
t/term_val (t/hand H).
t/term_val (t/fun A M).
t/term_val (t/lam_ty S M).
t/term_val (t/lam_skel M).
t/term_val (t/lam_dirt M).
t/term_val (t/lam_coer Pi M).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t/result_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t/result_val V :-
  t/term_val V.
t/result_val (t/val_cast V Cv) :-
  t/term_val V.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t/result_comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t/result_comp (t/ret V) :-
  t/term_val V.
t/result_comp (t/comp_cast (t/ret V) Cc) :-
  t/term_val V.
t/result_comp (t/op O V _ C) :-
  t/result_val V.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t/step_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t/step_val (t/val_cast V C) (t/val_cast V' C) :-
    t/step_val V V'.
t/step_val (t/val_cast (t/val_cast V C1) C2) (t/val_cast V (t/compose_coer C1 C2)) :-
    t/result_val V.
t/step_val (t/app_skel V A) (t/app_skel V' A) :-
    t/step_val V V'.
t/step_val (t/app_ty V A) (t/app_ty V' A) :-
    t/step_val V V'.
t/step_val (t/app_dirt V A) (t/app_dirt V' A) :-
    t/step_val V V'.
t/step_val (t/app_coer V A) (t/app_coer V' A) :-
    t/step_val V V'.
t/step_val (t/app_skel (t/val_cast V Y) A) (t/val_cast (t/app_skel V A) (t/app_skel_coer Y A)) :-
    t/term_val V.
t/step_val (t/app_ty (t/val_cast V Y) A) (t/val_cast (t/app_ty V A) (t/app_ty_coer Y A)) :-
    t/term_val V.
t/step_val (t/app_dirt (t/val_cast V Y) A) (t/val_cast (t/app_dirt V A) (t/app_dirt_coer Y A)) :-
    t/term_val V.
t/step_val (t/app_coer (t/val_cast V Y) A) (t/val_cast (t/app_coer V A) (t/app_coer_coer Y A)) :-
    t/term_val V.
t/step_val (t/app_skel (t/lam_skel M) S) (M S).
t/step_val (t/app_ty (t/lam_ty S M) A) (M A) :-
    t/skel_val_ty A S.
t/step_val (t/app_dirt (t/lam_dirt M) A) (M A).
t/step_val (t/app_coer (t/lam_coer Pi M) A) (M A).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t/get_ret_case
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t/get_ret_case (t/ret_case _ M) M.
t/get_ret_case (t/op_case _ _ H) M :-
    t/get_ret_case H M.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t/get_op_case
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t/get_op_case (t/ret_case _ _) O A (x\ k\ t/op O x A (y\ t/app k y)).
t/get_op_case (t/op_case O M H) O _ M :-
    is_op O.
t/get_op_case (t/op_case O' _ H) O A M :-
    apart O O',
    t/get_op_case H O A M.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t/step_comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t/step_comp (t/comp_cast C Y) (t/comp_cast C' Y) :-
    t/step_comp C C'.
t/step_comp (t/comp_cast (t/comp_cast C Y1) Y2) (t/comp_cast C (t/compose_coer Y1 Y2)) :-
    t/result_comp C.
t/step_comp (t/app V1 V2) (t/app V1' V2) :-
    t/step_val V1 V1'.
t/step_comp (t/app (t/val_cast V1 Vc) V2) (t/comp_cast (t/app V1 (t/val_cast V2 (t/left_coer Vc))) (t/right_coer Vc)) :-
    t/term_val V1.
t/step_comp (t/app V1 V2) (t/app V1 V2') :-
    t/term_val V1,
    t/step_val V2 V2'.
t/step_comp (t/app (t/fun A M) V) (M V) :-
    t/result_val V.
t/step_comp (t/let V C) (t/let V' C) :-
    t/step_val V V'.
t/step_comp (t/let V C) (C V) :-
    t/result_val V.
t/step_comp (t/ret V) (t/ret V') :-
    t/step_val V V'.
t/step_comp (t/ret (t/val_cast V Y)) (t/comp_cast (t/ret V) (t/comp_ty_coer Y (t/empty_coer empty))).
t/step_comp (t/op O V B C) (t/op O V' B C) :-
    t/step_val V V'.
t/step_comp (t/comp_cast (t/op O V B C) Y) (t/op O V B (y\ t/comp_cast (C y) Y)) :-
    t/result_val V.
t/step_comp (t/do C1 C2) (t/do C1' C2) :-
    t/step_comp C1 C1'.
t/step_comp (t/do (t/comp_cast (t/ret V) Y) C2) (C2 (t/val_cast V (t/pure_coer Y))) :-
    t/term_val V.
t/step_comp (t/do (t/ret V) C2) (C2 V) :-
    t/term_val V.
t/step_comp (t/do (t/op O V B C1) C2) (t/op O V B (y\ t/do (C1 y) C2)) :-
    t/result_val V.
t/step_comp (t/with C V) (t/with C V') :-
    t/step_val V V'.
t/step_comp (t/with C (t/val_cast V Y)) (t/comp_cast (t/with (t/comp_cast C (t/left_coer Y)) V) (t/right_coer Y)) :-
    t/term_val V.
t/step_comp (t/with C V) (t/with C' V) :-
    t/term_val V,
    t/step_comp C C'.
t/step_comp (t/with (t/ret V) (t/hand H)) (Cr V) :-
    t/term_val V,
    t/get_ret_case H Cr.
t/step_comp (t/with (t/comp_cast (t/ret V) Y) (t/hand H)) (Cr (t/val_cast V (t/pure_coer Y))) :-
    t/term_val V,
    t/get_ret_case H Cr.
t/step_comp (t/with (t/op O V B C) (t/hand H)) (Cop V (t/fun B (y\ t/with (C y) (t/hand H)))) :-
    t/result_val V,
    t/get_op_case H O B Cop.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t/progress_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t/progress_val V :-
    t/result_val V.
t/progress_val V :-
    t/step_val V V'.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t/progress_comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t/progress_comp C :-
    t/result_comp C.
t/progress_comp C :-
    t/step_comp C C'.
