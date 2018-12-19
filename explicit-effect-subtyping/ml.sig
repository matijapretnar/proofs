sig ml.
accum_sig common.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% types
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  ml/ty                    type. % A
kind  ml/coer_ty               type. % Pi
 
type  ml/unit_ty               ml/ty.
type  ml/fun_ty                ml/ty -> ml/ty -> ml/ty.
type  ml/all_ty                (ml/ty -> ml/ty) -> ml/ty.
type  ml/hand_ty               ml/ty -> ml/ty -> ml/ty.
type  ml/qual_ty               ml/coer_ty -> ml/ty -> ml/ty.
type  ml/comp_ty			   ml/ty -> ml/ty.
 
type  ml/ty_coer_ty            ml/ty -> ml/ty -> ml/coer_ty.
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% coercions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
kind  ml/coer                  type. % W
 
type  ml/compose_coer          ml/coer -> ml/coer -> ml/coer.
type  ml/refl_coer             ml/ty -> ml/coer.
type  ml/fun_coer              ml/coer -> ml/coer -> ml/coer.
type  ml/hand_coer             ml/coer -> ml/coer -> ml/coer.
type  ml/hand2fun_coer         ml/coer -> ml/coer -> ml/coer.
type  ml/left_coer             ml/coer -> ml/coer.
type  ml/right_coer            ml/coer -> ml/coer.
%     ml/lam_ty_coer           MISSING
type  ml/app_ty_coer           ml/coer -> ml/ty -> ml/coer.
%     ml/lam_coer_coer         MISSING
type  ml/app_coer_coer         ml/coer -> ml/coer -> ml/coer.
type  ml/comp_ty_coer          ml/coer -> ml/coer.
type  ml/return_coer           ml/coer -> ml/coer.
type  ml/unsafe_coer           ml/coer -> ml/coer.
type  ml/pure_coer             ml/coer -> ml/coer.
type  ml/nruter_coer           ml/coer -> ml/coer.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% terms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
kind  ml/term		       type. % T
kind  ml/hand                  type. % H
 
type  ml/unit                  ml/term.
type  ml/fun                   ml/ty -> (ml/term -> ml/term) -> ml/term.
type  ml/lam_ty                (ml/ty -> ml/term) -> ml/term.
type  ml/app_ty                ml/term -> ml/ty -> ml/term.
type  ml/cast                  ml/term -> ml/coer -> ml/term.
type  ml/hand                  ml/hand -> ml/term.
type  ml/lam_coer              ml/coer_ty -> (ml/coer -> ml/term) -> ml/term.
type  ml/app_coer              ml/term -> ml/coer -> ml/term.
 
type  ml/ret_case              ml/ty -> (ml/term -> ml/term) -> ml/hand.
type  ml/op_case               op -> (ml/term -> ml/term -> ml/term) -> ml/hand -> ml/hand.
 
type  ml/app                   ml/term -> ml/term -> ml/term.
type  ml/let                   ml/term -> (ml/term -> ml/term) -> ml/term.
type  ml/op                    op -> ml/term -> ml/ty -> (ml/term -> ml/term) -> ml/term.
type  ml/do                    ml/term -> (ml/term -> ml/term) -> ml/term.
type  ml/with                  ml/term -> ml/term -> ml/term.
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% signatures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
kind  ml/sig                   type. % Sig
 
type  ml/empty_sig             ml/sig.
type  ml/cons_sig              op -> ml/ty -> ml/ty -> ml/sig -> ml/sig.

type  ml/of_op                 ml/sig -> op -> ml/ty -> ml/ty -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% typing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  ml/of_term			   ml/sig -> ml/term -> ml/ty -> o.
type  ml/of_coer               ml/coer -> ml/coer_ty -> o.
type  ml/of_hand               ml/sig -> ml/hand -> ml/ty -> ml/ty -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% operational semantics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% type  ml/term_val              ml/val -> o.
% type  ml/result_val            ml/val -> o.
% type  ml/result_comp           ml/comp -> o.
% type  ml/step_val              ml/val -> ml/val -> o.
% type  ml/get_ret_case          ml/hand -> (ml/val -> ml/comp) -> o.
% type  ml/get_op_case           ml/hand -> op -> ml/val_ty -> (ml/val -> ml/val -> ml/comp) -> o.
% type  ml/step_comp             ml/comp -> ml/comp -> o.
% type  ml/progress_val          ml/val -> o.
% type  ml/progress_comp         ml/comp -> o.
