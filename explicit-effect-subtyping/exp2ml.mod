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
% e2m/val_ty, e2m/comp_ty
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e2m/val_ty exp/unit_ty ml/unit_ty.
e2m/val_ty (exp/fun_ty A C) (ml/fun_ty A' C') :-
  e2m/val_ty A A',
  e2m/comp_ty C C'.
e2m/val_ty (exp/hand_ty (exp/bang A empty) C) (ml/fun_ty A' C') :-
  e2m/val_ty A A',
  e2m/comp_ty C C'.
e2m/val_ty (exp/hand_ty (exp/bang A D) (exp/bang B _)) (ml/hand_ty A' B') :-
  e2m/val_ty A A',
  e2m/full_dirt D,
  e2m/val_ty B B'.
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
e2m/comp_ty (exp/bang A D) (ml/comp_ty A') :-
  e2m/full_dirt D,
  e2m/val_ty A A'.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e2m/val, e2m/hand e2m/hand_empty, e2m/comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% UNIT
e2m/val Sig exp/unit exp/unit_ty ml/unit.
% FUN
e2m/val Sig (exp/fun A C) (exp/fun_ty A B) (ml/fun Aml Cml) :-
  e2m/val_ty A Aml,
  pi x\ pi x'\ (e2m/val Sig x A x' => e2m/comp Sig (C x) B (Cml x')).
% HANDLER
e2m/val Sig (exp/hand H) (exp/hand_ty (exp/bang A empty) B) Vm :-
  e2m/hand_empty Sig H A B Vm.
e2m/val Sig (exp/hand H) (exp/hand_ty (exp/bang A D) B) (ml/hand Hm):-
  e2m/full_dirt D,
  e2m/hand Sig H A D B Hm.
% SKELETON LAMBDA
e2m/val Sig (exp/lam_skel Vt) (exp/all_skel At) Vm :-
  pi s\ (e2m/val Sig (Vt s) (At s) Vm).
% SKELETON APPLY
e2m/val Sig (exp/app_skel Vt S) (At S) Vm :-
  e2m/val Sig Vt (exp/all_skel At) Vm.
% VALUE TY LAMBDA
e2m/val Sig (exp/lam_ty S Vt) (exp/all_ty S At) (ml/lam_ty Vm) :-
  pi x\ pi x'\ (exp/skel_val_ty x S => e2m/val_ty x x' => e2m/val Sig (Vt x) (At x) (Vm x')).
% VALUE TY APPLY
e2m/val Sig (exp/app_ty Vt At1) (At2 At1) (ml/app_ty Vm Am1) :-
  e2m/val Sig Vt (exp/all_ty S At2) Vm,
  e2m/val_ty At1 Am1,
  exp/skel_val_ty At1 S.
% DIRT LAMBDA
e2m/val Sig (exp/lam_dirt Vt) (exp/all_dirt At) Vm :-
  pi d\ (e2m/full_dirt d => e2m/val Sig (Vt d) (At d) Vm).
% DIRT APPLY
e2m/val Sig (exp/app_dirt Vt D) (At D) (ml/cast Vm Y) :-
  from_impure/val At D Y,
  e2m/val Sig Vt (exp/all_dirt At) Vm.
% COERCION LAMBDA
e2m/val Sig (exp/lam_coer (exp/val_ty_coer_ty A1 A2) Vt) (exp/qual_ty (exp/val_ty_coer_ty A1 A2) At) (ml/lam_coer (ml/ty_coer_ty A1' A2') Vm) :-
  pi w\ pi w'\ (e2m/coer w (exp/val_ty_coer_ty A1 A2) w' => e2m/val Sig (Vt w) At (Vm w')),
  e2m/val_ty A1 A1',
  e2m/val_ty A2 A2'.
e2m/val Sig (exp/lam_coer (exp/comp_ty_coer_ty C1 C2) Vt) (exp/qual_ty (exp/comp_ty_coer_ty C1 C2) At) (ml/lam_coer (ml/ty_coer_ty C1' C2')  Vm) :-
  pi w\ pi w'\ (e2m/coer w (exp/comp_ty_coer_ty C1 C2) w' => e2m/val Sig (Vt w) At (Vm w')),
  e2m/comp_ty C1 C1',
  e2m/comp_ty C2 C2'.
e2m/val Sig (exp/lam_coer (exp/dirt_coer_ty D1 D2) Vt) (exp/qual_ty (exp/dirt_coer_ty D1 D2) At) Vm :-
  pi w\ (exp/of_coer w (exp/dirt_coer_ty D1 D2) => e2m/val Sig (Vt w) At Vm),
  exp/good_coer_ty (exp/dirt_coer_ty D1 D2).
% COERCION APPLY
e2m/val Sig (exp/app_coer Vt Yt) At (ml/app_coer Vm Y') :-
  e2m/val Sig Vt (exp/qual_ty (exp/val_ty_coer_ty A1 A2) At) Vm,
  e2m/coer Y (exp/val_ty_coer_ty A1 A2) Y'.
e2m/val Sig (exp/app_coer Vt Yt) At (ml/app_coer Vm Y') :-
  e2m/val Sig Vt (exp/qual_ty (exp/comp_ty_coer_ty C1 C2) At) Vm,
  e2m/coer Y (exp/comp_ty_coer_ty C1 C2) Y'.
e2m/val Sig (exp/app_coer Vt Yt) At Vm :-
  e2m/val Sig Vt (exp/qual_ty (exp/dirt_coer_ty D1 D2) At) Vm,
  exp/of_coer Y (exp/dirt_coer_ty D1 D2).
% VALUE COERCION
e2m/val Sig (exp/val_cast Vt Yt) A2 (ml/cast Vm Ym) :-
  e2m/val Sig Vt At1 Vm.
  e2m/coer Yt (exp/val_ty_coer_ty At1 At2) Ym.
 
% RETURN CASE
e2m/hand_empty Sig (exp/ret_case A1 C) A1 (exp/bang A2 D) (ml/fun A1' C'):-
  e2m/val_ty A1 A1',
  pi x\ pi x'\ (e2m/val Sig x A1 x' => e2m/comp Sig (C x) (exp/bang A2 D) (C' x')).
e2m/hand Sig (exp/ret_case A1 C) A1 D (exp/bang A2 D) (ml/ret_case A1' C'):-
  e2m/val_ty A1 A1',
  pi x\ pi x'\ (e2m/val Sig x A1 x' => e2m/comp Sig (C x) (exp/bang A2 D) (C' x')).
% OP CASE
e2m/hand Sig (exp/op_case O C H) A (cons O D) B (ml/op_case O C' H') :-
  e2m/hand Sig H A D B H',
  exp/of_op Sig O A1 A2,
  pi x\ pi x'\ pi k\ pi k'\ (e2m/val Sig x A1 x' => e2m/val Sig k (exp/fun_ty A2 B) k' => e2m/comp Sig (C x k) B (C' x' k')),
  is_op O.
  
% APP
e2m/comp Sig (exp/app Vt1 Vt2) B (ml/app Vm1 Vm2) :-
  e2m/val Sig Vt1 (exp/fun_ty A B) Vm1,
  e2m/val Sig Vt2 A Vm2.
% LET
e2m/comp Sig (exp/let Vt Ct) B (ml/let Vm Cm) :-
  e2m/val Sig Vt A Vm,
  pi x\ pi x'\ (e2m/val Sig x A x' => e2m/comp Sig (Ct x) B (Cm x')).
% % RETURN
e2m/comp Sig (exp/ret V) (exp/bang A empty) Vm :-
  e2m/val Sig Vt A Vm.
% % OP
e2m/comp Sig (exp/op O Vt At2 Ct) (exp/bang At D) (ml/op O Vm Am2 Cm) :-
  exp/of_op Sig O At1 At2,
  e2m/val_ty At1 Am1,
  e2m/val_ty At2 Am2,
  e2m/val Sig Vt At1 Vm,
  pi x\ pi x'\ (e2m/val Sig x At2 x' => e2m/comp Sig (Ct x) (exp/bang At D) (Cm x')),
  in_dirt O D,
  is_op O.
% DO
e2m/comp Sig (exp/do Ct1 Ct2) (exp/bang At2 empty) (ml/let Cm1 Cm2) :-
  e2m/comp Sig Ct1 (exp/bang At1 empty) Cm1,
  pi x\ pi x'\ (e2m/val Sig x At1 x' => e2m/comp Sig (Ct2 x) (exp/bang At2 empty) (Cm2 x')).
e2m/comp Sig (exp/do Ct1 Ct2) (exp/bang At2 (cons O D)) (ml/do Cm1 Cm2) :-
  e2m/comp Sig Ct1 (exp/bang At1 (cons O D)) Cm1,
  pi x\ pi x'\ (e2m/val Sig x At1 x' => e2m/comp Sig (Ct2 x) (exp/bang At2 (cons O D)) (Cm2 x')).
% % HANDLE
e2m/comp Sig (exp/with C V) B2 (ml/app V' C') :-
  e2m/comp Sig C (exp/bang A1 empty) C',
  e2m/val Sig V (exp/hand_ty (exp/bang A1 empty) B2) V'.
e2m/comp Sig (exp/with C V) (exp/bang B2 empty) (ml/cast (ml/with V' C') (ml/unsafe_coer Y)) :-
  e2m/comp Sig C (exp/bang A1 D1) C',
  e2m/full_dirt(D1),
  e2m/val Sig V (exp/hand_ty (exp/bang A1 D1) (exp/bang B2 empty)) V',
  e2m/val_ty B2 B2',
  e2m/refl_coer B2' Y.
e2m/comp Sig (exp/with C V) (exp/bang B2 D2) (ml/with V' C') :-
  e2m/comp Sig C (exp/bang A1 D1) C',
  e2m/full_dirt(D1),
  e2m/val Sig V (exp/hand_ty (exp/bang A1 D1) (exp/bang B2 D2)) V',
  e2m/full_dirt (D2).
% COMPUTATION COERCION
e2m/comp Sig (exp/comp_cast Ct Yt) Bt2 (ml/cast Cm Ym) :-
  e2m/comp Sig Ct Bt1 Cm,
  e2m/coer Yt (exp/comp_ty_coer_ty Bt1 Bt2) Ym.

e2m/refl_coer ml/unit_ty       ml/unit_refl_coer.
e2m/refl_coer (ml/fun_ty A B)  (ml/fun_coer Y1 Y2) :-
  e2m/refl_coer A Y1,
  e2m/refl_coer B Y2.
e2m/refl_coer (ml/all_ty A) (ml/lam_ty_coer Y) :-
  pi x\ e2m/refl_coer (A x) (Y x).
e2m/refl_coer (ml/hand_ty A B) (ml/hand_coer Y1 Y2) :-
  e2m/refl_coer A Y1,
  e2m/refl_coer B Y2.
e2m/refl_coer (ml/qual_ty Y A) (ml/lam_coer_coer Y Y1) :-
  e2m/refl_coer A Y1.
e2m/refl_coer (ml/comp_ty A) (ml/comp_ty_coer Y) :-
  e2m/refl_coer A Y.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e2m/coer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e2m/coer exp/unit_refl_coer (exp/val_ty_coer_ty exp/unit_ty exp/unit_ty) ml/unit_refl_coer.
e2m/coer (exp/fun_coer Y1 Y2) (exp/val_ty_coer_ty (exp/fun_ty A1 B1) (exp/fun_ty A2 B2)) (ml/fun_coer Y1' Y2') :-
  e2m/coer Y1 (exp/val_ty_coer_ty A2 A1) Y1',
  e2m/coer Y2 (exp/comp_ty_coer_ty B1 B2) Y2'.
e2m/coer (exp/hand_coer Y1 Y2) (exp/val_ty_coer_ty (exp/hand_ty B1 B1') (exp/hand_ty B2 B2')) (ml/fun_coer Y1' Y2') :-
  e2m/coer Y1 (exp/comp_ty_coer_ty (exp/bang A2 empty) (exp/bang A1 empty)) Y1',
  e2m/coer Y2 (exp/comp_ty_coer_ty B1' B2') Y2'.
e2m/coer (exp/hand_coer Y1 Y2) (exp/val_ty_coer_ty (exp/hand_ty B1 B1') (exp/hand_ty B2 B2')) (ml/hand_coer Y1' Y2') :-
  e2m/coer Y1 (exp/comp_ty_coer_ty (exp/bang A2 D2) (exp/bang A1 D1)) Y1',
  e2m/full_dirt D1,
  e2m/full_dirt D2,
  e2m/coer Y2 (exp/comp_ty_coer_ty B1' B2') Y2'.
e2m/coer (exp/hand_coer Y1 Y2) (exp/val_ty_coer_ty (exp/hand_ty B1 B1') (exp/hand_ty B2 B2')) (ml/hand2fun_coer Y1' Y2') :-
  e2m/coer Y1 (exp/comp_ty_coer_ty (exp/bang A2 empty) (exp/bang A1 D1)) Y1',
  e2m/full_dirt D1,
  e2m/coer Y2 (exp/comp_ty_coer_ty B1' B2') Y2'.

e2m/coer (exp/lam_skel_coer Y) (exp/val_ty_coer_ty (exp/all_skel A1) (exp/all_skel A2)) Y' :-
  pi s\ e2m/coer (Y s) (exp/val_ty_coer_ty (A1 s) (A2 s)) Y'.
e2m/coer (exp/lam_ty_coer Y) (exp/val_ty_coer_ty (exp/all_ty S A1) (exp/all_ty S A2)) (ml/lam_ty_coer Y') :-
  pi a\ pi a'\ e2m/val_ty a a' => exp/skel_val_ty a S => e2m/coer (Y a) (exp/val_ty_coer_ty (A1 a) (A2 a)) (Y' a').
e2m/coer (exp/lam_dirt_coer Y) (exp/val_ty_coer_ty (exp/all_dirt A1) (exp/all_dirt A2)) Y' :-
  pi d\ e2m/full_dirt d => e2m/coer (Y d) (exp/val_ty_coer_ty (A1 d) (A2 d)) Y'.
e2m/coer (exp/lam_coer_coer (exp/val_ty_coer_ty A3 A4) Y) (exp/val_ty_coer_ty (exp/qual_ty (exp/val_ty_coer_ty A3 A4) A1) (exp/qual_ty (exp/val_ty_coer_ty A3 A4) A2)) (ml/lam_coer_coer (ml/ty_coer_ty A3' A4') Y') :-
  e2m/coer Y (exp/val_ty_coer_ty A1 A2) Y',
  e2m/val_ty A3 A3',
  e2m/val_ty A4 A4'.
e2m/coer (exp/lam_coer_coer (exp/comp_ty_coer_ty C1 C2) Y) (exp/val_ty_coer_ty (exp/qual_ty (exp/comp_ty_coer_ty C1 C2) A1) (exp/qual_ty (exp/comp_ty_coer_ty C1 C2) A2))  (ml/lam_coer_coer (ml/ty_coer_ty C1' C2') Y') :-
  e2m/coer Y (exp/val_ty_coer_ty A1 A2) Y',
  e2m/comp_ty C1 C1',
  e2m/comp_ty C2 C2'.
e2m/coer (exp/lam_coer_coer (exp/dirt_coer_ty D1 D2) Y) (exp/val_ty_coer_ty (exp/qual_ty (exp/dirt_coer_ty D1 D2) A1) (exp/qual_ty (exp/dirt_coer_ty D1 D2) A2))  Y' :-
  e2m/coer Y (exp/val_ty_coer_ty A1 A2) Y'.

e2m/coer (exp/comp_ty_coer Y1 Y2) (exp/comp_ty_coer_ty (exp/bang A1 D1) (exp/bang A2 D2)) Y2' :-
  e2m/coer Y1 (exp/val_ty_coer_ty A1 A2) Y1',
  exp/of_coer Y2 (exp/dirt_coer_ty D1 D2),
  e2m/dirt_coer D1 D2 Y1' Y2'.

e2m/dirt_coer D1 D2 Y (ml/comp_ty_coer Y) :-
  e2m/full_dirt D1,
  e2m/full_dirt D2.
e2m/dirt_coer empty D2 Y (ml/return_coer Y) :-
  e2m/full_dirt D2.
e2m/dirt_coer empty empty Y Y.
  e2m/full_dirt D2.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% from_impure/val, to_impure/val from_impure/comp to_impure/comp
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

from_impure/val (d\ exp/unit_ty) D (ml/unit_refl_coer).
from_impure/val (d\ exp/fun_ty (A d) (C d)) D (ml/fun_coer Ya Yc) :-
  to_impure/val A D Ya,
  from_impure/comp C D Yc.

to_impure/val (d\ exp/unit_ty) D (ml/unit_refl_coer).
to_impure/val (d\ exp/fun_ty (A d) (C d)) D (ml/fun_coer Ya Yc) :-
  from_impure/val A D Ya,
  to_impure/comp C D Yc.

from_impure/comp (d\ exp/bang (A d) d) empty (ml/unsafe_coer Y) :-
  from_impure/val A empty Y.
from_impure/comp (d\ exp/bang (A d) d) D (ml/comp_ty_coer Y) :-
  from_impure/val A D Y,
  e2m/full_dirt D.

to_impure/comp (d\ exp/bang (A d) d) empty (ml/return_coer Y) :-
  to_impure/val A empty Y.
to_impure/comp (d\ exp/bang (A d) d) D (ml/comp_ty_coer Y) :-
  to_impure/val A D Y,
  e2m/full_dirt D.
