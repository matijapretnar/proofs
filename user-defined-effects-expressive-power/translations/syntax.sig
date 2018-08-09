sig syntax.

kind    mam/nat   type.

type    mam/z            mam/nat.
type    mam/s            mam/nat -> mam/nat.
type    mam/apart        mam/nat -> mam/nat -> o.

kind    mam/label   type.

type    mam/label/apart     mam/label -> mam/label -> o.

type    mam/lbl             mam/nat -> mam/label.

kind    mam/eff, mam/valty, mam/compty, mam/valtys   type.

type    mam/empty           mam/eff.

type    mam/unitty          mam/valty.
type    mam/prod            mam/valty -> mam/valty -> mam/valty.
type    mam/sum             mam/valtys -> mam/valty.
type    mam/u               mam/compty -> mam/valty.

type    mam/f               mam/eff -> mam/valty -> mam/compty.
type    mam/arrow           mam/valty -> mam/compty -> mam/compty.
type    mam/compprod        mam/compty -> mam/compty -> mam/compty.

type    mam/valtys/nil      mam/valtys.
type    mam/valtys/cons     mam/valtys -> mam/label -> mam/valty -> mam/valtys.

type    mam/eff-kind        mam/compty -> mam/eff -> o.
type    mam/valtys/get      mam/valtys -> mam/label -> mam/valty -> o.
type    mam/is-eff          mam/eff -> o.
type    mam/is-valty        mam/valty -> o.
type    mam/is-compty       mam/compty -> o.
type    mam/is-valtys       mam/valtys -> o.


kind    mam/value, mam/comp, mam/cases     type.

type    mam/unit            mam/value.
type    mam/pair            mam/value -> mam/value -> mam/value.
type    mam/inj             mam/label -> mam/value -> mam/value.
type    mam/thunk           mam/comp -> mam/value.

type    mam/ret             mam/value -> mam/comp.
type    mam/fun             (mam/value -> mam/comp) -> mam/comp.
type    mam/split           mam/value -> (mam/value -> mam/value -> mam/comp) -> mam/comp.
type    mam/case            mam/value -> mam/cases -> mam/comp.
type    mam/force           mam/value -> mam/comp.
type    mam/bind            mam/comp -> (mam/value -> mam/comp) -> mam/comp.
type    mam/app             mam/comp -> mam/value -> mam/comp.
type    mam/comppair        mam/comp -> mam/comp -> mam/comp.
type    mam/prj1            mam/comp -> mam/comp.
type    mam/prj2            mam/comp -> mam/comp.

type    mam/cases/nil       mam/cases.
type    mam/cases/cons      mam/cases -> mam/label -> (mam/value -> mam/comp) -> mam/cases.


kind    mam/evctx     type.

type    mam/hole            mam/evctx.
type    mam/evctx/bind      mam/evctx -> (mam/value -> mam/comp) -> mam/evctx.
type    mam/evctx/app       mam/evctx -> mam/value -> mam/evctx.
type    mam/evctx/prj1      mam/evctx -> mam/evctx.
type    mam/evctx/prj2      mam/evctx -> mam/evctx.

type    mam/hoisting        mam/evctx -> o.

type    mam/of/value        mam/value -> mam/valty -> o.
type    mam/of/comp         mam/comp -> mam/compty -> o.
type    mam/of/evctx        mam/evctx -> mam/compty -> mam/compty -> o.
type    mam/of/cases        mam/cases -> mam/valtys -> mam/compty -> o.

type    mam/get-case        mam/cases -> mam/label -> (mam/value -> mam/comp) -> o.     
type    mam/plug            mam/evctx -> mam/comp -> mam/comp -> o.
type    mam/reduce          mam/comp -> mam/comp -> o.
type    mam/step            mam/comp -> mam/comp -> o.
type    mam/progresses      mam/comp -> mam/compty -> o.


kind    mon/nat   type.

type    mon/z            mon/nat.
type    mon/s            mon/nat -> mon/nat.
type    mon/apart        mon/nat -> mon/nat -> o.

kind    mon/label   type.

type    mon/label/apart     mon/label -> mon/label -> o.

