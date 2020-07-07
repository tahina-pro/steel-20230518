(*
   Copyright 2020 Microsoft Research

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*)

module Steel.FramingSpinLock
open Steel.FramingEffect
open Steel.FramingEffect.Atomic
open Steel.FramingReference
open Steel.FractionalPermission
//open Steel.SteelT.Basics
module Atomic = Steel.FramingEffect.Atomic

let available = false
let locked = true

let lockinv (p:slprop) (r:ref bool) : slprop =
  h_exists (fun b -> pts_to r full_perm (Ghost.hide b) `star` (if b then emp else p))

let lock_t = ref bool & iname

let protects (l:lock_t) (p:slprop) : prop = snd l >--> lockinv p (fst l)

val intro_lockinv_available (#uses:inames) (p:slprop) (r:ref bool)
  : SteelAtomic unit uses unobservable (pts_to r full_perm available `star` p) (fun _ -> lockinv p r)

val intro_lockinv_locked (#uses:inames) (p:slprop) (r:ref bool)
  : SteelAtomic unit uses unobservable (pts_to r full_perm locked) (fun _ -> lockinv p r)

let intro_lockinv_available #uses p r =
  Atomic.intro_h_exists false
    (fun (b: bool) ->
      pts_to r full_perm (Ghost.hide b) `star`
        (if b then emp else p)
    )

let intro_lockinv_locked #uses p r =
  let open Atomic in
  intro_h_exists true
    (fun b -> pts_to r full_perm (Ghost.hide b) `star`
          (if b then emp else p))

val new_inv (p:slprop) : SteelT (inv p) p (fun _ -> emp)
let new_inv p = Atomic.new_invariant Set.empty p

#set-options "--fuel 0 --ifuel 0"

let new_lock (p:slprop)
  : SteelT (lock p) p (fun _ -> emp) =
  let r = alloc available in
  intro_lockinv_available p r;
  let i:inv (lockinv p r) = new_inv (lockinv p r) in
  let l:lock p = (r, i) in
  l

#set-options "--fuel 0 --ifuel 0"
val cas_frame
  (#t:eqtype)
  (#uses:inames)
  (r:ref t)
  (v:Ghost.erased t)
  (v_old:t)
  (v_new:t)
  (frame:slprop)
  : SteelAtomic
    (b:bool{b <==> (Ghost.reveal v == v_old)})
    uses
    observable
    (pts_to r full_perm v `star` frame)
    (fun b -> (if b then pts_to r full_perm v_new else pts_to r full_perm v) `star` frame)
let cas_frame #t #uses r v v_old v_new frame =
  let x = Steel.FramingReference.cas r v v_old v_new in
  x


assume
val acquire_core (#p:slprop) (#u:inames) (r:ref bool) (i:inv (lockinv p r))
  : SteelAtomic bool u observable
    (lockinv p r `star` emp)
    (fun b -> lockinv p r `star` (if b then p else emp))

(*
let acquire_core #p #u r i =
  // Atomic.h_commute (lockinv p r) emp;
  // Atomic.h_elim_emp_l (lockinv p r);
  let ghost = Atomic.witness_h_exists () in
  let frame : slprop = if Ghost.reveal ghost then emp else p in

  let res = cas r ghost available locked in

  intro_lockinv_locked p r;
  res
  // Atomic.frame (if Ghost.reveal ghost then emp else p) (fun _ -> intro_lockinv_locked p r);

  // return_atomic #_ #_ #(fun b -> lockinv p r `star` (if b then p else emp)) res
*)


let acquire' (#p:slprop) (l:lock p)
  : SteelAtomic bool Set.empty observable emp (fun b -> if b then p else emp)
  = let r:ref bool = fst l in
    let i: inv (lockinv p r) = snd l in
    let b = with_invariant  i (fun _ -> acquire_core r i) in
    b
//    return_atomic #_ #_ #_ b

assume
val cond (#a:Type) (b:bool) (p: bool -> slprop) (q: bool -> a -> slprop)
         (then_: (unit -> SteelT a (p true) (q true)))
         (else_: (unit -> SteelT a (p false) (q false)))
  : SteelT a (p b) (q b)

assume
val noop (#p:slprop) (u:unit) : SteelT unit p (fun _ -> p)

let rec acquire #p l =
  let b = acquire' l in
  cond b (fun b -> if b then p else emp) (fun _ _ -> p) noop (fun _ -> acquire l)

assume
val release_core (#p:slprop) (#u:inames) (r:ref bool) (i:inv (lockinv p r))
  : SteelAtomic bool u observable
    (lockinv p r `star` p)
    (fun b -> lockinv p r `star` (if b then emp else p))

(*
let release_core #p #u r i =
  let open Atomic in
  h_assert_atomic (h_exists (fun b -> pts_to r full_perm (Ghost.hide b) `star` (if b then emp else p))
    `star` p);
  let v:Ghost.erased bool = frame p (fun _ ->  Atomic.witness_h_exists #u #_ #(fun b -> pts_to r full_perm (Ghost.hide b) `star` (if b then emp else p)) ()) in
  h_assert_atomic ((pts_to r full_perm v `star` (if Ghost.reveal v then emp else p)) `star` p);
  h_assoc_left _ _ _;
  let res = cas_frame r v locked available ((if Ghost.reveal v then emp else p) `star` p) in
  h_assert_atomic (pts_to r full_perm available `star` ((if res then emp else p) `star` p));
  h_commute _ _;
  frame (pts_to r full_perm available) (fun _ -> h_commute (if res then emp else p) p);
  h_commute _ _;
  h_assoc_right _ _ _;
  frame (if res then emp else p) (fun _ -> intro_lockinv_available p r);
  return_atomic #_ #_ #_ res
*)

(*
let release (#p:slprop) (l:lock p) : SteelT unit p (fun _ -> emp) =
  let r:ref bool = fst l in
  let i: inv (lockinv p r) = snd l in
  let b = with_invariant i (fun _ -> release_core r i) in
  h_affine emp (if b then emp else p)
*)