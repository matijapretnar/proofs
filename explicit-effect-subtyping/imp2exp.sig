sig imp2exp.
accum_sig imp.
accum_sig exp.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% elaboration of types
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  i2e/val_ty              imp/val_ty -> exp/val_ty -> o.
type  i2e/qual_ty             imp/qual_ty -> exp/val_ty -> o.
type  i2e/poly_ty             imp/poly_ty -> exp/val_ty -> o.
type  i2e/comp_ty             imp/comp_ty -> exp/comp_ty -> o.
type  i2e/cnstr               imp/cnstr -> exp/coer_ty -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% elaboration of signatures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  i2e/sig                 imp/sig -> exp/sig -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% polymorphic context variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  i2e/var                 imp/sig -> imp/val -> imp/val_ty -> exp/val -> o.
type  i2e/qual_var            imp/sig -> imp/val -> imp/qual_ty -> exp/val -> o.
type  i2e/poly_var            imp/sig -> imp/val -> imp/poly_ty -> exp/val -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% elaboration of terms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  i2e/val                 imp/sig -> imp/val -> imp/val_ty -> exp/val -> o.
type  i2e/hand                imp/sig -> imp/hand -> imp/val_ty -> dirt -> imp/comp_ty -> exp/hand -> o.
type  i2e/comp                imp/sig -> imp/comp -> imp/comp_ty -> exp/comp -> o.
type  i2e/qual_val            imp/sig -> imp/val -> imp/qual_ty -> exp/val -> o.
type  i2e/poly_val            imp/sig -> imp/val -> imp/poly_ty -> exp/val -> o.
