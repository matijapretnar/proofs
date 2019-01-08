sig exp.
accum_sig common.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% types
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  exp/val_ty                type. % A
kind  exp/comp_ty               type. % B
kind  exp/coer_ty               type. % Pi

type  exp/unit_ty               exp/val_ty.
type  exp/fun_ty                exp/val_ty -> exp/comp_ty -> exp/val_ty.
type  exp/hand_ty               exp/comp_ty -> exp/comp_ty -> exp/val_ty.
type  exp/all_skel              (skel -> exp/val_ty) -> exp/val_ty.
type  exp/all_ty                skel -> (exp/val_ty -> exp/val_ty) -> exp/val_ty.
type  exp/all_dirt              (dirt -> exp/val_ty) -> exp/val_ty.
type  exp/qual_ty               exp/coer_ty -> exp/val_ty -> exp/val_ty.

type  exp/val_ty_coer_ty        exp/val_ty -> exp/val_ty -> exp/coer_ty.
type  exp/dirt_coer_ty          dirt -> dirt -> exp/coer_ty.
type  exp/comp_ty_coer_ty       exp/comp_ty -> exp/comp_ty -> exp/coer_ty.

type  exp/bang                  exp/val_ty -> dirt -> exp/comp_ty.

type  exp/good_coer_ty          exp/coer_ty -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% coercions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  exp/coer                  type. % W

type  exp/val_ty_coer           exp/val_ty -> exp/coer.
type  exp/fun_coer              exp/coer -> exp/coer -> exp/coer.
type  exp/hand_coer             exp/coer -> exp/coer -> exp/coer.
type  exp/lam_skel_coer         (skel -> exp/coer) -> exp/coer.
type  exp/lam_ty_coer           (exp/val_ty -> exp/coer) -> exp/coer.
type  exp/lam_dirt_coer         (dirt -> exp/coer) -> exp/coer.
type  exp/lam_coer_coer         exp/coer_ty -> exp/coer -> exp/coer.
type  exp/comp_ty_coer          exp/coer -> exp/coer -> exp/coer.
type  exp/dirt_coer             dirt -> exp/coer.
type  exp/empty_coer            dirt -> exp/coer.
type  exp/cons_coer             op -> exp/coer -> exp/coer.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% terms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  exp/val                   type. % V
kind  exp/hand                  type. % H
kind  exp/comp                  type. % C

type  exp/unit                  exp/val.
type  exp/fun                   exp/val_ty -> (exp/val -> exp/comp) -> exp/val.
type  exp/hand                  exp/hand -> exp/val.
type  exp/lam_skel              (skel -> exp/val) -> exp/val.
type  exp/app_skel              exp/val -> skel -> exp/val.
type  exp/lam_ty                skel -> (exp/val_ty -> exp/val) -> exp/val.
type  exp/app_ty                exp/val -> exp/val_ty -> exp/val.
type  exp/lam_dirt              (dirt -> exp/val) -> exp/val.
type  exp/app_dirt              exp/val -> dirt -> exp/val.
type  exp/lam_coer              exp/coer_ty -> (exp/coer -> exp/val) -> exp/val.
type  exp/app_coer              exp/val -> exp/coer -> exp/val.
type  exp/val_cast              exp/val -> exp/coer -> exp/val.

type  exp/ret_case              exp/val_ty -> (exp/val -> exp/comp) -> exp/hand.
type  exp/op_case               op -> (exp/val -> exp/val -> exp/comp) -> exp/hand -> exp/hand.

type  exp/app                   exp/val -> exp/val -> exp/comp.
type  exp/let                   exp/val -> (exp/val -> exp/comp) -> exp/comp.
type  exp/ret                   exp/val -> exp/comp.
type  exp/op                    op -> exp/val -> exp/val_ty -> (exp/val -> exp/comp) -> exp/comp.
type  exp/do                    exp/comp -> (exp/val -> exp/comp) -> exp/comp.
type  exp/with                  exp/comp -> exp/val -> exp/comp.
type  exp/comp_cast             exp/comp -> exp/coer -> exp/comp.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% signatures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  exp/sig                   type. % Sig

type  exp/empty_sig             exp/sig.
type  exp/cons_sig              op -> exp/val_ty -> exp/val_ty -> exp/sig -> exp/sig.

type  exp/of_op                 exp/sig -> op -> exp/val_ty -> exp/val_ty -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% type skeletons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  exp/skel_val_ty           exp/val_ty -> skel -> o.
type  exp/skel_comp_ty          exp/comp_ty -> skel -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% typing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  exp/of_coer               exp/coer -> exp/coer_ty -> o.
type  exp/of_val                exp/sig -> exp/val -> exp/val_ty -> o.
type  exp/of_hand               exp/sig -> exp/hand -> exp/val_ty -> dirt -> exp/comp_ty -> o.
type  exp/of_comp               exp/sig -> exp/comp -> exp/comp_ty -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% operational semantics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  exp/term_val              exp/val -> o.
type  exp/result_val            exp/val -> o.
type  exp/result_comp           exp/comp -> o.
type  exp/terminal_comp         exp/comp -> o.
type  exp/extract_value         exp/comp -> exp/val -> o.
type  exp/step_val              exp/val -> exp/val -> o.
type  exp/get_ret_case          exp/hand -> (exp/val -> exp/comp) -> o.
type  exp/get_op_case           exp/hand -> op -> exp/val_ty -> (exp/val -> exp/val -> exp/comp) -> o.
type  exp/step_comp             exp/comp -> exp/comp -> o.
type  exp/progress_val          exp/val -> o.
type  exp/progress_comp         exp/comp -> o.
