sig elaboration.
accum_sig source.
accum_sig target.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% elaboration of types
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  elb_val_ty              s/val_ty -> t/val_ty -> o.
type  elb_qual_ty             s/qual_ty -> t/val_ty -> o.
type  elb_poly_ty             s/poly_ty -> t/val_ty -> o.
type  elb_comp_ty             s/comp_ty -> t/comp_ty -> o.
type  elb_cnstr               s/cnstr -> t/coer_ty -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% elaboration of signatures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  elb_sig                 s/sig -> t/sig -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% polymorphic context variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  elb_var                 s/sig -> s/val -> s/val_ty -> t/val -> o.
type  elb_qual_var            s/sig -> s/val -> s/qual_ty -> t/val -> o.
type  elb_poly_var            s/sig -> s/val -> s/poly_ty -> t/val -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% elaboration of terms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  elb_val                 s/sig -> s/val -> s/val_ty -> t/val -> o.
type  elb_hand                s/sig -> s/hand -> s/val_ty -> dirt -> s/comp_ty -> t/hand -> o.
type  elb_comp                s/sig -> s/comp -> s/comp_ty -> t/comp -> o.
type  elb_qual_val            s/sig -> s/val -> s/qual_ty -> t/val -> o.
type  elb_poly_val            s/sig -> s/val -> s/poly_ty -> t/val -> o.
