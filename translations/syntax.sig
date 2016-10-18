sig syntax.

kind    cbpv/nat   type.

type    cbpv/z            cbpv/nat.
type    cbpv/s            cbpv/nat -> cbpv/nat.
type    cbpv/apart        cbpv/nat -> cbpv/nat -> o.

kind    cbpv/label   type.

type    cbpv/label/apart     cbpv/label -> cbpv/label -> o.

type    cbpv/lbl             cbpv/nat -> cbpv/label.

kind    cbpv/eff, cbpv/valty, cbpv/compty, cbpv/valtys   type.

type    cbpv/empty           cbpv/eff.

type    cbpv/unitty          cbpv/valty.
type    cbpv/prod            cbpv/valty -> cbpv/valty -> cbpv/valty.
type    cbpv/sum             cbpv/valtys -> cbpv/valty.
type    cbpv/u               cbpv/compty -> cbpv/valty.

type    cbpv/f               cbpv/eff -> cbpv/valty -> cbpv/compty.
type    cbpv/arrow           cbpv/valty -> cbpv/compty -> cbpv/compty.

type    cbpv/valtys/nil      cbpv/valtys.
type    cbpv/valtys/cons     cbpv/valtys -> cbpv/label -> cbpv/valty -> cbpv/valtys.

type    cbpv/eff-kind        cbpv/compty -> cbpv/eff -> o.
type    cbpv/valtys/get      cbpv/valtys -> cbpv/label -> cbpv/valty -> o.


kind    cbpv/value, cbpv/comp, cbpv/cases     type.

type    cbpv/unit            cbpv/value.
type    cbpv/pair            cbpv/value -> cbpv/value -> cbpv/value.
type    cbpv/inj             cbpv/label -> cbpv/value -> cbpv/value.
type    cbpv/thunk           cbpv/comp -> cbpv/value.

type    cbpv/ret             cbpv/value -> cbpv/comp.
type    cbpv/fun             (cbpv/value -> cbpv/comp) -> cbpv/comp.
type    cbpv/split           cbpv/value -> (cbpv/value -> cbpv/value -> cbpv/comp) -> cbpv/comp.
type    cbpv/case            cbpv/value -> cbpv/cases -> cbpv/comp.
type    cbpv/force           cbpv/value -> cbpv/comp.
type    cbpv/bind            cbpv/comp -> (cbpv/value -> cbpv/comp) -> cbpv/comp.
type    cbpv/app             cbpv/comp -> cbpv/value -> cbpv/comp.

type    cbpv/cases/nil       cbpv/cases.
type    cbpv/cases/cons      cbpv/cases -> cbpv/label -> (cbpv/value -> cbpv/comp) -> cbpv/cases.


kind    cbpv/evctx     type.

type    cbpv/hole            cbpv/evctx.
type    cbpv/evctx/bind      cbpv/evctx -> (cbpv/value -> cbpv/comp) -> cbpv/evctx.
type    cbpv/evctx/app       cbpv/evctx -> cbpv/value -> cbpv/evctx.

type    cbpv/hoisting        cbpv/evctx -> o.

type    cbpv/of/value        cbpv/value -> cbpv/valty -> o.
type    cbpv/of/comp         cbpv/comp -> cbpv/compty -> o.
type    cbpv/of/evctx        cbpv/evctx -> cbpv/compty -> cbpv/compty -> o.
type    cbpv/of/cases        cbpv/cases -> cbpv/valtys -> cbpv/compty -> o.

type    cbpv/get-case        cbpv/cases -> cbpv/label -> (cbpv/value -> cbpv/comp) -> o.     
type    cbpv/plug            cbpv/evctx -> cbpv/comp -> cbpv/comp -> o.
type    cbpv/reduce          cbpv/comp -> cbpv/comp -> o.
type    cbpv/step            cbpv/comp -> cbpv/comp -> o.
type    cbpv/progresses      cbpv/comp -> cbpv/compty -> o.


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

type    mon/valtys/nil      mon/valtys.
type    mon/valtys/cons     mon/valtys -> mon/label -> mon/valty -> mon/valtys.

type    mon/eff-kind        mon/compty -> mon/eff -> o.
type    mon/valtys/get      mon/valtys -> mon/label -> mon/valty -> o.


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

type    mon/cases/nil       mon/cases.
type    mon/cases/cons      mon/cases -> mon/label -> (mon/value -> mon/comp) -> mon/cases.


kind    mon/evctx     type.

type    mon/hole            mon/evctx.
type    mon/evctx/bind      mon/evctx -> (mon/value -> mon/comp) -> mon/evctx.
type    mon/evctx/app       mon/evctx -> mon/value -> mon/evctx.

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

type    del/valtys/nil      del/valtys.
type    del/valtys/cons     del/valtys -> del/label -> del/valty -> del/valtys.

type    del/eff-kind        del/compty -> del/eff -> o.
type    del/valtys/get      del/valtys -> del/label -> del/valty -> o.


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

type    del/cases/nil       del/cases.
type    del/cases/cons      del/cases -> del/label -> (del/value -> del/comp) -> del/cases.


kind    del/evctx     type.

type    del/hole            del/evctx.
type    del/evctx/bind      del/evctx -> (del/value -> del/comp) -> del/evctx.
type    del/evctx/app       del/evctx -> del/value -> del/evctx.

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

type    eff/valtys/nil      eff/valtys.
type    eff/valtys/cons     eff/valtys -> eff/label -> eff/valty -> eff/valtys.

type    eff/eff-kind        eff/compty -> eff/eff -> o.
type    eff/valtys/get      eff/valtys -> eff/label -> eff/valty -> o.


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

type    eff/cases/nil       eff/cases.
type    eff/cases/cons      eff/cases -> eff/label -> (eff/value -> eff/comp) -> eff/cases.


kind    eff/evctx     type.

type    eff/hole            eff/evctx.
type    eff/evctx/bind      eff/evctx -> (eff/value -> eff/comp) -> eff/evctx.
type    eff/evctx/app       eff/evctx -> eff/value -> eff/evctx.

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


kind    eff/op              type.

type    eff/op/z            eff/op.
type    eff/op/s            eff/op -> eff/op.

type    eff/op/apart           eff/op -> eff/op -> o.


type    eff/cons            eff/eff -> eff/op -> eff/valty -> eff/valty -> eff/eff.

type    eff/op-sig          eff/eff -> eff/op -> eff/valty -> eff/valty -> o.


kind    eff/handler         type.

type    eff/valcase         (eff/value -> eff/comp) -> eff/handler.
type    eff/opcase          eff/handler -> eff/op -> (eff/value -> eff/value -> eff/comp) -> eff/handler.

type    eff/get-valcase     eff/handler -> (eff/value -> eff/comp) -> o.
type    eff/get-opcase      eff/handler -> eff/op -> (eff/value -> eff/value -> eff/comp) -> o.

type    eff/call            eff/op -> eff/value -> eff/comp.
type    eff/handle          eff/comp -> eff/handler -> eff/comp.


type    eff/of/handler      eff/handler -> eff/valty -> eff/eff -> eff/compty -> o.

type    eff/evctx/handle    eff/evctx -> eff/handler -> eff/evctx.
