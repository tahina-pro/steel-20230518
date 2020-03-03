module Steel.Channel.Protocol

[@erasable]
noeq
type prot : Type -> Type =
| Return  : #a:Type -> v:a -> prot a
| Msg     : a:Type -> #b:Type -> k:(a -> prot b) -> prot b
| DoWhile : prot bool -> #a:Type -> k:prot a -> prot a

module WF = FStar.WellFounded

let rec ok #a (p:prot a) =
  match p with
  | Return _ -> True
  | Msg a k -> (forall x. (WF.axiom1 k x; ok (k x)))
  | DoWhile p k -> Msg? p /\ ok p /\ ok k

let protocol a = p:prot a { ok p }

let rec bind #a #b (p:protocol a) (q:(a -> protocol b))
  : protocol b
  = match p with
    | Return v -> q v
    | Msg c #a' k ->
      let k : c -> protocol b =
        fun x -> WF.axiom1 k x;
              bind (k x) q
      in
      Msg c k
    | DoWhile w k -> DoWhile w (bind k q)

let return (#a:Type) (x:a) : protocol a = Return x
let msg (t:Type) : protocol t = Msg t (fun x -> return x)

let xy : prot unit =
  x <-- msg int;
  y <-- msg (y:int{y = x + 1});
  return ()

let rec hnf (p:protocol 'a)
  : (q:protocol 'a{(Return? q \/ Msg? q) /\ (~(DoWhile? p) ==> (p == q))})
  = match p with
    | DoWhile p k -> b <-- hnf p ; if b then DoWhile p k else k
    | _ -> p

let finished (p:protocol 'a) : GTot bool = Return? (hnf p)
let more_msgs (p:protocol 'a) : GTot bool = Msg? (hnf p)
let next_msg_t (p:protocol 'a) : Type = match hnf p with | Msg a _ -> a | Return #a _ -> a
let step (p:protocol 'a{more_msgs p}) (x:next_msg_t p) : protocol 'a = Msg?.k (hnf p) x

noeq
type trace : from:protocol unit -> to:protocol unit -> Type =
  | Waiting  : p:protocol unit -> trace p p
  | Message  : from:protocol unit{more_msgs from} ->
               x:next_msg_t from ->
               to:protocol unit ->
               trace (step from x) to->
               trace from to

let rec extend (#from #to:protocol unit)
               (t:trace from to{more_msgs to})
               (m:next_msg_t to)
  : Tot (trace from (step to m)) (decreases t)
  = match t with
    | Waiting _ ->
      Message _ _ _ (Waiting (step to m))
    | Message _from x _to tail ->
      Message _ _ _ (extend tail m)

let rec last_step_of (#from #to:protocol unit)
                     (t:trace from to { ~ (Waiting? t) })

   : Tot (q:protocol unit &
          x:next_msg_t q &
          _:squash (more_msgs q /\to == step q x))
         (decreases t)
   = match t with
     | Message _ x _ (Waiting _) -> (| from , x, () |)
     | Message _ _ _ tail -> last_step_of tail

noeq
type partial_trace_of (p:protocol unit) = {
  to:protocol unit;
  tr:trace p to
}

module P = FStar.Preorder
module R = FStar.ReflexiveTransitiveClosure

let next (#p:protocol unit) : P.relation (partial_trace_of p) =
  fun (t0 t1: partial_trace_of p) ->
    more_msgs t0.to /\
    (exists (msg:next_msg_t t0.to).
      t1.to == step t0.to msg /\
      t1.tr == extend t0.tr msg)

let extended_to (#p:protocol unit) : P.preorder (partial_trace_of p) =
  R.closure (next #p)

let extend_partial_trace (#p:protocol unit)
                         (x:partial_trace_of p)
                         (msg:next_msg_t x.to{more_msgs x.to})
  : Tot (y:partial_trace_of p{x `extended_to` y})
  = { to=_; tr=extend x.tr msg}


let more (p:protocol unit) = more_msgs p
let msg_t (p:protocol unit) = next_msg_t p
let extension_of #p (tr:partial_trace_of p) = ts:partial_trace_of p{tr `extended_to` ts}
let until #p (tr:partial_trace_of p) = tr.to
