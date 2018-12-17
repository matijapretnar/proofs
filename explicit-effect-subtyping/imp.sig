sig imp.
accum_sig common.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% types
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  imp/val_ty                type. % A
kind  imp/qual_ty               type. % Q
kind  imp/poly_ty               type. % P
kind  imp/comp_ty               type. % B
kind  imp/cnstr                 type. % Pi

type  imp/fun_ty                imp/val_ty -> imp/comp_ty -> imp/val_ty.
type  imp/hand_ty               imp/comp_ty -> imp/comp_ty -> imp/val_ty.
type  imp/unit_ty               imp/val_ty.

type  imp/plain_qual_ty         imp/val_ty -> imp/qual_ty.
type  imp/cnstr_qual_ty         imp/cnstr -> imp/qual_ty -> imp/qual_ty.

type  imp/plain_poly_ty         imp/qual_ty -> imp/poly_ty.
type  imp/all_skel              (skel -> imp/poly_ty) -> imp/poly_ty.
type  imp/all_ty                skel -> (imp/val_ty -> imp/poly_ty) -> imp/poly_ty.
type  imp/all_dirt              (dirt -> imp/poly_ty) -> imp/poly_ty.

type  imp/bang                  imp/val_ty -> dirt -> imp/comp_ty.

type  imp/val_ty_cnstr          imp/val_ty -> imp/val_ty -> imp/cnstr.
type  imp/dirt_cnstr            dirt -> dirt -> imp/cnstr.
type  imp/comp_ty_cnstr         imp/comp_ty -> imp/comp_ty -> imp/cnstr.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% terms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  imp/val                   type. % V
kind  imp/hand                  type. % H
kind  imp/comp                  type. % C

type  imp/unit                  imp/val.
type  imp/fun                   (imp/val -> imp/comp) -> imp/val.
type  imp/hand                  imp/hand -> imp/val.

type  imp/ret_case              (imp/val -> imp/comp) -> imp/hand.
type  imp/op_case               op -> (imp/val -> imp/val -> imp/comp) -> imp/hand -> imp/hand.

type  imp/app                   imp/val -> imp/val -> imp/comp.
type  imp/let                   imp/val -> (imp/val -> imp/comp) -> imp/comp.
type  imp/ret                   imp/val -> imp/comp.
type  imp/op                    op -> imp/val -> (imp/val -> imp/comp) -> imp/comp.
type  imp/do                    imp/comp -> (imp/val -> imp/comp) -> imp/comp.
type  imp/with                  imp/comp -> imp/val -> imp/comp.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% typing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  imp/sig                   type. % Sig

type  imp/empty_sig             imp/sig.
type  imp/cons_sig              op -> imp/val_ty -> imp/val_ty -> imp/sig -> imp/sig.

type  imp/of_op                 imp/sig -> op -> imp/val_ty -> imp/val_ty -> o.