type    mon/lbl             mon/nat -> mon/label.

kind    mon/eff, mon/valty, mon/compty, mon/valtys   type.

type    mon/empty           mon/eff.

type    mon/unitty          mon/valty.
type    mon/prod            mon/valty -> mon/valty -> mon/valty.
type    mon/sum             mon/valtys -> mon/valty.
type    mon/u               mon/compty -> mon/valty.

type    mon/f               mon/eff -> mon/valty -> mon/compty.
type    mon/arrow           mon/valty -> mon/compty -> mon/compty.
type    mon/compprod        mon/compty -> mon/compty -> mon/compty.

type    mon/valtys/nil      mon/valtys.
type    mon/valtys/cons     mon/valtys -> mon/label -> mon/valty -> mon/valtys.

type    mon/eff-kind        mon/compty -> mon/eff -> o.
type    mon/valtys/get      mon/valtys -> mon/label -> mon/valty -> o.
type    mon/is-eff          mon/eff -> o.
type    mon/is-valty        mon/valty -> o.
type    mon/is-compty       mon/compty -> o.
type    mon/is-valtys       mon/valtys -> o.


kind    mon/value, mon/comp, mon/cases     type.

type    mon/unit            mon/value.
type    mon/pair            mon/value -> mon/value -> mon/value.
type    mon/inj             mon/label -> mon/value -> mon/value.
type    mon/thunk           mon/comp -> mon/value.

type    mon/ret             mon/value -> mon/comp.
type    mon/fun             (mon/value -> mon/comp) -> mon/comp.
type    mon/split           mon/value -> (mon/value -> mon/value -> mon/comp) -> mon/comp.
type    mon/case            mon/value -> mon/cases -> mon/comp.
type    mon/force           mon/value -> mon/comp.
type    mon/bind            mon/comp -> (mon/value -> mon/comp) -> mon/comp.
type    mon/app             mon/comp -> mon/value -> mon/comp.
type    mon/comppair        mon/comp -> mon/comp -> mon/comp.
type    mon/prj1            mon/comp -> mon/comp.
type    mon/prj2            mon/comp -> mon/comp.

type    mon/cases/nil       mon/cases.
type    mon/cases/cons      mon/cases -> mon/label -> (mon/value -> mon/comp) -> mon/cases.


kind    mon/evctx     type.

type    mon/hole            mon/evctx.
type    mon/evctx/bind      mon/evctx -> (mon/value -> mon/comp) -> mon/evctx.
type    mon/evctx/app       mon/evctx -> mon/value -> mon/evctx.
type    mon/evctx/prj1      mon/evctx -> mon/evctx.
type    mon/evctx/prj2      mon/evctx -> mon/evctx.

type    mon/hoisting        mon/evctx -> o.

type    mon/of/value        mon/value -> mon/valty -> o.
type    mon/of/comp         mon/comp -> mon/compty -> o.
type    mon/of/evctx        mon/evctx -> mon/compty -> mon/compty -> o.
type    mon/of/cases        mon/cases -> mon/valtys -> mon/compty -> o.

type    mon/get-case        mon/cases -> mon/label -> (mon/value -> mon/comp) -> o.     
type    mon/plug            mon/evctx -> mon/comp -> mon/comp -> o.
type    mon/reduce          mon/comp -> mon/comp -> o.
type    mon/step            mon/comp -> mon/comp -> o.
type    mon/progresses      mon/comp -> mon/compty -> o.


type    mon/cons            mon/eff -> (mon/valty -> mon/compty) -> (mon/value -> mon/comp) -> (mon/value -> mon/value -> mon/comp) -> mon/eff.

kind    mon/monad           type.
type    mon/mon             (mon/value -> mon/comp) -> (mon/value -> mon/value -> mon/comp) -> mon/monad.

type    mon/reflect         mon/comp -> mon/comp.
type    mon/reify           mon/comp -> mon/monad -> mon/comp.

type    mon/of/monad        mon/monad -> mon/eff -> o.

type    mon/evctx/reify     mon/evctx -> mon/monad -> mon/evctx.


kind    del/nat   type.

type    del/z            del/nat.
type    del/s            del/nat -> del/nat.
type    del/apart        del/nat -> del/nat -> o.

