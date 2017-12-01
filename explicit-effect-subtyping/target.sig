sig target.
accum_sig common.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% types
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  t/val_ty                type. % A
kind  t/comp_ty               type. % B
kind  t/coer_ty               type. % Pi

type  t/unit_ty               t/val_ty.
type  t/fun_ty                t/val_ty -> t/comp_ty -> t/val_ty.
type  t/hand_ty               t/comp_ty -> t/comp_ty -> t/val_ty.
type  t/all_skel              (skel -> t/val_ty) -> t/val_ty.
type  t/all_ty                skel -> (t/val_ty -> t/val_ty) -> t/val_ty.
type  t/all_dirt              (dirt -> t/val_ty) -> t/val_ty.
type  t/qual_ty               t/coer_ty -> t/val_ty -> t/val_ty.

type  t/val_ty_coer_ty        t/val_ty -> t/val_ty -> t/coer_ty.
type  t/dirt_coer_ty          dirt -> dirt -> t/coer_ty.
type  t/comp_ty_coer_ty       t/comp_ty -> t/comp_ty -> t/coer_ty.

type  t/bang                  t/val_ty -> dirt -> t/comp_ty.

type  t/good_coer_ty          t/coer_ty -> o.
type  t/less_val_ty           t/val_ty -> t/val_ty -> o.
type  t/less_comp_ty          t/comp_ty -> t/comp_ty -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% coercions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  t/coer                  type. % W

type  t/compose_coer          t/coer -> t/coer -> t/coer.
type  t/val_ty_coer           t/val_ty -> t/coer.
type  t/fun_coer              t/coer -> t/coer -> t/coer.
type  t/hand_coer             t/coer -> t/coer -> t/coer.
type  t/left_coer             t/coer -> t/coer.
type  t/right_coer            t/coer -> t/coer.
%     t/lam_skel_coer         MISSING
type  t/app_skel_coer         t/coer -> skel -> t/coer.
%     t/lam_ty_coer           MISSING
type  t/app_ty_coer       t/coer -> t/val_ty -> t/coer.
%     t/lam_dirt_coer         MISSING
type  t/app_dirt_coer         t/coer -> dirt -> t/coer.
%     t/lam_coer_coer         MISSING
type  t/app_coer_coer         t/coer -> t/coer -> t/coer.
type  t/comp_ty_coer          t/coer -> t/coer -> t/coer.
type  t/dirt_coer             dirt -> t/coer.
type  t/pure_coer             t/coer -> t/coer.
type  t/impure_coer           t/coer -> t/coer.
type  t/dirt_coer             dirt -> t/coer.
type  t/empty_coer            dirt -> t/coer.
type  t/cons_coer             op -> t/coer -> t/coer.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% terms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  t/val                   type. % V
kind  t/hand                  type. % H
kind  t/comp                  type. % C

type  t/unit                  t/val.
type  t/fun                   t/val_ty -> (t/val -> t/comp) -> t/val.
type  t/hand                  t/hand -> t/val.
type  t/lam_skel              (skel -> t/val) -> t/val.
type  t/app_skel              t/val -> skel -> t/val.
type  t/lam_ty                skel -> (t/val_ty -> t/val) -> t/val.
type  t/app_ty                t/val -> t/val_ty -> t/val.
type  t/lam_dirt              (dirt -> t/val) -> t/val.
type  t/app_dirt              t/val -> dirt -> t/val.
type  t/lam_coer              t/coer_ty -> (t/coer -> t/val) -> t/val.
type  t/app_coer              t/val -> t/coer -> t/val.
type  t/val_cast              t/val -> t/coer -> t/val.

type  t/ret_case              t/val_ty -> (t/val -> t/comp) -> t/hand.
type  t/op_case               op -> (t/val -> t/val -> t/comp) -> t/hand -> t/hand.

type  t/app                   t/val -> t/val -> t/comp.
type  t/let                   t/val -> (t/val -> t/comp) -> t/comp.
type  t/ret                   t/val -> t/comp.
type  t/op                    op -> t/val -> t/val_ty -> (t/val -> t/comp) -> t/comp.
type  t/do                    t/comp -> (t/val -> t/comp) -> t/comp.
type  t/with                  t/comp -> t/val -> t/comp.
type  t/comp_cast             t/comp -> t/coer -> t/comp.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% signatures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  t/sig                   type. % Sig

type  t/empty_sig             t/sig.
type  t/cons_sig              op -> t/val_ty -> t/val_ty -> t/sig -> t/sig.

type  t/of_op                 t/sig -> op -> t/val_ty -> t/val_ty -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% type skeletons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  t/skel_val_ty           t/val_ty -> skel -> o.
type  t/skel_comp_ty          t/comp_ty -> skel -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% typing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  t/of_coer               t/coer -> t/coer_ty -> o.
type  t/of_val                t/sig -> t/val -> t/val_ty -> o.
type  t/of_hand               t/sig -> t/hand -> t/val_ty -> dirt -> t/comp_ty -> o.
type  t/of_comp               t/sig -> t/comp -> t/comp_ty -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% operational semantics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  t/term_val              t/val -> o.
type  t/result_val            t/val -> o.
type  t/result_comp           t/comp -> o.
type  t/step_val              t/val -> t/val -> o.
type  t/get_ret_case          t/hand -> (t/val -> t/comp) -> o.
type  t/get_op_case           t/hand -> op -> t/val_ty -> (t/val -> t/val -> t/comp) -> o.
type  t/step_comp             t/comp -> t/comp -> o.
type  t/progress_val          t/val -> o.
type  t/progress_comp         t/comp -> o.
