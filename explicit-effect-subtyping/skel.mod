module skel.
accumulate exp.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% skel/of_op
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

skel/of_op (skel/cons_sig O A B Sig) O A B.
skel/of_op (skel/cons_sig O1 A1 B1 Sig) O2 A2 B2 :-
    skel/of_op Sig O2 A2 B2,
    apart O1 O2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% skel/of_val, skel/of_hand, skel/of_comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

skel/of_val Sig skel/unit unit_skel.
skel/of_val Sig (skel/fun T1 C) (fun_skel T1 T2) :-
  pi x\ (skel/of_val Sig x T1 => skel/of_comp Sig (C x) T2).
skel/of_val Sig (skel/hand H) (hand_skel T1 T2) :-
  skel/of_hand Sig H T1 T2.
skel/of_val Sig (skel/lam_ty V) (all_skel T) :-
  pi a\ (skel/of_val Sig (V a) (T a)).
skel/of_val Sig (skel/app_ty V T2) (T1 T2) :-
  skel/of_val Sig V (all_skel T1).

skel/of_hand Sig (skel/ret_case T1 C) T1 T2 :-
  pi x\ (skel/of_val Sig x T1 => skel/of_comp Sig (C x) T2).
skel/of_hand Sig (skel/op_case O C H) T1 T2 :-
  skel/of_hand Sig H T1 T2,
  skel/of_op Sig O Top1 Top2,
  pi x\ pi k\ (skel/of_val Sig x Top1 => skel/of_val Sig k (fun_skel Top2 T2) => skel/of_comp Sig (C x k) T2).

skel/of_comp Sig (skel/app V1 V2) T2 :-
  skel/of_val Sig V1 (fun_skel T1 T2),
  skel/of_val Sig V2 T1.
skel/of_comp Sig (skel/let V C) T2 :-
  skel/of_val Sig V T1,
  pi x\ (skel/of_val Sig x T1 => skel/of_comp Sig (C x) T2).
skel/of_comp Sig (skel/ret V) T :-
  skel/of_val Sig V T.
skel/of_comp Sig (skel/op O V T2 C) T :-
  skel/of_op Sig O T1 T2,
  skel/of_val Sig V T1,
  pi x\ (skel/of_val Sig x T2 => skel/of_comp Sig (C x) T).
skel/of_comp Sig (skel/do C1 C2) T2 :-
  skel/of_comp Sig C1 T1,
  pi x\ (skel/of_val Sig x T1 => skel/of_comp Sig (C x) T2).
skel/of_comp Sig (skel/with C V) T2 :-
  skel/of_comp Sig C T1,
  skel/of_val Sig V (hand_skel T1 T2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% skel/result_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

skel/result_val skel/unit.
skel/result_val (skel/hand H).
skel/result_val (skel/fun A M).
skel/result_val (skel/lam_ty M).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% skel/result_comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

skel/result_comp (skel/ret V) :-
  skel/result_val V.
skel/result_comp (skel/op O V _ C) :-
  skel/result_val V.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% skel/step_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

skel/step_val (skel/app_ty V A) (skel/app_ty V' A) :-
    skel/step_val V V'.
skel/step_val (skel/app_ty (skel/lam_ty M) A) (M A).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% skel/get_ret_case
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

skel/get_ret_case (skel/ret_case _ M) M.
skel/get_ret_case (skel/op_case _ _ H) M :-
    skel/get_ret_case H M.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% skel/get_op_case
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

skel/get_op_case (skel/ret_case _ _) O A (x\ k\ skel/op O x A (y\ skel/app k y)).
skel/get_op_case (skel/op_case O M H) O _ M :-
    is_op O.
skel/get_op_case (skel/op_case O' _ H) O A M :-
    apart O O',
    skel/get_op_case H O A M.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% skel/step_comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

skel/step_comp (skel/app V1 V2) (skel/app V1' V2) :-
    skel/step_val V1 V1'.
skel/step_comp (skel/app V1 V2) (skel/app V1 V2') :-
    skel/result_val V1,
    skel/step_val V2 V2'.
skel/step_comp (skel/app (skel/fun A M) V) (M V) :-
    skel/result_val V.
skel/step_comp (skel/let V C) (skel/let V' C) :-
    skel/step_val V V'.
skel/step_comp (skel/let V C) (C V) :-
    skel/result_val V.
skel/step_comp (skel/ret V) (skel/ret V') :-
    skel/step_val V V'.
skel/step_comp (skel/op O V B C) (skel/op O V' B C) :-
    skel/step_val V V'.
skel/step_comp (skel/do C1 C2) (skel/do C1' C2) :-
    skel/step_comp C1 C1'.
skel/step_comp (skel/do (skel/ret V) C2) (C2 V) :-
    skel/result_val V.
skel/step_comp (skel/do (skel/op O V B C1) C2) (skel/op O V B (y\ skel/do (C1 y) C2)) :-
    skel/result_val V.
skel/step_comp (skel/with C V) (skel/with C V') :-
    skel/step_val V V'.
skel/step_comp (skel/with C V) (skel/with C' V) :-
    skel/result_val V,
    skel/step_comp C C'.
skel/step_comp (skel/with (skel/ret V) (skel/hand H)) (Cr V) :-
    skel/result_val V,
    skel/get_ret_case H Cr.
skel/step_comp (skel/with (skel/op O V B C) (skel/hand H)) (Cop V (skel/fun B (y\ skel/with (C y) (skel/hand H)))) :-
    skel/result_val V,
    skel/get_op_case H O B Cop.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% skel/progress_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

skel/progress_val V :-
    skel/result_val V.
skel/progress_val V :-
    skel/step_val V V'.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% skel/progress_comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

skel/progress_comp C :-
    skel/result_comp C.
skel/progress_comp C :-
    skel/step_comp C C'.

skel/converges V :-
  skel/result_val V.
skel/converges V :-
  skel/step_val V V',
  skel/converges V'.

skel/normal V unit_skel :-
    skel/converges V.
skel/normal V (fun_skel _ _) :-
    skel/converges V.
skel/normal V (hand_skel _ _) :-
    skel/converges V.
skel/normal V (all_skel A) :-
    skel/converges V,
    pi t\ skel/normal (skel/app_ty V t) (A t).
