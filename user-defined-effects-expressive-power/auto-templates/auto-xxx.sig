sig auto-xxx.
accum_sig common.

kind    xxx/eff               type.
kind    xxx/valty             type.
kind    xxx/compty            type.
kind    xxx/valtys            type.

type    xxx/empty             xxx/eff.

type    xxx/unitty            xxx/valty.
type    xxx/prod              xxx/valty -> xxx/valty -> xxx/valty.
type    xxx/sum               xxx/valtys -> xxx/valty.
type    xxx/u                 xxx/eff -> xxx/compty -> xxx/valty.

type    xxx/f                 xxx/valty -> xxx/compty.
type    xxx/arrow             xxx/valty -> xxx/compty -> xxx/compty.
type    xxx/compprod          xxx/compty -> xxx/compty -> xxx/compty.

type    xxx/valtys/nil        xxx/valtys.
type    xxx/valtys/cons       xxx/valtys -> label -> xxx/valty -> xxx/valtys.

type    xxx/valtys/get        xxx/valtys -> label -> xxx/valty -> o.
type    xxx/wf-eff            xxx/eff -> o.
type    xxx/wf-valty          xxx/valty -> o.
type    xxx/wf-compty         xxx/eff -> xxx/compty -> o.
type    xxx/wf-valtys         xxx/valtys -> o.


kind    xxx/value             type.
kind    xxx/comp              type.
kind    xxx/cases             type.

type    xxx/unit              xxx/value.
type    xxx/pair              xxx/value -> xxx/value -> xxx/value.
type    xxx/inj               label -> xxx/value -> xxx/value.
type    xxx/thunk             xxx/comp -> xxx/value.

type    xxx/ret               xxx/value -> xxx/comp.
type    xxx/fun               (xxx/value -> xxx/comp) -> xxx/comp.
type    xxx/split             xxx/value -> (xxx/value -> xxx/value -> xxx/comp) -> xxx/comp.
type    xxx/case              xxx/value -> xxx/cases -> xxx/comp.
type    xxx/force             xxx/value -> xxx/comp.
type    xxx/bind              xxx/comp -> (xxx/value -> xxx/comp) -> xxx/comp.
type    xxx/app               xxx/comp -> xxx/value -> xxx/comp.
type    xxx/comppair          xxx/comp -> xxx/comp -> xxx/comp.
type    xxx/prj1              xxx/comp -> xxx/comp.
type    xxx/prj2              xxx/comp -> xxx/comp.

type    xxx/cases/nil         xxx/cases.
type    xxx/cases/cons        xxx/cases -> label -> (xxx/value -> xxx/comp) -> xxx/cases.


kind    xxx/evctx             type.

type    xxx/hole              xxx/evctx.
type    xxx/evctx/bind        xxx/evctx -> (xxx/value -> xxx/comp) -> xxx/evctx.
type    xxx/evctx/app         xxx/evctx -> xxx/value -> xxx/evctx.
type    xxx/evctx/prj1        xxx/evctx -> xxx/evctx.
type    xxx/evctx/prj2        xxx/evctx -> xxx/evctx.

type    xxx/hoisting          xxx/evctx -> o.

type    xxx/of-value          xxx/value -> xxx/valty -> o.
type    xxx/of-comp           xxx/comp -> xxx/eff -> xxx/compty -> o.
type    xxx/of-evctx          xxx/evctx -> xxx/eff -> xxx/compty -> xxx/eff -> xxx/compty -> o.
type    xxx/of-cases          xxx/cases -> xxx/eff -> xxx/valtys -> xxx/compty -> o.
type    xxx/of-value'         xxx/value -> xxx/valty -> o.
type    xxx/of-comp'          xxx/comp -> xxx/eff -> xxx/compty -> o.
type    xxx/of-cases'         xxx/cases -> xxx/eff -> xxx/valtys -> xxx/compty -> o.
type    xxx/of-evctx'         xxx/evctx -> xxx/eff -> xxx/compty -> xxx/eff -> xxx/compty -> o.

type    xxx/get-case          xxx/cases -> label -> (xxx/value -> xxx/comp) -> o.     
type    xxx/plug              xxx/evctx -> xxx/comp -> xxx/comp -> o.
type    xxx/reduce            xxx/comp -> xxx/comp -> o.
type    xxx/step              xxx/comp -> xxx/comp -> o.
type    xxx/progresses        xxx/comp -> xxx/eff -> o.