kind    del/label   type.

type    del/label/apart     del/label -> del/label -> o.

type    del/lbl             del/nat -> del/label.

kind    del/eff, del/valty, del/compty, del/valtys   type.

type    del/empty           del/eff.

type    del/unitty          del/valty.
type    del/prod            del/valty -> del/valty -> del/valty.
type    del/sum             del/valtys -> del/valty.
type    del/u               del/compty -> del/valty.

type    del/f               del/eff -> del/valty -> del/compty.
type    del/arrow           del/valty -> del/compty -> del/compty.
type    del/compprod        del/compty -> del/compty -> del/compty.

type    del/valtys/nil      del/valtys.
type    del/valtys/cons     del/valtys -> del/label -> del/valty -> del/valtys.

type    del/eff-kind        del/compty -> del/eff -> o.
type    del/valtys/get      del/valtys -> del/label -> del/valty -> o.
type    del/is-eff          del/eff -> o.
type    del/is-valty        del/valty -> o.
type    del/is-compty       del/compty -> o.
type    del/is-valtys       del/valtys -> o.


kind    del/value, del/comp, del/cases     type.

type    del/unit            del/value.
type    del/pair            del/value -> del/value -> del/value.
type    del/inj             del/label -> del/value -> del/value.
type    del/thunk           del/comp -> del/value.

type    del/ret             del/value -> del/comp.
type    del/fun             (del/value -> del/comp) -> del/comp.
type    del/split           del/value -> (del/value -> del/value -> del/comp) -> del/comp.
type    del/case            del/value -> del/cases -> del/comp.
type    del/force           del/value -> del/comp.
type    del/bind            del/comp -> (del/value -> del/comp) -> del/comp.
type    del/app             del/comp -> del/value -> del/comp.
type    del/comppair        del/comp -> del/comp -> del/comp.
type    del/prj1            del/comp -> del/comp.
type    del/prj2            del/comp -> del/comp.

type    del/cases/nil       del/cases.
type    del/cases/cons      del/cases -> del/label -> (del/value -> del/comp) -> del/cases.


kind    del/evctx     type.

type    del/hole            del/evctx.
type    del/evctx/bind      del/evctx -> (del/value -> del/comp) -> del/evctx.
type    del/evctx/app       del/evctx -> del/value -> del/evctx.
type    del/evctx/prj1      del/evctx -> del/evctx.
type    del/evctx/prj2      del/evctx -> del/evctx.

type    del/hoisting        del/evctx -> o.

type    del/of/value        del/value -> del/valty -> o.
type    del/of/comp         del/comp -> del/compty -> o.
type    del/of/evctx        del/evctx -> del/compty -> del/compty -> o.
type    del/of/cases        del/cases -> del/valtys -> del/compty -> o.

type    del/get-case        del/cases -> del/label -> (del/value -> del/comp) -> o.     
type    del/plug            del/evctx -> del/comp -> del/comp -> o.
type    del/reduce          del/comp -> del/comp -> o.
type    del/step            del/comp -> del/comp -> o.
type    del/progresses      del/comp -> del/compty -> o.


type    del/cons            del/eff -> del/compty -> del/eff.

type    del/reset           del/comp -> (del/value -> del/comp) -> del/comp.
type    del/shift           (del/value -> del/comp) -> del/comp.

type    del/evctx/reset     del/evctx -> (del/value -> del/comp) -> del/evctx.


kind    eff/nat   type.

type    eff/z            eff/nat.
type    eff/s            eff/nat -> eff/nat.
type    eff/apart        eff/nat -> eff/nat -> o.

kind    eff/label   type.

type    eff/label/apart     eff/label -> eff/label -> o.

type    eff/lbl             eff/nat -> eff/label.

kind    eff/eff, eff/valty, eff/compty, eff/valtys   type.

type    eff/empty           eff/eff.

type    eff/unitty          eff/valty.
type    eff/prod            eff/valty -> eff/valty -> eff/valty.
type    eff/sum             eff/valtys -> eff/valty.
type    eff/u               eff/compty -> eff/valty.

