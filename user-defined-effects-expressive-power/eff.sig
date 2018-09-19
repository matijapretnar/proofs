sig eff.
accum_sig auto-eff.

kind    eff/operation       type.

type    eff/op/apart        eff/operation -> eff/operation -> o.

type    eff/op              nat -> eff/operation.

type    eff/cons            eff/eff -> eff/operation -> eff/valty -> eff/valty -> eff/eff.

type    eff/op-sig          eff/eff -> eff/operation -> eff/valty -> eff/valty -> o.


kind    eff/handler         type.

type    eff/valcase         (eff/value -> eff/comp) -> eff/handler.
type    eff/opcase          eff/handler -> eff/operation -> (eff/value -> eff/value -> eff/comp) -> eff/handler.

type    eff/get-valcase     eff/handler -> (eff/value -> eff/comp) -> o.
type    eff/get-opcase      eff/handler -> eff/operation -> (eff/value -> eff/value -> eff/comp) -> o.

type    eff/call            eff/operation -> eff/value -> eff/comp.
type    eff/handle          eff/comp -> eff/handler -> eff/comp.


type    eff/of-handler      eff/handler -> eff/valty -> eff/eff -> eff/eff -> eff/compty -> o.
type    eff/of-handler'      eff/handler -> eff/valty -> eff/eff -> eff/eff -> eff/compty -> o.

type    eff/evctx/handle    eff/evctx -> eff/handler -> eff/evctx.
