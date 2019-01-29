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

type e2m/val_ty		          exp/val_ty -> skel -> ml/ty -> o.
type e2m/comp_ty	          exp/comp_ty -> skel -> ml/ty -> o.

type e2m/refl_coer            ml/ty -> ml/coer -> o.
type e2m/val_refl_coer        exp/val_ty -> skel -> ml/coer -> o.
type e2m/comp_refl_coer       exp/comp_ty -> skel -> ml/coer -> o.    
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% erasure of terms
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
type  e2m/val                 exp/sig -> exp/val -> exp/val_ty -> ml/term -> o.
type  e2m/hand                exp/sig -> exp/hand -> exp/val_ty -> dirt -> exp/comp_ty -> ml/hand -> o.
type  e2m/hand_empty          exp/sig -> exp/hand -> exp/val_ty -> exp/comp_ty -> ml/term -> o.
type  e2m/comp		      exp/sig -> exp/comp -> exp/comp_ty -> ml/term -> o.

type  e2m/coer		      exp/coer -> exp/coer_ty -> ml/coer -> o.
type  e2m/dirt_coer           dirt -> dirt -> ml/coer -> ml/coer -> o.

type  from_impure/val      (dirt -> exp/val_ty) -> dirt -> ml/coer -> o.
type  from_impure/comp     (dirt -> exp/comp_ty) -> dirt -> ml/coer -> o.
type  to_impure/val        (dirt -> exp/val_ty) -> dirt -> ml/coer -> o.
type  to_impure/comp       (dirt -> exp/comp_ty) -> dirt -> ml/coer -> o.
