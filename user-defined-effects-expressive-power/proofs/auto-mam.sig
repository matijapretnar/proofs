sig auto-mam.
accum_sig common.

kind    mam/eff               type.
kind    mam/valty             type.
kind    mam/compty            type.
kind    mam/valtys            type.

type    mam/empty             mam/eff.

type    mam/unitty            mam/valty.
type    mam/prod              mam/valty -> mam/valty -> mam/valty.
type    mam/sum               mam/valtys -> mam/valty.
type    mam/u                 mam/compty -> mam/valty.

type    mam/f                 mam/eff -> mam/valty -> mam/compty.
type    mam/arrow             mam/valty -> mam/compty -> mam/compty.
type    mam/compprod          mam/compty -> mam/compty -> mam/compty.

type    mam/valtys/nil        mam/valtys.
type    mam/valtys/cons       mam/valtys -> label -> mam/valty -> mam/valtys.

type    mam/eff-kind          mam/compty -> mam/eff -> o.
type    mam/valtys/get        mam/valtys -> label -> mam/valty -> o.
type    mam/is-eff            mam/eff -> o.
type    mam/is-valty          mam/valty -> o.
type    mam/is-compty         mam/compty -> o.
type    mam/is-valtys         mam/valtys -> o.


kind    mam/value             type.
kind    mam/comp              type.
kind    mam/cases             type.

type    mam/unit              mam/value.
type    mam/pair              mam/value -> mam/value -> mam/value.
type    mam/inj               label -> mam/value -> mam/value.
type    mam/thunk             mam/comp -> mam/value.

type    mam/ret               mam/value -> mam/comp.
type    mam/fun               (mam/value -> mam/comp) -> mam/comp.
type    mam/split             mam/value -> (mam/value -> mam/value -> mam/comp) -> mam/comp.
type    mam/case              mam/value -> mam/cases -> mam/comp.
type    mam/force             mam/value -> mam/comp.
type    mam/bind              mam/comp -> (mam/value -> mam/comp) -> mam/comp.
type    mam/app               mam/comp -> mam/value -> mam/comp.
type    mam/comppair          mam/comp -> mam/comp -> mam/comp.
type    mam/prj1              mam/comp -> mam/comp.
type    mam/prj2              mam/comp -> mam/comp.

type    mam/cases/nil         mam/cases.
type    mam/cases/cons        mam/cases -> label -> (mam/value -> mam/comp) -> mam/cases.


kind    mam/evctx             type.
type    mam/is-evctx          mam/evctx -> o.

type    mam/hole              mam/evctx.
type    mam/evctx/bind        mam/evctx -> (mam/value -> mam/comp) -> mam/evctx.
type    mam/evctx/app         mam/evctx -> mam/value -> mam/evctx.
type    mam/evctx/prj1        mam/evctx -> mam/evctx.
type    mam/evctx/prj2        mam/evctx -> mam/evctx.

type    mam/hoisting          mam/evctx -> o.

type    mam/of-value          mam/value -> mam/valty -> o.
type    mam/of-comp           mam/comp -> mam/compty -> o.
type    mam/of-evctx          mam/evctx -> mam/compty -> mam/compty -> o.
type    mam/of-cases          mam/cases -> mam/valtys -> mam/compty -> o.

type    mam/get-case          mam/cases -> label -> (mam/value -> mam/comp) -> o.     
type    mam/plug              mam/evctx -> mam/comp -> mam/comp -> o.
type    mam/reduce            mam/comp -> mam/comp -> o.
type    mam/step              mam/comp -> mam/comp -> o.
type    mam/progresses        mam/comp -> mam/compty -> o.
