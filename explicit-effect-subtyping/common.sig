sig common.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% operations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  op                      type. % O

type  z_op                    op.
type  s_op                    op -> op.

type  is_op                   op -> o.
type  apart                   op -> op -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dirts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  dirt                    type. % D

type  empty                   dirt.
type  cons                    op -> dirt -> dirt.

type  is_dirt                 dirt -> o.
type  in_dirt                 op -> dirt -> o.
type  less_dirt               dirt -> dirt -> o.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% skeletons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  skel                    type. % S

type  unit_skel               skel.
type  fun_skel                skel -> skel -> skel.
type  hand_skel               skel -> skel -> skel.
type  all_skel                (skel -> skel) -> skel.

type  ground_skel             skel -> o.
