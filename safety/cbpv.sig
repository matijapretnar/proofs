sig cbpv.

kind    nat   type.

type    z            nat.
type    s            nat -> nat.
type    apart        nat -> nat -> o.

kind    label   type.

type    label/apart     label -> label -> o.

type    lbl             nat -> label.

kind    eff, valty, compty, valtys   type.

type    empty           eff.

type    unitty          valty.
type    prod            valty -> valty -> valty.
type    sum             valtys -> valty.
type    u               compty -> valty.

type    f               eff -> valty -> compty.
type    arrow           valty -> compty -> compty.

type    valtys/nil      valtys.
type    valtys/cons     valtys -> label -> valty -> valtys.

type    eff-kind        compty -> eff -> o.
type    valtys/get      valtys -> label -> valty -> o.


kind    value, comp, cases     type.

type    unit            value.
type    pair            value -> value -> value.
type    inj             label -> value -> value.
type    thunk           comp -> value.

type    ret             value -> comp.
type    fun             (value -> comp) -> comp.
type    split           value -> (value -> value -> comp) -> comp.
type    case            value -> cases -> comp.
type    force           value -> comp.
type    bind            comp -> (value -> comp) -> comp.
type    app             comp -> value -> comp.

type    cases/nil       cases.
type    cases/cons      cases -> label -> (value -> comp) -> cases.


kind    evctx     type.

type    hole            evctx.
type    evctx/bind      evctx -> (value -> comp) -> evctx.
type    evctx/app       evctx -> value -> evctx.

type    hoisting        evctx -> o.

type    of/value        value -> valty -> o.
type    of/comp         comp -> compty -> o.
type    of/evctx        evctx -> compty -> compty -> o.
type    of/cases        cases -> valtys -> compty -> o.

type    get-case        cases -> label -> (value -> comp) -> o.     
type    plug            evctx -> comp -> comp -> o.
type    reduce          comp -> comp -> o.
type    step            comp -> comp -> o.
type    progresses      comp -> compty -> o.
