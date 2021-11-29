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

module Steel.ST.SpinLock
open Steel.ST.Util
open Steel.ST.Coercions
module L = Steel.SpinLock
/// A Steel library to share resources between threads through locks.

let lock_t
  : Type u#0
  = L.lock_t

/// A predicate relating a lock to a vprop.
let protects (l:lock_t) (p:vprop)
  : prop
  = L.protects l p

/// If we have vprop [p] in the context, we can create a new lock
/// associated to [p]. [p] is then removed from the context, and only accessible
/// through the newly created lock
let new_lock (p:vprop)
  : STT (lock p) p (fun _ -> emp)
  = coerce_steel (fun _ -> L.new_lock p)

let coerce_steel_alt (#a:Type)
                     (#pre:pre_t)
                     (#post:post_t a)
                     (#req:Type0)
                     (#ens:a -> Type0)
                     (f:unit -> Steel.Effect.SteelBase a false pre post
                              (fun _ -> req)
                              (fun _ x _ -> ens x))
   : ST a pre post req ens
   = coerce_steel f

let acquire_t (#p:vprop) (l:lock p)
  : Steel.Effect.SteelT unit emp (fun _ -> p)
  = L.acquire l

/// Acquires the lock, and adds the associated vprop [p] to the context.
/// This function loops until the lock becomes available
let acquire (#p:vprop) (l:lock p)
  : STT unit emp (fun _ -> p)
  = coerce_steel (fun _ -> acquire_t l)

let release_t (#p:vprop) (l:lock p)
  : Steel.Effect.SteelT unit p (fun _ -> emp)
  = L.release l

/// Releases a lock [l], as long as the caller previously restored the associated vprop [p]
let release (#p:vprop) (l:lock p)
  : STT unit p (fun _ -> emp)
  = coerce_steel (fun _ -> release_t l)
