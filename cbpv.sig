sig cbpv.

kind    eff, valty, compty   type.

type    empty           eff.

type    unitty          valty.
type    prod            valty -> valty -> valty.
type    sum             valty -> valty -> valty.
type    u               compty -> valty.

type    f               eff -> valty -> compty.
type    arrow           valty -> compty -> compty.

type    eff-kind        compty -> eff -> o.


kind    value, comp     type.

type    unit            value.
type    pair            value -> value -> value.
type    inl             value -> value.
type    inr             value -> value.
type    thunk           comp -> value.

type    ret             value -> comp.
type    fun             (value -> comp) -> comp.
type    split           value -> (value -> value -> comp) -> comp.
type    case            value -> (value -> comp) -> (value -> comp) -> comp.
type    force           value -> comp.
type    bind            comp -> (value -> comp) -> comp.
type    app             comp -> value -> comp.


kind    evctx     type.

type    hole            evctx.
type    evctx/bind      evctx -> (value -> comp) -> evctx.
type    evctx/app       evctx -> value -> evctx.

type    of/value        value -> valty -> o.
type    of/comp         comp -> compty -> o.
type    of/evctx        evctx -> compty -> compty -> o.

type    plug            evctx -> comp -> comp -> o.
type    reduce          comp -> comp -> o.
type    step            comp -> comp -> o.
type    progresses      comp -> compty -> o.
