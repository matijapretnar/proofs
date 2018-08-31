sig stlc.

kind  src/ty  type.

type  src/unitty  src/ty.
type  src/arrow  src/ty -> src/ty -> src/ty.

kind  src/tm  type.

type  src/unit  src/tm.
type  src/fun  (src/tm -> src/tm) -> src/tm.
type  src/app  src/tm -> src/tm -> src/tm.

type  src/wf  src/ty -> o.
type  src/of  src/tm -> src/ty -> o.
type  src/of'  src/tm -> src/ty -> o.


kind  trg/ty  type.

type  trg/unitty  trg/ty.
type  trg/arrow  trg/ty -> trg/ty -> trg/ty.

kind  trg/tm  type.

type  trg/unit  trg/tm.
type  trg/fun  (trg/tm -> trg/tm) -> trg/tm.
type  trg/app  trg/tm -> trg/tm -> trg/tm.

type  trg/wf  trg/ty -> o.
type  trg/of  trg/tm -> trg/ty -> o.
type  trg/of'  trg/tm -> trg/ty -> o.


type  s2t/ty  src/ty -> trg/ty -> o.
type  s2t/tm  src/tm -> trg/tm -> o.
