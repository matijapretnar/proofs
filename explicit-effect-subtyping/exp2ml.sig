sig exp2ml.
accum_sig exp.
accum_sig ml.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% erasure of signatures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  e2m/sig                 exp/sig -> ml/sig -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% erasure of types
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type e2m/full_dirt            dirt -> o.

type e2m/val_ty		      exp/val_ty -> ml/ty -> o.
type e2m/comp_ty	      exp/comp_ty -> ml/ty -> o.
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% erasure of terms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
type  e2m/val                 exp/sig -> exp/val -> exp/val_ty -> ml/term -> o.
type  e2m/hand                exp/hand -> ml/hand -> o.
type  e2m/comp		      exp/sig -> exp/comp -> exp/comp_ty -> ml/term -> o.

type  e2m/coer		      exp/coer -> exp/coer_ty -> ml/coer -> o.

type  from_impure/val      (dirt -> exp/val_ty) -> dirt -> ml/coer -> o.
type  from_impure/comp     (dirt -> exp/comp_ty) -> dirt -> ml/coer -> o.
type  to_impure/val        (dirt -> exp/val_ty) -> dirt -> ml/coer -> o.
type  to_impure/comp       (dirt -> exp/comp_ty) -> dirt -> ml/coer -> o.
