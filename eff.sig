sig eff.

accum_sig cbpv.

kind    op              type.

type    op/z            op.
type    op/s            op -> op.

type    apart           op -> op -> o.


type    cons            eff -> op -> valty -> valty -> eff.

type    op-sig          eff -> op -> valty -> valty -> o.


kind    handler         type.

type    valcase         (value -> comp) -> handler.
type    opcase          handler -> op -> (value -> value -> comp) -> handler.

type    get-valcase     handler -> (value -> comp) -> o.
type    get-opcase      handler -> op -> (value -> value -> comp) -> o.

type    call            op -> value -> comp.
type    handle          comp -> handler -> comp.


type    of/handler      handler -> valty -> eff -> compty -> o.

type    evctx/handle    evctx -> handler -> evctx.

type    handlerfree     evctx -> o.