type    eff/f               eff/eff -> eff/valty -> eff/compty.
type    eff/arrow           eff/valty -> eff/compty -> eff/compty.
type    eff/compprod        eff/compty -> eff/compty -> eff/compty.

type    eff/valtys/nil      eff/valtys.
type    eff/valtys/cons     eff/valtys -> eff/label -> eff/valty -> eff/valtys.

type    eff/eff-kind        eff/compty -> eff/eff -> o.
type    eff/valtys/get      eff/valtys -> eff/label -> eff/valty -> o.
type    eff/is-eff          eff/eff -> o.
type    eff/is-valty        eff/valty -> o.
type    eff/is-compty       eff/compty -> o.
type    eff/is-valtys       eff/valtys -> o.


kind    eff/value, eff/comp, eff/cases     type.

type    eff/unit            eff/value.
type    eff/pair            eff/value -> eff/value -> eff/value.
type    eff/inj             eff/label -> eff/value -> eff/value.
type    eff/thunk           eff/comp -> eff/value.

type    eff/ret             eff/value -> eff/comp.
type    eff/fun             (eff/value -> eff/comp) -> eff/comp.
type    eff/split           eff/value -> (eff/value -> eff/value -> eff/comp) -> eff/comp.
type    eff/case            eff/value -> eff/cases -> eff/comp.
type    eff/force           eff/value -> eff/comp.
type    eff/bind            eff/comp -> (eff/value -> eff/comp) -> eff/comp.
type    eff/app             eff/comp -> eff/value -> eff/comp.
type    eff/comppair        eff/comp -> eff/comp -> eff/comp.
type    eff/prj1            eff/comp -> eff/comp.
type    eff/prj2            eff/comp -> eff/comp.

type    eff/cases/nil       eff/cases.
type    eff/cases/cons      eff/cases -> eff/label -> (eff/value -> eff/comp) -> eff/cases.


kind    eff/evctx     type.

type    eff/hole            eff/evctx.
type    eff/evctx/bind      eff/evctx -> (eff/value -> eff/comp) -> eff/evctx.
type    eff/evctx/app       eff/evctx -> eff/value -> eff/evctx.
type    eff/evctx/prj1      eff/evctx -> eff/evctx.
type    eff/evctx/prj2      eff/evctx -> eff/evctx.

type    eff/hoisting        eff/evctx -> o.

type    eff/of/value        eff/value -> eff/valty -> o.
type    eff/of/comp         eff/comp -> eff/compty -> o.
type    eff/of/evctx        eff/evctx -> eff/compty -> eff/compty -> o.
type    eff/of/cases        eff/cases -> eff/valtys -> eff/compty -> o.

type    eff/get-case        eff/cases -> eff/label -> (eff/value -> eff/comp) -> o.     
type    eff/plug            eff/evctx -> eff/comp -> eff/comp -> o.
type    eff/reduce          eff/comp -> eff/comp -> o.
type    eff/step            eff/comp -> eff/comp -> o.
type    eff/progresses      eff/comp -> eff/compty -> o.


kind    eff/operation       type.

type    eff/op/apart        eff/operation -> eff/operation -> o.

type    eff/op              eff/nat -> eff/operation.

type    eff/cons            eff/eff -> eff/operation -> eff/valty -> eff/valty -> eff/eff.

type    eff/op-sig          eff/eff -> eff/operation -> eff/valty -> eff/valty -> o.


kind    eff/handler         type.

type    eff/valcase         (eff/value -> eff/comp) -> eff/handler.
type    eff/opcase          eff/handler -> eff/operation -> (eff/value -> eff/value -> eff/comp) -> eff/handler.

type    eff/get-valcase     eff/handler -> (eff/value -> eff/comp) -> o.
type    eff/get-opcase      eff/handler -> eff/operation -> (eff/value -> eff/value -> eff/comp) -> o.

type    eff/call            eff/operation -> eff/value -> eff/comp.
type    eff/handle          eff/comp -> eff/handler -> eff/comp.


type    eff/of/handler      eff/handler -> eff/valty -> eff/eff -> eff/compty -> o.

type    eff/evctx/handle    eff/evctx -> eff/handler -> eff/evctx.
