sig erased.
accum_sig common.
accum_sig target.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% terms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  e/val                   type. % V
kind  e/hand                  type. % H
kind  e/comp                  type. % C

type  e/unit                  e/val.
type  e/fun                   skel -> (e/val -> e/comp) -> e/val.
type  e/hand                  e/hand -> e/val.
type  e/lam_ty                (skel -> e/val) -> e/val.
type  e/app_ty                e/val -> skel -> e/val.

type  e/ret_case              skel -> (e/val -> e/comp) -> e/hand.
type  e/op_case               op -> (e/val -> e/val -> e/comp) -> e/hand -> e/hand.

type  e/app                   e/val -> e/val -> e/comp.
type  e/let                   e/val -> (e/val -> e/comp) -> e/comp.
type  e/ret                   e/val -> e/comp.
type  e/op                    op -> e/val -> skel -> (e/val -> e/comp) -> e/comp.
type  e/do                    e/comp -> (e/val -> e/comp) -> e/comp.
type  e/with                  e/comp -> e/val -> e/comp.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% signatures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  e/sig                   type. % Sig

type  e/empty_sig             e/sig.
type  e/cons_sig              op -> skel -> skel -> e/sig -> e/sig.

type  e/of_op                 e/sig -> op -> skel -> skel -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% typing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  e/of_val                e/sig -> e/val -> skel -> o.
type  e/of_hand               e/sig -> e/hand -> skel -> skel -> o.
type  e/of_comp               e/sig -> e/comp -> skel -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% operational semantics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  e/result_val            e/val -> o.
type  e/result_comp           e/comp -> o.
type  e/step_val              e/val -> e/val -> o.
type  e/get_ret_case          e/hand -> (e/val -> e/comp) -> o.
type  e/get_op_case           e/hand -> op -> skel -> (e/val -> e/val -> e/comp) -> o.
type  e/step_comp             e/comp -> e/comp -> o.
type  e/progress_val          e/val -> o.
type  e/progress_comp         e/comp -> o.
type  e/converges             e/val -> o.
type  e/normal                e/val -> skel -> o.
