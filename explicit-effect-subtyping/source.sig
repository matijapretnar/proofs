sig source.
accum_sig common.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% types
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  s/val_ty                type. % A
kind  s/qual_ty               type. % Q
kind  s/poly_ty               type. % P
kind  s/comp_ty               type. % B
kind  s/cnstr                 type. % Pi

type  s/fun_ty                s/val_ty -> s/comp_ty -> s/val_ty.
type  s/hand_ty               s/comp_ty -> s/comp_ty -> s/val_ty.
type  s/unit_ty               s/val_ty.

type  s/plain_qual_ty         s/val_ty -> s/qual_ty.
type  s/cnstr_qual_ty         s/cnstr -> s/qual_ty -> s/qual_ty.

type  s/plain_poly_ty         s/qual_ty -> s/poly_ty.
type  s/all_skel              (skel -> s/poly_ty) -> s/poly_ty.
type  s/all_ty                skel -> (s/val_ty -> s/poly_ty) -> s/poly_ty.
type  s/all_dirt              (dirt -> s/poly_ty) -> s/poly_ty.

type  s/bang                  s/val_ty -> dirt -> s/comp_ty.

type  s/val_ty_cnstr          s/val_ty -> s/val_ty -> s/cnstr.
type  s/dirt_cnstr            dirt -> dirt -> s/cnstr.
type  s/comp_ty_cnstr         s/comp_ty -> s/comp_ty -> s/cnstr.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% terms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  s/val                   type. % V
kind  s/hand                  type. % H
kind  s/comp                  type. % C

type  s/unit                  s/val.
type  s/fun                   (s/val -> s/comp) -> s/val.
type  s/hand                  s/hand -> s/val.

type  s/ret_case              (s/val -> s/comp) -> s/hand.
type  s/op_case               op -> (s/val -> s/val -> s/comp) -> s/hand -> s/hand.

type  s/app                   s/val -> s/val -> s/comp.
type  s/let                   s/val -> (s/val -> s/comp) -> s/comp.
type  s/ret                   s/val -> s/comp.
type  s/op                    op -> s/val -> (s/val -> s/comp) -> s/comp.
type  s/do                    s/comp -> (s/val -> s/comp) -> s/comp.
type  s/with                  s/comp -> s/val -> s/comp.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% typing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  s/sig                   type. % Sig

type  s/empty_sig             s/sig.
type  s/cons_sig              op -> s/val_ty -> s/val_ty -> s/sig -> s/sig.

type  s/of_op                 s/sig -> op -> s/val_ty -> s/val_ty -> o.
