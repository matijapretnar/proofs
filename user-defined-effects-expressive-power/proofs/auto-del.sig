sig auto-del.
accum_sig common.

kind    del/eff               type.
kind    del/valty             type.
kind    del/compty            type.
kind    del/valtys            type.

type    del/empty             del/eff.

type    del/unitty            del/valty.
type    del/prod              del/valty -> del/valty -> del/valty.
type    del/sum               del/valtys -> del/valty.
type    del/u                 del/eff -> del/compty -> del/valty.

type    del/f                 del/valty -> del/compty.
type    del/arrow             del/valty -> del/compty -> del/compty.
type    del/compprod          del/compty -> del/compty -> del/compty.

type    del/valtys/nil        del/valtys.
type    del/valtys/cons       del/valtys -> label -> del/valty -> del/valtys.

type    del/valtys/get        del/valtys -> label -> del/valty -> o.
type    del/wf-eff            del/eff -> o.
type    del/wf-valty          del/valty -> o.
type    del/wf-compty         del/eff -> del/compty -> o.
type    del/wf-valtys         del/valtys -> o.


kind    del/value             type.
kind    del/comp              type.
kind    del/cases             type.

type    del/unit              del/value.
type    del/pair              del/value -> del/value -> del/value.
type    del/inj               label -> del/value -> del/value.
type    del/thunk             del/comp -> del/value.

type    del/ret               del/value -> del/comp.
type    del/fun               (del/value -> del/comp) -> del/comp.
type    del/split             del/value -> (del/value -> del/value -> del/comp) -> del/comp.
type    del/case              del/value -> del/cases -> del/comp.
type    del/force             del/value -> del/comp.
type    del/bind              del/comp -> (del/value -> del/comp) -> del/comp.
type    del/app               del/comp -> del/value -> del/comp.
type    del/comppair          del/comp -> del/comp -> del/comp.
type    del/prj1              del/comp -> del/comp.
type    del/prj2              del/comp -> del/comp.

type    del/cases/nil         del/cases.
type    del/cases/cons        del/cases -> label -> (del/value -> del/comp) -> del/cases.


kind    del/evctx             type.
type    del/is-evctx          del/evctx -> o.

type    del/hole              del/evctx.
type    del/evctx/bind        del/evctx -> (del/value -> del/comp) -> del/evctx.
type    del/evctx/app         del/evctx -> del/value -> del/evctx.
type    del/evctx/prj1        del/evctx -> del/evctx.
type    del/evctx/prj2        del/evctx -> del/evctx.

type    del/hoisting          del/evctx -> o.

type    del/of-value          del/value -> del/valty -> o.
type    del/of-comp           del/comp -> del/eff -> del/compty -> o.
type    del/of-evctx          del/evctx -> del/eff -> del/compty -> del/eff -> del/compty -> o.
type    del/of-cases          del/cases -> del/eff -> del/valtys -> del/compty -> o.
type    del/of-value'         del/value -> del/valty -> o.
type    del/of-comp'          del/comp -> del/eff -> del/compty -> o.
type    del/of-cases'         del/cases -> del/eff -> del/valtys -> del/compty -> o.
type    del/of-evctx'         del/evctx -> del/eff -> del/compty -> del/eff -> del/compty -> o.

type    del/get-case          del/cases -> label -> (del/value -> del/comp) -> o.     
type    del/plug              del/evctx -> del/comp -> del/comp -> o.
type    del/reduce            del/comp -> del/comp -> o.
type    del/step              del/comp -> del/comp -> o.
type    del/progresses        del/comp -> del/eff -> o.
