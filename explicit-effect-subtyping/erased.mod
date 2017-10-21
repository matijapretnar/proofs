module erased.
accumulate target.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e/of_op
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e/of_op (e/cons_sig O A B Sig) O A B.
e/of_op (e/cons_sig O1 A1 B1 Sig) O2 A2 B2 :-
    e/of_op Sig O2 A2 B2,
    apart O1 O1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e/of_val, e/of_hand, e/of_comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e/of_val Sig e/unit unit_skel.
e/of_val Sig (e/fun T1 C) (fun_skel T1 T2) :-
  pi x\ (e/of_val Sig x T1 => e/of_comp Sig (C x) T2).
e/of_val Sig (e/hand H) (hand_skel T1 T2) :-
  e/of_hand Sig H T1 T2.
e/of_val Sig (e/lam_ty V) (all_skel T) :-
  pi a\ (e/of_val Sig (V a) (T a)).
e/of_val Sig (e/app_ty V T2) (T1 T2) :-
  e/of_val Sig V (all_skel T1).

e/of_hand Sig (e/ret_case T1 C) T1 T2 :-
  pi x\ (e/of_val Sig x T1 => e/of_comp Sig (C x) T2).
e/of_hand Sig (e/op_case O C H) T1 T2 :-
  e/of_hand Sig H T1 T2,
  e/of_op Sig O Top1 Top2,
  pi x\ pi k\ (e/of_val Sig x Top1 => e/of_val Sig k (fun_skel Top2 T2) => e/of_comp Sig (C x k) T2).

e/of_comp Sig (e/app V1 V2) T2 :-
  e/of_val Sig V1 (fun_skel T1 T2),
  e/of_val Sig V2 T1.
e/of_comp Sig (e/let V C) T2 :-
  e/of_val Sig V T1,
  pi x\ (e/of_val Sig x T1 => e/of_comp Sig (C x) T2).
e/of_comp Sig (e/ret V) T :-
  e/of_val Sig V T.
e/of_comp Sig (e/op O V T2 C) T :-
  e/of_op Sig O T1 T2,
  e/of_val Sig V T1,
  pi x\ (e/of_val Sig x T2 => e/of_comp Sig (C x) T).
e/of_comp Sig (e/do C1 C2) T2 :-
  e/of_comp Sig C1 T1,
  pi x\ (e/of_val Sig x T1 => e/of_comp Sig (C x) T2).
e/of_comp Sig (e/with C V) T2 :-
  e/of_comp Sig C T1,
  e/of_val Sig V (hand_skel T1 T2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e/result_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e/result_val e/unit.
e/result_val (e/hand H).
e/result_val (e/fun A M).
e/result_val (e/lam_ty M).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e/result_comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e/result_comp (e/ret V) :-
  e/result_val V.
e/result_comp (e/op O V _ C) :-
  e/result_val V.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e/step_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e/step_val (e/app_ty V A) (e/app_ty V' A) :-
    e/step_val V V'.
e/step_val (e/app_ty (e/lam_ty M) A) (M A).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e/get_ret_case
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e/get_ret_case (e/ret_case _ M) M.
e/get_ret_case (e/op_case _ _ H) M :-
    e/get_ret_case H M.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e/get_op_case
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e/get_op_case (e/ret_case _ _) O A (x\ k\ e/op O x A (y\ e/app k y)).
e/get_op_case (e/op_case O M H) O _ M :-
    is_op O.
e/get_op_case (e/op_case O' _ H) O A M :-
    apart O O',
    e/get_op_case H O A M.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e/step_comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e/step_comp (e/app V1 V2) (e/app V1' V2) :-
    e/step_val V1 V1'.
e/step_comp (e/app V1 V2) (e/app V1 V2') :-
    e/result_val V1,
    e/step_val V2 V2'.
e/step_comp (e/app (e/fun A M) V) (M V) :-
    e/result_val V.
e/step_comp (e/let V C) (e/let V' C) :-
    e/step_val V V'.
e/step_comp (e/let V C) (C V) :-
    e/result_val V.
e/step_comp (e/ret V) (e/ret V') :-
    e/step_val V V'.
e/step_comp (e/op O V B C) (e/op O V' B C) :-
    e/step_val V V'.
e/step_comp (e/do C1 C2) (e/do C1' C2) :-
    e/step_comp C1 C1'.
e/step_comp (e/do (e/ret V) C2) (C2 V) :-
    e/result_val V.
e/step_comp (e/do (e/op O V B C1) C2) (e/op O V B (y\ e/do (C1 y) C2)) :-
    e/result_val V.
e/step_comp (e/with C V) (e/with C V') :-
    e/step_val V V'.
e/step_comp (e/with C V) (e/with C' V) :-
    e/result_val V,
    e/step_comp C C'.
e/step_comp (e/with (e/ret V) (e/hand H)) (Cr V) :-
    e/result_val V,
    e/get_ret_case H Cr.
e/step_comp (e/with (e/op O V B C) (e/hand H)) (Cop V (e/fun B (y\ e/with (C y) (e/hand H)))) :-
    e/result_val V,
    e/get_op_case H O B Cop.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e/progress_val
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e/progress_val V :-
    e/result_val V.
e/progress_val V :-
    e/step_val V V'.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e/progress_comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e/progress_comp C :-
    e/result_comp C.
e/progress_comp C :-
    e/step_comp C C'.
