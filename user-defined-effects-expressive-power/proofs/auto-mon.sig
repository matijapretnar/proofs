sig auto-mon.
accum_sig common.

kind    mon/eff               type.
kind    mon/valty             type.
kind    mon/compty            type.
kind    mon/valtys            type.

type    mon/empty             mon/eff.

type    mon/unitty            mon/valty.
type    mon/prod              mon/valty -> mon/valty -> mon/valty.
type    mon/sum               mon/valtys -> mon/valty.
type    mon/u                 mon/compty -> mon/valty.

type    mon/f                 mon/eff -> mon/valty -> mon/compty.
type    mon/arrow             mon/valty -> mon/compty -> mon/compty.
type    mon/compprod          mon/compty -> mon/compty -> mon/compty.

type    mon/valtys/nil        mon/valtys.
type    mon/valtys/cons       mon/valtys -> label -> mon/valty -> mon/valtys.

type    mon/eff-kind          mon/compty -> mon/eff -> o.
type    mon/valtys/get        mon/valtys -> label -> mon/valty -> o.
type    mon/is-eff            mon/eff -> o.
type    mon/is-valty          mon/valty -> o.
type    mon/is-compty         mon/compty -> o.
type    mon/is-valtys         mon/valtys -> o.


kind    mon/value             type.
kind    mon/comp              type.
kind    mon/cases             type.

type    mon/unit              mon/value.
type    mon/pair              mon/value -> mon/value -> mon/value.
type    mon/inj               label -> mon/value -> mon/value.
type    mon/thunk             mon/comp -> mon/value.

type    mon/ret               mon/value -> mon/comp.
type    mon/fun               (mon/value -> mon/comp) -> mon/comp.
type    mon/split             mon/value -> (mon/value -> mon/value -> mon/comp) -> mon/comp.
type    mon/case              mon/value -> mon/cases -> mon/comp.
type    mon/force             mon/value -> mon/comp.
type    mon/bind              mon/comp -> (mon/value -> mon/comp) -> mon/comp.
type    mon/app               mon/comp -> mon/value -> mon/comp.
type    mon/comppair          mon/comp -> mon/comp -> mon/comp.
type    mon/prj1              mon/comp -> mon/comp.
type    mon/prj2              mon/comp -> mon/comp.

type    mon/cases/nil         mon/cases.
type    mon/cases/cons        mon/cases -> label -> (mon/value -> mon/comp) -> mon/cases.


kind    mon/evctx             type.
type    mon/is-evctx          mon/evctx -> o.

type    mon/hole              mon/evctx.
type    mon/evctx/bind        mon/evctx -> (mon/value -> mon/comp) -> mon/evctx.
type    mon/evctx/app         mon/evctx -> mon/value -> mon/evctx.
type    mon/evctx/prj1        mon/evctx -> mon/evctx.
type    mon/evctx/prj2        mon/evctx -> mon/evctx.

type    mon/hoisting          mon/evctx -> o.

type    mon/of-value          mon/value -> mon/valty -> o.
type    mon/of-comp           mon/comp -> mon/compty -> o.
type    mon/of-evctx          mon/evctx -> mon/compty -> mon/compty -> o.
type    mon/of-cases          mon/cases -> mon/valtys -> mon/compty -> o.

type    mon/get-case          mon/cases -> label -> (mon/value -> mon/comp) -> o.     
type    mon/plug              mon/evctx -> mon/comp -> mon/comp -> o.
type    mon/reduce            mon/comp -> mon/comp -> o.
type    mon/step              mon/comp -> mon/comp -> o.
type    mon/progresses        mon/comp -> mon/compty -> o.
