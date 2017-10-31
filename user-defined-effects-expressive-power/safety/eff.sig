sig eff.

accum_sig mam.

kind    operation       type.

type    op/apart        operation -> operation -> o.

type    op              nat -> operation.

type    cons            eff -> operation -> valty -> valty -> eff.

type    op-sig          eff -> operation -> valty -> valty -> o.


kind    handler         type.

type    valcase         (value -> comp) -> handler.
type    opcase          handler -> operation -> (value -> value -> comp) -> handler.

type    get-valcase     handler -> (value -> comp) -> o.
type    get-opcase      handler -> operation -> (value -> value -> comp) -> o.

type    call            operation -> value -> comp.
type    handle          comp -> handler -> comp.


type    of/handler      handler -> valty -> eff -> compty -> o.

type    evctx/handle    evctx -> handler -> evctx.
