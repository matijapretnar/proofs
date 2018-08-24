sig auto-eff.
accum_sig common.

kind    eff/eff               type.
kind    eff/valty             type.
kind    eff/compty            type.
kind    eff/valtys            type.

type    eff/empty             eff/eff.

type    eff/unitty            eff/valty.
type    eff/prod              eff/valty -> eff/valty -> eff/valty.
type    eff/sum               eff/valtys -> eff/valty.
type    eff/u                 eff/compty -> eff/valty.

type    eff/f                 eff/eff -> eff/valty -> eff/compty.
type    eff/arrow             eff/valty -> eff/compty -> eff/compty.
type    eff/compprod          eff/compty -> eff/compty -> eff/compty.

type    eff/valtys/nil        eff/valtys.
type    eff/valtys/cons       eff/valtys -> label -> eff/valty -> eff/valtys.

type    eff/eff-kind          eff/compty -> eff/eff -> o.
type    eff/valtys/get        eff/valtys -> label -> eff/valty -> o.
type    eff/wf-eff            eff/eff -> o.
type    eff/wf-valty          eff/valty -> o.
type    eff/wf-compty         eff/compty -> o.
type    eff/wf-valtys         eff/valtys -> o.


kind    eff/value             type.
kind    eff/comp              type.
kind    eff/cases             type.

type    eff/unit              eff/value.
type    eff/pair              eff/value -> eff/value -> eff/value.
type    eff/inj               label -> eff/value -> eff/value.
type    eff/thunk             eff/comp -> eff/value.

type    eff/ret               eff/value -> eff/comp.
type    eff/fun               (eff/value -> eff/comp) -> eff/comp.
type    eff/split             eff/value -> (eff/value -> eff/value -> eff/comp) -> eff/comp.
type    eff/case              eff/value -> eff/cases -> eff/comp.
type    eff/force             eff/value -> eff/comp.
type    eff/bind              eff/comp -> (eff/value -> eff/comp) -> eff/comp.
type    eff/app               eff/comp -> eff/value -> eff/comp.
type    eff/comppair          eff/comp -> eff/comp -> eff/comp.
type    eff/prj1              eff/comp -> eff/comp.
type    eff/prj2              eff/comp -> eff/comp.

type    eff/cases/nil         eff/cases.
type    eff/cases/cons        eff/cases -> label -> (eff/value -> eff/comp) -> eff/cases.


kind    eff/evctx             type.
type    eff/is-evctx          eff/evctx -> o.

type    eff/hole              eff/evctx.
type    eff/evctx/bind        eff/evctx -> (eff/value -> eff/comp) -> eff/evctx.
type    eff/evctx/app         eff/evctx -> eff/value -> eff/evctx.
type    eff/evctx/prj1        eff/evctx -> eff/evctx.
type    eff/evctx/prj2        eff/evctx -> eff/evctx.

type    eff/hoisting          eff/evctx -> o.

type    eff/of-value          eff/value -> eff/valty -> o.
type    eff/of-comp           eff/comp -> eff/compty -> o.
type    eff/of-evctx          eff/evctx -> eff/compty -> eff/compty -> o.
type    eff/of-cases          eff/cases -> eff/valtys -> eff/compty -> o.

type    eff/get-case          eff/cases -> label -> (eff/value -> eff/comp) -> o.     
type    eff/plug              eff/evctx -> eff/comp -> eff/comp -> o.
type    eff/reduce            eff/comp -> eff/comp -> o.
type    eff/step              eff/comp -> eff/comp -> o.
type    eff/progresses        eff/comp -> eff/compty -> o.
