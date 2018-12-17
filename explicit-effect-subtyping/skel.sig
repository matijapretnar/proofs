sig skel.
accum_sig common.
accum_sig exp.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% terms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  skel/val                   type. % V
kind  skel/hand                  type. % H
kind  skel/comp                  type. % C

type  skel/unit                  skel/val.
type  skel/fun                   skel -> (skel/val -> skel/comp) -> skel/val.
type  skel/hand                  skel/hand -> skel/val.
type  skel/lam_ty                (skel -> skel/val) -> skel/val.
type  skel/app_ty                skel/val -> skel -> skel/val.

type  skel/ret_case              skel -> (skel/val -> skel/comp) -> skel/hand.
type  skel/op_case               op -> (skel/val -> skel/val -> skel/comp) -> skel/hand -> skel/hand.

type  skel/app                   skel/val -> skel/val -> skel/comp.
type  skel/let                   skel/val -> (skel/val -> skel/comp) -> skel/comp.
type  skel/ret                   skel/val -> skel/comp.
type  skel/op                    op -> skel/val -> skel -> (skel/val -> skel/comp) -> skel/comp.
type  skel/do                    skel/comp -> (skel/val -> skel/comp) -> skel/comp.
type  skel/with                  skel/comp -> skel/val -> skel/comp.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% signatures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  skel/sig                   type. % Sig

type  skel/empty_sig             skel/sig.
type  skel/cons_sig              op -> skel -> skel -> skel/sig -> skel/sig.

type  skel/of_op                 skel/sig -> op -> skel -> skel -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% typing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  skel/of_val                skel/sig -> skel/val -> skel -> o.
type  skel/of_hand               skel/sig -> skel/hand -> skel -> skel -> o.
type  skel/of_comp               skel/sig -> skel/comp -> skel -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% operational semantics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  skel/result_val            skel/val -> o.
type  skel/result_comp           skel/comp -> o.
type  skel/step_val              skel/val -> skel/val -> o.
type  skel/get_ret_case          skel/hand -> (skel/val -> skel/comp) -> o.
type  skel/get_op_case           skel/hand -> op -> skel -> (skel/val -> skel/val -> skel/comp) -> o.
type  skel/step_comp             skel/comp -> skel/comp -> o.
type  skel/progress_val          skel/val -> o.
type  skel/progress_comp         skel/comp -> o.
type  skel/converges             skel/val -> o.
type  skel/normal                skel/val -> skel -> o.
