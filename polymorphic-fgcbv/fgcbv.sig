sig fgcbv.

% TYPES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  eff         type.
kind  valty       type.
kind  compty      type.
kind  scheme      type.

type  empty       eff.

type  bool        valty.
type  arrow       valty -> compty -> valty.

type  f           valty -> eff -> compty.

type  plain       valty -> scheme.
type  all         (valty -> scheme) -> scheme.

% TERMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kind  value       type.
kind  comp        type.

type  tru         value.
type  fls         value.
type  fun         (value -> comp) -> value.

type  cond        value -> comp -> comp -> comp.
type  app         value -> value -> comp.
type  ret         value -> comp.
type  bind        comp -> (value -> comp) -> comp.

% TYPING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  concrete    scheme -> valty -> o.
type  of/value    value -> valty -> o.
type  of/comp     comp -> compty -> o.
type  pof/value   value -> scheme -> o.
type  pof/comp    comp -> scheme -> eff -> o.

% SEMANTICS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

type  step        comp -> comp -> o.
type  progresses  comp -> o.
