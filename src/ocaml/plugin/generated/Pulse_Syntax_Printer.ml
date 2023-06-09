open Prims
let (name_to_string : FStar_Reflection_Types.name -> Prims.string) =
  fun f -> FStar_String.concat "." f
let (dbg_printing : Prims.bool) = true
let (constant_to_string : Pulse_Syntax.constant -> Prims.string) =
  fun uu___ ->
    match uu___ with
    | Pulse_Syntax.Unit -> "()"
    | Pulse_Syntax.Bool (true) -> "true"
    | Pulse_Syntax.Bool (false) -> "false"
    | Pulse_Syntax.Int i ->
        Prims.strcat "" (Prims.strcat (Prims.string_of_int i) "")
let rec (universe_to_string :
  Prims.nat -> Pulse_Syntax.universe -> Prims.string) =
  fun n ->
    fun u ->
      match u with
      | Pulse_Syntax.U_unknown -> "_"
      | Pulse_Syntax.U_zero ->
          Prims.strcat "" (Prims.strcat (Prims.string_of_int n) "")
      | Pulse_Syntax.U_succ u1 -> universe_to_string (n + Prims.int_one) u1
      | Pulse_Syntax.U_var x ->
          if n = Prims.int_zero
          then x
          else
            Prims.strcat (Prims.strcat "(" (Prims.strcat x " + "))
              (Prims.strcat (Prims.string_of_int n) ")")
      | Pulse_Syntax.U_max (u0, u1) ->
          let r =
            Prims.strcat
              (Prims.strcat "(max "
                 (Prims.strcat (universe_to_string Prims.int_zero u0) " "))
              (Prims.strcat (universe_to_string Prims.int_zero u1) ")") in
          if n = Prims.int_zero
          then r
          else
            Prims.strcat (Prims.strcat "" (Prims.strcat r " + "))
              (Prims.strcat (Prims.string_of_int n) "")
let (univ_to_string : Pulse_Syntax.universe -> Prims.string) =
  fun u ->
    Prims.strcat "u#" (Prims.strcat (universe_to_string Prims.int_zero u) "")
let (qual_to_string :
  Pulse_Syntax.qualifier FStar_Pervasives_Native.option -> Prims.string) =
  fun uu___ ->
    match uu___ with
    | FStar_Pervasives_Native.None -> ""
    | FStar_Pervasives_Native.Some (Pulse_Syntax.Implicit) -> "#"
let rec (term_to_string :
  Pulse_Syntax.term -> (Prims.string, unit) FStar_Tactics_Effect.tac_repr) =
  fun uu___ ->
    (fun t ->
       match t with
       | Pulse_Syntax.Tm_BVar x ->
           Obj.magic
             (Obj.repr
                (if dbg_printing
                 then
                   FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (38)) (Prims.of_int (11))
                        (Prims.of_int (38)) (Prims.of_int (60)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (38)) (Prims.of_int (11))
                        (Prims.of_int (38)) (Prims.of_int (60)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (38)) (Prims.of_int (27))
                              (Prims.of_int (38)) (Prims.of_int (49)))
                           (FStar_Range.mk_range "FStar.Printf.fst"
                              (Prims.of_int (121)) (Prims.of_int (8))
                              (Prims.of_int (123)) (Prims.of_int (44)))
                           (Obj.magic
                              (FStar_Tactics_Builtins.unseal
                                 x.Pulse_Syntax.bv_ppname))
                           (fun uu___ ->
                              FStar_Tactics_Effect.lift_div_tac
                                (fun uu___1 ->
                                   fun x1 ->
                                     Prims.strcat
                                       (Prims.strcat ""
                                          (Prims.strcat uu___ "@"))
                                       (Prims.strcat (Prims.string_of_int x1)
                                          "")))))
                     (fun uu___ ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___1 -> uu___ x.Pulse_Syntax.bv_index))
                 else FStar_Tactics_Builtins.unseal x.Pulse_Syntax.bv_ppname))
       | Pulse_Syntax.Tm_Var x ->
           Obj.magic
             (Obj.repr
                (if dbg_printing
                 then
                   FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (42)) (Prims.of_int (11))
                        (Prims.of_int (42)) (Prims.of_int (60)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (42)) (Prims.of_int (11))
                        (Prims.of_int (42)) (Prims.of_int (60)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (42)) (Prims.of_int (27))
                              (Prims.of_int (42)) (Prims.of_int (49)))
                           (FStar_Range.mk_range "FStar.Printf.fst"
                              (Prims.of_int (121)) (Prims.of_int (8))
                              (Prims.of_int (123)) (Prims.of_int (44)))
                           (Obj.magic
                              (FStar_Tactics_Builtins.unseal
                                 x.Pulse_Syntax.nm_ppname))
                           (fun uu___ ->
                              FStar_Tactics_Effect.lift_div_tac
                                (fun uu___1 ->
                                   fun x1 ->
                                     Prims.strcat
                                       (Prims.strcat ""
                                          (Prims.strcat uu___ "#"))
                                       (Prims.strcat (Prims.string_of_int x1)
                                          "")))))
                     (fun uu___ ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___1 -> uu___ x.Pulse_Syntax.nm_index))
                 else FStar_Tactics_Builtins.unseal x.Pulse_Syntax.nm_ppname))
       | Pulse_Syntax.Tm_FVar f ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.lift_div_tac
                   (fun uu___ -> name_to_string f.Pulse_Syntax.fv_name)))
       | Pulse_Syntax.Tm_UInst (f, us) ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.lift_div_tac
                   (fun uu___ ->
                      Prims.strcat
                        (Prims.strcat ""
                           (Prims.strcat
                              (name_to_string f.Pulse_Syntax.fv_name) " "))
                        (Prims.strcat
                           (FStar_String.concat " "
                              (FStar_List_Tot_Base.map univ_to_string us)) ""))))
       | Pulse_Syntax.Tm_Constant c ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.lift_div_tac
                   (fun uu___ -> constant_to_string c)))
       | Pulse_Syntax.Tm_Refine (b, phi) ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.tac_bind
                   (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                      (Prims.of_int (51)) (Prims.of_int (14))
                      (Prims.of_int (51)) (Prims.of_int (34)))
                   (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                      (Prims.of_int (48)) (Prims.of_int (6))
                      (Prims.of_int (51)) (Prims.of_int (34)))
                   (Obj.magic (term_to_string phi))
                   (fun uu___ ->
                      (fun uu___ ->
                         Obj.magic
                           (FStar_Tactics_Effect.tac_bind
                              (FStar_Range.mk_range
                                 "Pulse.Syntax.Printer.fst"
                                 (Prims.of_int (48)) (Prims.of_int (6))
                                 (Prims.of_int (51)) (Prims.of_int (34)))
                              (FStar_Range.mk_range
                                 "Pulse.Syntax.Printer.fst"
                                 (Prims.of_int (48)) (Prims.of_int (6))
                                 (Prims.of_int (51)) (Prims.of_int (34)))
                              (Obj.magic
                                 (FStar_Tactics_Effect.tac_bind
                                    (FStar_Range.mk_range
                                       "Pulse.Syntax.Printer.fst"
                                       (Prims.of_int (50))
                                       (Prims.of_int (14))
                                       (Prims.of_int (50))
                                       (Prims.of_int (42)))
                                    (FStar_Range.mk_range
                                       "Pulse.Syntax.Printer.fst"
                                       (Prims.of_int (48)) (Prims.of_int (6))
                                       (Prims.of_int (51))
                                       (Prims.of_int (34)))
                                    (Obj.magic
                                       (term_to_string
                                          b.Pulse_Syntax.binder_ty))
                                    (fun uu___1 ->
                                       (fun uu___1 ->
                                          Obj.magic
                                            (FStar_Tactics_Effect.tac_bind
                                               (FStar_Range.mk_range
                                                  "Pulse.Syntax.Printer.fst"
                                                  (Prims.of_int (48))
                                                  (Prims.of_int (6))
                                                  (Prims.of_int (51))
                                                  (Prims.of_int (34)))
                                               (FStar_Range.mk_range
                                                  "Pulse.Syntax.Printer.fst"
                                                  (Prims.of_int (48))
                                                  (Prims.of_int (6))
                                                  (Prims.of_int (51))
                                                  (Prims.of_int (34)))
                                               (Obj.magic
                                                  (FStar_Tactics_Effect.tac_bind
                                                     (FStar_Range.mk_range
                                                        "Pulse.Syntax.Printer.fst"
                                                        (Prims.of_int (49))
                                                        (Prims.of_int (14))
                                                        (Prims.of_int (49))
                                                        (Prims.of_int (40)))
                                                     (FStar_Range.mk_range
                                                        "FStar.Printf.fst"
                                                        (Prims.of_int (121))
                                                        (Prims.of_int (8))
                                                        (Prims.of_int (123))
                                                        (Prims.of_int (44)))
                                                     (Obj.magic
                                                        (FStar_Tactics_Builtins.unseal
                                                           b.Pulse_Syntax.binder_ppname))
                                                     (fun uu___2 ->
                                                        FStar_Tactics_Effect.lift_div_tac
                                                          (fun uu___3 ->
                                                             fun x ->
                                                               fun x1 ->
                                                                 Prims.strcat
                                                                   (Prims.strcat
                                                                    (Prims.strcat
                                                                    ""
                                                                    (Prims.strcat
                                                                    uu___2
                                                                    ":"))
                                                                    (Prims.strcat
                                                                    x "{"))
                                                                   (Prims.strcat
                                                                    x1 "}")))))
                                               (fun uu___2 ->
                                                  FStar_Tactics_Effect.lift_div_tac
                                                    (fun uu___3 ->
                                                       uu___2 uu___1))))
                                         uu___1)))
                              (fun uu___1 ->
                                 FStar_Tactics_Effect.lift_div_tac
                                   (fun uu___2 -> uu___1 uu___)))) uu___)))
       | Pulse_Syntax.Tm_PureApp (head, q, arg) ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.tac_bind
                   (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                      (Prims.of_int (57)) (Prims.of_int (8))
                      (Prims.of_int (57)) (Prims.of_int (28)))
                   (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                      (Prims.of_int (54)) (Prims.of_int (6))
                      (Prims.of_int (57)) (Prims.of_int (28)))
                   (Obj.magic (term_to_string arg))
                   (fun uu___ ->
                      (fun uu___ ->
                         Obj.magic
                           (FStar_Tactics_Effect.tac_bind
                              (FStar_Range.mk_range
                                 "Pulse.Syntax.Printer.fst"
                                 (Prims.of_int (54)) (Prims.of_int (6))
                                 (Prims.of_int (57)) (Prims.of_int (28)))
                              (FStar_Range.mk_range
                                 "Pulse.Syntax.Printer.fst"
                                 (Prims.of_int (54)) (Prims.of_int (6))
                                 (Prims.of_int (57)) (Prims.of_int (28)))
                              (Obj.magic
                                 (FStar_Tactics_Effect.tac_bind
                                    (FStar_Range.mk_range
                                       "Pulse.Syntax.Printer.fst"
                                       (Prims.of_int (54)) (Prims.of_int (6))
                                       (Prims.of_int (57))
                                       (Prims.of_int (28)))
                                    (FStar_Range.mk_range
                                       "Pulse.Syntax.Printer.fst"
                                       (Prims.of_int (54)) (Prims.of_int (6))
                                       (Prims.of_int (57))
                                       (Prims.of_int (28)))
                                    (Obj.magic
                                       (FStar_Tactics_Effect.tac_bind
                                          (FStar_Range.mk_range
                                             "Pulse.Syntax.Printer.fst"
                                             (Prims.of_int (55))
                                             (Prims.of_int (8))
                                             (Prims.of_int (55))
                                             (Prims.of_int (29)))
                                          (FStar_Range.mk_range
                                             "FStar.Printf.fst"
                                             (Prims.of_int (121))
                                             (Prims.of_int (8))
                                             (Prims.of_int (123))
                                             (Prims.of_int (44)))
                                          (Obj.magic (term_to_string head))
                                          (fun uu___1 ->
                                             FStar_Tactics_Effect.lift_div_tac
                                               (fun uu___2 ->
                                                  fun x ->
                                                    fun x1 ->
                                                      Prims.strcat
                                                        (Prims.strcat
                                                           (Prims.strcat "("
                                                              (Prims.strcat
                                                                 uu___1 " "))
                                                           (Prims.strcat x ""))
                                                        (Prims.strcat x1 ")")))))
                                    (fun uu___1 ->
                                       FStar_Tactics_Effect.lift_div_tac
                                         (fun uu___2 ->
                                            uu___1 (qual_to_string q)))))
                              (fun uu___1 ->
                                 FStar_Tactics_Effect.lift_div_tac
                                   (fun uu___2 -> uu___1 uu___)))) uu___)))
       | Pulse_Syntax.Tm_Let (t1, e1, e2) ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.tac_bind
                   (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                      (Prims.of_int (63)) (Prims.of_int (8))
                      (Prims.of_int (63)) (Prims.of_int (27)))
                   (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                      (Prims.of_int (60)) (Prims.of_int (6))
                      (Prims.of_int (63)) (Prims.of_int (27)))
                   (Obj.magic (term_to_string e2))
                   (fun uu___ ->
                      (fun uu___ ->
                         Obj.magic
                           (FStar_Tactics_Effect.tac_bind
                              (FStar_Range.mk_range
                                 "Pulse.Syntax.Printer.fst"
                                 (Prims.of_int (60)) (Prims.of_int (6))
                                 (Prims.of_int (63)) (Prims.of_int (27)))
                              (FStar_Range.mk_range
                                 "Pulse.Syntax.Printer.fst"
                                 (Prims.of_int (60)) (Prims.of_int (6))
                                 (Prims.of_int (63)) (Prims.of_int (27)))
                              (Obj.magic
                                 (FStar_Tactics_Effect.tac_bind
                                    (FStar_Range.mk_range
                                       "Pulse.Syntax.Printer.fst"
                                       (Prims.of_int (62)) (Prims.of_int (8))
                                       (Prims.of_int (62))
                                       (Prims.of_int (27)))
                                    (FStar_Range.mk_range
                                       "Pulse.Syntax.Printer.fst"
                                       (Prims.of_int (60)) (Prims.of_int (6))
                                       (Prims.of_int (63))
                                       (Prims.of_int (27)))
                                    (Obj.magic (term_to_string e1))
                                    (fun uu___1 ->
                                       (fun uu___1 ->
                                          Obj.magic
                                            (FStar_Tactics_Effect.tac_bind
                                               (FStar_Range.mk_range
                                                  "Pulse.Syntax.Printer.fst"
                                                  (Prims.of_int (60))
                                                  (Prims.of_int (6))
                                                  (Prims.of_int (63))
                                                  (Prims.of_int (27)))
                                               (FStar_Range.mk_range
                                                  "Pulse.Syntax.Printer.fst"
                                                  (Prims.of_int (60))
                                                  (Prims.of_int (6))
                                                  (Prims.of_int (63))
                                                  (Prims.of_int (27)))
                                               (Obj.magic
                                                  (FStar_Tactics_Effect.tac_bind
                                                     (FStar_Range.mk_range
                                                        "Pulse.Syntax.Printer.fst"
                                                        (Prims.of_int (61))
                                                        (Prims.of_int (8))
                                                        (Prims.of_int (61))
                                                        (Prims.of_int (26)))
                                                     (FStar_Range.mk_range
                                                        "FStar.Printf.fst"
                                                        (Prims.of_int (121))
                                                        (Prims.of_int (8))
                                                        (Prims.of_int (123))
                                                        (Prims.of_int (44)))
                                                     (Obj.magic
                                                        (term_to_string t1))
                                                     (fun uu___2 ->
                                                        FStar_Tactics_Effect.lift_div_tac
                                                          (fun uu___3 ->
                                                             fun x ->
                                                               fun x1 ->
                                                                 Prims.strcat
                                                                   (Prims.strcat
                                                                    (Prims.strcat
                                                                    "let _ : "
                                                                    (Prims.strcat
                                                                    uu___2
                                                                    " = "))
                                                                    (Prims.strcat
                                                                    x " in "))
                                                                   (Prims.strcat
                                                                    x1 "")))))
                                               (fun uu___2 ->
                                                  FStar_Tactics_Effect.lift_div_tac
                                                    (fun uu___3 ->
                                                       uu___2 uu___1))))
                                         uu___1)))
                              (fun uu___1 ->
                                 FStar_Tactics_Effect.lift_div_tac
                                   (fun uu___2 -> uu___1 uu___)))) uu___)))
       | Pulse_Syntax.Tm_Emp ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.lift_div_tac (fun uu___ -> "emp")))
       | Pulse_Syntax.Tm_Pure p ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.tac_bind
                   (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                      (Prims.of_int (66)) (Prims.of_int (37))
                      (Prims.of_int (66)) (Prims.of_int (55)))
                   (FStar_Range.mk_range "prims.fst" (Prims.of_int (590))
                      (Prims.of_int (19)) (Prims.of_int (590))
                      (Prims.of_int (31))) (Obj.magic (term_to_string p))
                   (fun uu___ ->
                      FStar_Tactics_Effect.lift_div_tac
                        (fun uu___1 ->
                           Prims.strcat "pure " (Prims.strcat uu___ "")))))
       | Pulse_Syntax.Tm_Star (p1, p2) ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.tac_bind
                   (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                      (Prims.of_int (69)) (Prims.of_int (26))
                      (Prims.of_int (69)) (Prims.of_int (45)))
                   (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                      (Prims.of_int (68)) (Prims.of_int (6))
                      (Prims.of_int (69)) (Prims.of_int (45)))
                   (Obj.magic (term_to_string p2))
                   (fun uu___ ->
                      (fun uu___ ->
                         Obj.magic
                           (FStar_Tactics_Effect.tac_bind
                              (FStar_Range.mk_range
                                 "Pulse.Syntax.Printer.fst"
                                 (Prims.of_int (68)) (Prims.of_int (6))
                                 (Prims.of_int (69)) (Prims.of_int (45)))
                              (FStar_Range.mk_range
                                 "Pulse.Syntax.Printer.fst"
                                 (Prims.of_int (68)) (Prims.of_int (6))
                                 (Prims.of_int (69)) (Prims.of_int (45)))
                              (Obj.magic
                                 (FStar_Tactics_Effect.tac_bind
                                    (FStar_Range.mk_range
                                       "Pulse.Syntax.Printer.fst"
                                       (Prims.of_int (68))
                                       (Prims.of_int (26))
                                       (Prims.of_int (68))
                                       (Prims.of_int (45)))
                                    (FStar_Range.mk_range "FStar.Printf.fst"
                                       (Prims.of_int (121))
                                       (Prims.of_int (8))
                                       (Prims.of_int (123))
                                       (Prims.of_int (44)))
                                    (Obj.magic (term_to_string p1))
                                    (fun uu___1 ->
                                       FStar_Tactics_Effect.lift_div_tac
                                         (fun uu___2 ->
                                            fun x ->
                                              Prims.strcat
                                                (Prims.strcat "("
                                                   (Prims.strcat uu___1 " * "))
                                                (Prims.strcat x ")")))))
                              (fun uu___1 ->
                                 FStar_Tactics_Effect.lift_div_tac
                                   (fun uu___2 -> uu___1 uu___)))) uu___)))
       | Pulse_Syntax.Tm_ExistsSL (u, t1, body, uu___) ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.tac_bind
                   (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                      (Prims.of_int (75)) (Prims.of_int (14))
                      (Prims.of_int (75)) (Prims.of_int (35)))
                   (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                      (Prims.of_int (72)) (Prims.of_int (6))
                      (Prims.of_int (75)) (Prims.of_int (35)))
                   (Obj.magic (term_to_string body))
                   (fun uu___1 ->
                      (fun uu___1 ->
                         Obj.magic
                           (FStar_Tactics_Effect.tac_bind
                              (FStar_Range.mk_range
                                 "Pulse.Syntax.Printer.fst"
                                 (Prims.of_int (72)) (Prims.of_int (6))
                                 (Prims.of_int (75)) (Prims.of_int (35)))
                              (FStar_Range.mk_range
                                 "Pulse.Syntax.Printer.fst"
                                 (Prims.of_int (72)) (Prims.of_int (6))
                                 (Prims.of_int (75)) (Prims.of_int (35)))
                              (Obj.magic
                                 (FStar_Tactics_Effect.tac_bind
                                    (FStar_Range.mk_range
                                       "Pulse.Syntax.Printer.fst"
                                       (Prims.of_int (74))
                                       (Prims.of_int (14))
                                       (Prims.of_int (74))
                                       (Prims.of_int (32)))
                                    (FStar_Range.mk_range "FStar.Printf.fst"
                                       (Prims.of_int (121))
                                       (Prims.of_int (8))
                                       (Prims.of_int (123))
                                       (Prims.of_int (44)))
                                    (Obj.magic (term_to_string t1))
                                    (fun uu___2 ->
                                       FStar_Tactics_Effect.lift_div_tac
                                         (fun uu___3 ->
                                            fun x ->
                                              Prims.strcat
                                                (Prims.strcat
                                                   (Prims.strcat "(exists<"
                                                      (Prims.strcat
                                                         (universe_to_string
                                                            Prims.int_zero u)
                                                         "> (_:"))
                                                   (Prims.strcat uu___2 "). "))
                                                (Prims.strcat x ")")))))
                              (fun uu___2 ->
                                 FStar_Tactics_Effect.lift_div_tac
                                   (fun uu___3 -> uu___2 uu___1)))) uu___1)))
       | Pulse_Syntax.Tm_ForallSL (u, t1, body) ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.tac_bind
                   (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                      (Prims.of_int (81)) (Prims.of_int (14))
                      (Prims.of_int (81)) (Prims.of_int (35)))
                   (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                      (Prims.of_int (78)) (Prims.of_int (6))
                      (Prims.of_int (81)) (Prims.of_int (35)))
                   (Obj.magic (term_to_string body))
                   (fun uu___ ->
                      (fun uu___ ->
                         Obj.magic
                           (FStar_Tactics_Effect.tac_bind
                              (FStar_Range.mk_range
                                 "Pulse.Syntax.Printer.fst"
                                 (Prims.of_int (78)) (Prims.of_int (6))
                                 (Prims.of_int (81)) (Prims.of_int (35)))
                              (FStar_Range.mk_range
                                 "Pulse.Syntax.Printer.fst"
                                 (Prims.of_int (78)) (Prims.of_int (6))
                                 (Prims.of_int (81)) (Prims.of_int (35)))
                              (Obj.magic
                                 (FStar_Tactics_Effect.tac_bind
                                    (FStar_Range.mk_range
                                       "Pulse.Syntax.Printer.fst"
                                       (Prims.of_int (80))
                                       (Prims.of_int (14))
                                       (Prims.of_int (80))
                                       (Prims.of_int (32)))
                                    (FStar_Range.mk_range "FStar.Printf.fst"
                                       (Prims.of_int (121))
                                       (Prims.of_int (8))
                                       (Prims.of_int (123))
                                       (Prims.of_int (44)))
                                    (Obj.magic (term_to_string t1))
                                    (fun uu___1 ->
                                       FStar_Tactics_Effect.lift_div_tac
                                         (fun uu___2 ->
                                            fun x ->
                                              Prims.strcat
                                                (Prims.strcat
                                                   (Prims.strcat "(forall<"
                                                      (Prims.strcat
                                                         (universe_to_string
                                                            Prims.int_zero u)
                                                         "> (_:"))
                                                   (Prims.strcat uu___1 "). "))
                                                (Prims.strcat x ")")))))
                              (fun uu___1 ->
                                 FStar_Tactics_Effect.lift_div_tac
                                   (fun uu___2 -> uu___1 uu___)))) uu___)))
       | Pulse_Syntax.Tm_Arrow (b, q, c) ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.tac_bind
                   (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                      (Prims.of_int (87)) (Prims.of_int (8))
                      (Prims.of_int (87)) (Prims.of_int (26)))
                   (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                      (Prims.of_int (84)) (Prims.of_int (6))
                      (Prims.of_int (87)) (Prims.of_int (26)))
                   (Obj.magic (comp_to_string c))
                   (fun uu___ ->
                      (fun uu___ ->
                         Obj.magic
                           (FStar_Tactics_Effect.tac_bind
                              (FStar_Range.mk_range
                                 "Pulse.Syntax.Printer.fst"
                                 (Prims.of_int (84)) (Prims.of_int (6))
                                 (Prims.of_int (87)) (Prims.of_int (26)))
                              (FStar_Range.mk_range
                                 "Pulse.Syntax.Printer.fst"
                                 (Prims.of_int (84)) (Prims.of_int (6))
                                 (Prims.of_int (87)) (Prims.of_int (26)))
                              (Obj.magic
                                 (FStar_Tactics_Effect.tac_bind
                                    (FStar_Range.mk_range
                                       "Pulse.Syntax.Printer.fst"
                                       (Prims.of_int (86)) (Prims.of_int (8))
                                       (Prims.of_int (86))
                                       (Prims.of_int (28)))
                                    (FStar_Range.mk_range "FStar.Printf.fst"
                                       (Prims.of_int (121))
                                       (Prims.of_int (8))
                                       (Prims.of_int (123))
                                       (Prims.of_int (44)))
                                    (Obj.magic (binder_to_string b))
                                    (fun uu___1 ->
                                       FStar_Tactics_Effect.lift_div_tac
                                         (fun uu___2 ->
                                            fun x ->
                                              Prims.strcat
                                                (Prims.strcat
                                                   (Prims.strcat ""
                                                      (Prims.strcat
                                                         (qual_to_string q)
                                                         ""))
                                                   (Prims.strcat uu___1
                                                      " -> "))
                                                (Prims.strcat x "")))))
                              (fun uu___1 ->
                                 FStar_Tactics_Effect.lift_div_tac
                                   (fun uu___2 -> uu___1 uu___)))) uu___)))
       | Pulse_Syntax.Tm_Type uu___ ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.lift_div_tac (fun uu___1 -> "Type u#_")))
       | Pulse_Syntax.Tm_VProp ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.lift_div_tac (fun uu___ -> "vprop")))
       | Pulse_Syntax.Tm_Inames ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.lift_div_tac (fun uu___ -> "inames")))
       | Pulse_Syntax.Tm_EmpInames ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.lift_div_tac
                   (fun uu___ -> "emp_inames")))
       | Pulse_Syntax.Tm_UVar n ->
           Obj.magic
             (Obj.repr
                (FStar_Tactics_Effect.lift_div_tac
                   (fun uu___ ->
                      Prims.strcat "?u_"
                        (Prims.strcat (Prims.string_of_int n) ""))))
       | Pulse_Syntax.Tm_Unknown ->
           Obj.magic
             (Obj.repr (FStar_Tactics_Effect.lift_div_tac (fun uu___ -> "_")))
       | Pulse_Syntax.Tm_FStar t1 ->
           Obj.magic (Obj.repr (FStar_Tactics_Builtins.term_to_string t1)))
      uu___
and (binder_to_string :
  Pulse_Syntax.binder -> (Prims.string, unit) FStar_Tactics_Effect.tac_repr)
  =
  fun b ->
    FStar_Tactics_Effect.tac_bind
      (FStar_Range.mk_range "Pulse.Syntax.Printer.fst" (Prims.of_int (110))
         (Prims.of_int (12)) (Prims.of_int (110)) (Prims.of_int (40)))
      (FStar_Range.mk_range "Pulse.Syntax.Printer.fst" (Prims.of_int (108))
         (Prims.of_int (4)) (Prims.of_int (110)) (Prims.of_int (40)))
      (Obj.magic (term_to_string b.Pulse_Syntax.binder_ty))
      (fun uu___ ->
         (fun uu___ ->
            Obj.magic
              (FStar_Tactics_Effect.tac_bind
                 (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                    (Prims.of_int (108)) (Prims.of_int (4))
                    (Prims.of_int (110)) (Prims.of_int (40)))
                 (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                    (Prims.of_int (108)) (Prims.of_int (4))
                    (Prims.of_int (110)) (Prims.of_int (40)))
                 (Obj.magic
                    (FStar_Tactics_Effect.tac_bind
                       (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                          (Prims.of_int (109)) (Prims.of_int (12))
                          (Prims.of_int (109)) (Prims.of_int (38)))
                       (FStar_Range.mk_range "FStar.Printf.fst"
                          (Prims.of_int (121)) (Prims.of_int (8))
                          (Prims.of_int (123)) (Prims.of_int (44)))
                       (Obj.magic
                          (FStar_Tactics_Builtins.unseal
                             b.Pulse_Syntax.binder_ppname))
                       (fun uu___1 ->
                          FStar_Tactics_Effect.lift_div_tac
                            (fun uu___2 ->
                               fun x ->
                                 Prims.strcat
                                   (Prims.strcat "" (Prims.strcat uu___1 ":"))
                                   (Prims.strcat x "")))))
                 (fun uu___1 ->
                    FStar_Tactics_Effect.lift_div_tac
                      (fun uu___2 -> uu___1 uu___)))) uu___)
and (comp_to_string :
  Pulse_Syntax.comp -> (Prims.string, unit) FStar_Tactics_Effect.tac_repr) =
  fun c ->
    match c with
    | Pulse_Syntax.C_Tot t ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (116)) (Prims.of_int (23)) (Prims.of_int (116))
             (Prims.of_int (41)))
          (FStar_Range.mk_range "prims.fst" (Prims.of_int (590))
             (Prims.of_int (19)) (Prims.of_int (590)) (Prims.of_int (31)))
          (Obj.magic (term_to_string t))
          (fun uu___ ->
             FStar_Tactics_Effect.lift_div_tac
               (fun uu___1 -> Prims.strcat "Tot " (Prims.strcat uu___ "")))
    | Pulse_Syntax.C_ST s ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (122)) (Prims.of_int (14)) (Prims.of_int (122))
             (Prims.of_int (37)))
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (119)) (Prims.of_int (6)) (Prims.of_int (122))
             (Prims.of_int (37)))
          (Obj.magic (term_to_string s.Pulse_Syntax.post))
          (fun uu___ ->
             (fun uu___ ->
                Obj.magic
                  (FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (119)) (Prims.of_int (6))
                        (Prims.of_int (122)) (Prims.of_int (37)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (119)) (Prims.of_int (6))
                        (Prims.of_int (122)) (Prims.of_int (37)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (121)) (Prims.of_int (14))
                              (Prims.of_int (121)) (Prims.of_int (36)))
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (119)) (Prims.of_int (6))
                              (Prims.of_int (122)) (Prims.of_int (37)))
                           (Obj.magic (term_to_string s.Pulse_Syntax.pre))
                           (fun uu___1 ->
                              (fun uu___1 ->
                                 Obj.magic
                                   (FStar_Tactics_Effect.tac_bind
                                      (FStar_Range.mk_range
                                         "Pulse.Syntax.Printer.fst"
                                         (Prims.of_int (119))
                                         (Prims.of_int (6))
                                         (Prims.of_int (122))
                                         (Prims.of_int (37)))
                                      (FStar_Range.mk_range
                                         "Pulse.Syntax.Printer.fst"
                                         (Prims.of_int (119))
                                         (Prims.of_int (6))
                                         (Prims.of_int (122))
                                         (Prims.of_int (37)))
                                      (Obj.magic
                                         (FStar_Tactics_Effect.tac_bind
                                            (FStar_Range.mk_range
                                               "Pulse.Syntax.Printer.fst"
                                               (Prims.of_int (120))
                                               (Prims.of_int (14))
                                               (Prims.of_int (120))
                                               (Prims.of_int (36)))
                                            (FStar_Range.mk_range
                                               "FStar.Printf.fst"
                                               (Prims.of_int (121))
                                               (Prims.of_int (8))
                                               (Prims.of_int (123))
                                               (Prims.of_int (44)))
                                            (Obj.magic
                                               (term_to_string
                                                  s.Pulse_Syntax.res))
                                            (fun uu___2 ->
                                               FStar_Tactics_Effect.lift_div_tac
                                                 (fun uu___3 ->
                                                    fun x ->
                                                      fun x1 ->
                                                        Prims.strcat
                                                          (Prims.strcat
                                                             (Prims.strcat
                                                                "ST "
                                                                (Prims.strcat
                                                                   uu___2 " "))
                                                             (Prims.strcat x
                                                                " "))
                                                          (Prims.strcat x1 "")))))
                                      (fun uu___2 ->
                                         FStar_Tactics_Effect.lift_div_tac
                                           (fun uu___3 -> uu___2 uu___1))))
                                uu___1)))
                     (fun uu___1 ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___2 -> uu___1 uu___)))) uu___)
    | Pulse_Syntax.C_STAtomic (inames, s) ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (129)) (Prims.of_int (14)) (Prims.of_int (129))
             (Prims.of_int (37)))
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (125)) (Prims.of_int (6)) (Prims.of_int (129))
             (Prims.of_int (37)))
          (Obj.magic (term_to_string s.Pulse_Syntax.post))
          (fun uu___ ->
             (fun uu___ ->
                Obj.magic
                  (FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (125)) (Prims.of_int (6))
                        (Prims.of_int (129)) (Prims.of_int (37)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (125)) (Prims.of_int (6))
                        (Prims.of_int (129)) (Prims.of_int (37)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (128)) (Prims.of_int (14))
                              (Prims.of_int (128)) (Prims.of_int (36)))
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (125)) (Prims.of_int (6))
                              (Prims.of_int (129)) (Prims.of_int (37)))
                           (Obj.magic (term_to_string s.Pulse_Syntax.pre))
                           (fun uu___1 ->
                              (fun uu___1 ->
                                 Obj.magic
                                   (FStar_Tactics_Effect.tac_bind
                                      (FStar_Range.mk_range
                                         "Pulse.Syntax.Printer.fst"
                                         (Prims.of_int (125))
                                         (Prims.of_int (6))
                                         (Prims.of_int (129))
                                         (Prims.of_int (37)))
                                      (FStar_Range.mk_range
                                         "Pulse.Syntax.Printer.fst"
                                         (Prims.of_int (125))
                                         (Prims.of_int (6))
                                         (Prims.of_int (129))
                                         (Prims.of_int (37)))
                                      (Obj.magic
                                         (FStar_Tactics_Effect.tac_bind
                                            (FStar_Range.mk_range
                                               "Pulse.Syntax.Printer.fst"
                                               (Prims.of_int (127))
                                               (Prims.of_int (14))
                                               (Prims.of_int (127))
                                               (Prims.of_int (36)))
                                            (FStar_Range.mk_range
                                               "Pulse.Syntax.Printer.fst"
                                               (Prims.of_int (125))
                                               (Prims.of_int (6))
                                               (Prims.of_int (129))
                                               (Prims.of_int (37)))
                                            (Obj.magic
                                               (term_to_string
                                                  s.Pulse_Syntax.res))
                                            (fun uu___2 ->
                                               (fun uu___2 ->
                                                  Obj.magic
                                                    (FStar_Tactics_Effect.tac_bind
                                                       (FStar_Range.mk_range
                                                          "Pulse.Syntax.Printer.fst"
                                                          (Prims.of_int (125))
                                                          (Prims.of_int (6))
                                                          (Prims.of_int (129))
                                                          (Prims.of_int (37)))
                                                       (FStar_Range.mk_range
                                                          "Pulse.Syntax.Printer.fst"
                                                          (Prims.of_int (125))
                                                          (Prims.of_int (6))
                                                          (Prims.of_int (129))
                                                          (Prims.of_int (37)))
                                                       (Obj.magic
                                                          (FStar_Tactics_Effect.tac_bind
                                                             (FStar_Range.mk_range
                                                                "Pulse.Syntax.Printer.fst"
                                                                (Prims.of_int (126))
                                                                (Prims.of_int (14))
                                                                (Prims.of_int (126))
                                                                (Prims.of_int (37)))
                                                             (FStar_Range.mk_range
                                                                "FStar.Printf.fst"
                                                                (Prims.of_int (121))
                                                                (Prims.of_int (8))
                                                                (Prims.of_int (123))
                                                                (Prims.of_int (44)))
                                                             (Obj.magic
                                                                (term_to_string
                                                                   inames))
                                                             (fun uu___3 ->
                                                                FStar_Tactics_Effect.lift_div_tac
                                                                  (fun uu___4
                                                                    ->
                                                                    fun x ->
                                                                    fun x1 ->
                                                                    fun x2 ->
                                                                    Prims.strcat
                                                                    (Prims.strcat
                                                                    (Prims.strcat
                                                                    (Prims.strcat
                                                                    "STAtomic "
                                                                    (Prims.strcat
                                                                    uu___3
                                                                    " "))
                                                                    (Prims.strcat
                                                                    x " "))
                                                                    (Prims.strcat
                                                                    x1 " "))
                                                                    (Prims.strcat
                                                                    x2 "")))))
                                                       (fun uu___3 ->
                                                          FStar_Tactics_Effect.lift_div_tac
                                                            (fun uu___4 ->
                                                               uu___3 uu___2))))
                                                 uu___2)))
                                      (fun uu___2 ->
                                         FStar_Tactics_Effect.lift_div_tac
                                           (fun uu___3 -> uu___2 uu___1))))
                                uu___1)))
                     (fun uu___1 ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___2 -> uu___1 uu___)))) uu___)
    | Pulse_Syntax.C_STGhost (inames, s) ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (136)) (Prims.of_int (14)) (Prims.of_int (136))
             (Prims.of_int (37)))
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (132)) (Prims.of_int (6)) (Prims.of_int (136))
             (Prims.of_int (37)))
          (Obj.magic (term_to_string s.Pulse_Syntax.post))
          (fun uu___ ->
             (fun uu___ ->
                Obj.magic
                  (FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (132)) (Prims.of_int (6))
                        (Prims.of_int (136)) (Prims.of_int (37)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (132)) (Prims.of_int (6))
                        (Prims.of_int (136)) (Prims.of_int (37)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (135)) (Prims.of_int (14))
                              (Prims.of_int (135)) (Prims.of_int (36)))
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (132)) (Prims.of_int (6))
                              (Prims.of_int (136)) (Prims.of_int (37)))
                           (Obj.magic (term_to_string s.Pulse_Syntax.pre))
                           (fun uu___1 ->
                              (fun uu___1 ->
                                 Obj.magic
                                   (FStar_Tactics_Effect.tac_bind
                                      (FStar_Range.mk_range
                                         "Pulse.Syntax.Printer.fst"
                                         (Prims.of_int (132))
                                         (Prims.of_int (6))
                                         (Prims.of_int (136))
                                         (Prims.of_int (37)))
                                      (FStar_Range.mk_range
                                         "Pulse.Syntax.Printer.fst"
                                         (Prims.of_int (132))
                                         (Prims.of_int (6))
                                         (Prims.of_int (136))
                                         (Prims.of_int (37)))
                                      (Obj.magic
                                         (FStar_Tactics_Effect.tac_bind
                                            (FStar_Range.mk_range
                                               "Pulse.Syntax.Printer.fst"
                                               (Prims.of_int (134))
                                               (Prims.of_int (14))
                                               (Prims.of_int (134))
                                               (Prims.of_int (36)))
                                            (FStar_Range.mk_range
                                               "Pulse.Syntax.Printer.fst"
                                               (Prims.of_int (132))
                                               (Prims.of_int (6))
                                               (Prims.of_int (136))
                                               (Prims.of_int (37)))
                                            (Obj.magic
                                               (term_to_string
                                                  s.Pulse_Syntax.res))
                                            (fun uu___2 ->
                                               (fun uu___2 ->
                                                  Obj.magic
                                                    (FStar_Tactics_Effect.tac_bind
                                                       (FStar_Range.mk_range
                                                          "Pulse.Syntax.Printer.fst"
                                                          (Prims.of_int (132))
                                                          (Prims.of_int (6))
                                                          (Prims.of_int (136))
                                                          (Prims.of_int (37)))
                                                       (FStar_Range.mk_range
                                                          "Pulse.Syntax.Printer.fst"
                                                          (Prims.of_int (132))
                                                          (Prims.of_int (6))
                                                          (Prims.of_int (136))
                                                          (Prims.of_int (37)))
                                                       (Obj.magic
                                                          (FStar_Tactics_Effect.tac_bind
                                                             (FStar_Range.mk_range
                                                                "Pulse.Syntax.Printer.fst"
                                                                (Prims.of_int (133))
                                                                (Prims.of_int (14))
                                                                (Prims.of_int (133))
                                                                (Prims.of_int (37)))
                                                             (FStar_Range.mk_range
                                                                "FStar.Printf.fst"
                                                                (Prims.of_int (121))
                                                                (Prims.of_int (8))
                                                                (Prims.of_int (123))
                                                                (Prims.of_int (44)))
                                                             (Obj.magic
                                                                (term_to_string
                                                                   inames))
                                                             (fun uu___3 ->
                                                                FStar_Tactics_Effect.lift_div_tac
                                                                  (fun uu___4
                                                                    ->
                                                                    fun x ->
                                                                    fun x1 ->
                                                                    fun x2 ->
                                                                    Prims.strcat
                                                                    (Prims.strcat
                                                                    (Prims.strcat
                                                                    (Prims.strcat
                                                                    "STGhost "
                                                                    (Prims.strcat
                                                                    uu___3
                                                                    " "))
                                                                    (Prims.strcat
                                                                    x " "))
                                                                    (Prims.strcat
                                                                    x1 " "))
                                                                    (Prims.strcat
                                                                    x2 "")))))
                                                       (fun uu___3 ->
                                                          FStar_Tactics_Effect.lift_div_tac
                                                            (fun uu___4 ->
                                                               uu___3 uu___2))))
                                                 uu___2)))
                                      (fun uu___2 ->
                                         FStar_Tactics_Effect.lift_div_tac
                                           (fun uu___3 -> uu___2 uu___1))))
                                uu___1)))
                     (fun uu___1 ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___2 -> uu___1 uu___)))) uu___)
let (term_opt_to_string :
  Pulse_Syntax.term FStar_Pervasives_Native.option ->
    (Prims.string, unit) FStar_Tactics_Effect.tac_repr)
  =
  fun uu___ ->
    (fun t ->
       match t with
       | FStar_Pervasives_Native.None ->
           Obj.magic
             (Obj.repr (FStar_Tactics_Effect.lift_div_tac (fun uu___ -> "")))
       | FStar_Pervasives_Native.Some t1 ->
           Obj.magic (Obj.repr (term_to_string t1))) uu___
let (term_list_to_string :
  Prims.string ->
    Pulse_Syntax.term Prims.list ->
      (Prims.string, unit) FStar_Tactics_Effect.tac_repr)
  =
  fun sep ->
    fun t ->
      FStar_Tactics_Effect.tac_bind
        (FStar_Range.mk_range "Pulse.Syntax.Printer.fst" (Prims.of_int (146))
           (Prims.of_int (22)) (Prims.of_int (146)) (Prims.of_int (46)))
        (FStar_Range.mk_range "Pulse.Syntax.Printer.fst" (Prims.of_int (146))
           (Prims.of_int (4)) (Prims.of_int (146)) (Prims.of_int (46)))
        (Obj.magic (FStar_Tactics_Util.map term_to_string t))
        (fun uu___ ->
           FStar_Tactics_Effect.lift_div_tac
             (fun uu___1 -> FStar_String.concat sep uu___))
let rec (st_term_to_string :
  Pulse_Syntax.st_term -> (Prims.string, unit) FStar_Tactics_Effect.tac_repr)
  =
  fun t ->
    match t.Pulse_Syntax.term1 with
    | Pulse_Syntax.Tm_Return
        { Pulse_Syntax.ctag = ctag; Pulse_Syntax.insert_eq = insert_eq;
          Pulse_Syntax.term = term;_}
        ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (158)) (Prims.of_int (8)) (Prims.of_int (158))
             (Prims.of_int (29)))
          (FStar_Range.mk_range "prims.fst" (Prims.of_int (590))
             (Prims.of_int (19)) (Prims.of_int (590)) (Prims.of_int (31)))
          (Obj.magic (term_to_string term))
          (fun uu___ ->
             FStar_Tactics_Effect.lift_div_tac
               (fun uu___1 ->
                  Prims.strcat
                    (Prims.strcat
                       (Prims.strcat "return_"
                          (Prims.strcat
                             (match ctag with
                              | Pulse_Syntax.STT -> "stt"
                              | Pulse_Syntax.STT_Atomic -> "stt_atomic"
                              | Pulse_Syntax.STT_Ghost -> "stt_ghost") ""))
                       (Prims.strcat (if insert_eq then "" else "_noeq") " "))
                    (Prims.strcat uu___ "")))
    | Pulse_Syntax.Tm_STApp
        { Pulse_Syntax.head = head; Pulse_Syntax.arg_qual = arg_qual;
          Pulse_Syntax.arg = arg;_}
        ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (165)) (Prims.of_int (8)) (Prims.of_int (165))
             (Prims.of_int (28)))
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (161)) (Prims.of_int (6)) (Prims.of_int (165))
             (Prims.of_int (28))) (Obj.magic (term_to_string arg))
          (fun uu___ ->
             (fun uu___ ->
                Obj.magic
                  (FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (161)) (Prims.of_int (6))
                        (Prims.of_int (165)) (Prims.of_int (28)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (161)) (Prims.of_int (6))
                        (Prims.of_int (165)) (Prims.of_int (28)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (161)) (Prims.of_int (6))
                              (Prims.of_int (165)) (Prims.of_int (28)))
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (161)) (Prims.of_int (6))
                              (Prims.of_int (165)) (Prims.of_int (28)))
                           (Obj.magic
                              (FStar_Tactics_Effect.tac_bind
                                 (FStar_Range.mk_range
                                    "Pulse.Syntax.Printer.fst"
                                    (Prims.of_int (163)) (Prims.of_int (8))
                                    (Prims.of_int (163)) (Prims.of_int (29)))
                                 (FStar_Range.mk_range "FStar.Printf.fst"
                                    (Prims.of_int (121)) (Prims.of_int (8))
                                    (Prims.of_int (123)) (Prims.of_int (44)))
                                 (Obj.magic (term_to_string head))
                                 (fun uu___1 ->
                                    FStar_Tactics_Effect.lift_div_tac
                                      (fun uu___2 ->
                                         fun x ->
                                           fun x1 ->
                                             Prims.strcat
                                               (Prims.strcat
                                                  (Prims.strcat
                                                     (Prims.strcat "("
                                                        (Prims.strcat
                                                           (if dbg_printing
                                                            then "<stapp>"
                                                            else "") ""))
                                                     (Prims.strcat uu___1 " "))
                                                  (Prims.strcat x ""))
                                               (Prims.strcat x1 ")")))))
                           (fun uu___1 ->
                              FStar_Tactics_Effect.lift_div_tac
                                (fun uu___2 ->
                                   uu___1 (qual_to_string arg_qual)))))
                     (fun uu___1 ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___2 -> uu___1 uu___)))) uu___)
    | Pulse_Syntax.Tm_Bind
        { Pulse_Syntax.binder = binder; Pulse_Syntax.head1 = head;
          Pulse_Syntax.body1 = body;_}
        ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (171)) (Prims.of_int (8)) (Prims.of_int (171))
             (Prims.of_int (32)))
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (168)) (Prims.of_int (6)) (Prims.of_int (171))
             (Prims.of_int (32))) (Obj.magic (st_term_to_string body))
          (fun uu___ ->
             (fun uu___ ->
                Obj.magic
                  (FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (168)) (Prims.of_int (6))
                        (Prims.of_int (171)) (Prims.of_int (32)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (168)) (Prims.of_int (6))
                        (Prims.of_int (171)) (Prims.of_int (32)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (170)) (Prims.of_int (8))
                              (Prims.of_int (170)) (Prims.of_int (32)))
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (168)) (Prims.of_int (6))
                              (Prims.of_int (171)) (Prims.of_int (32)))
                           (Obj.magic (st_term_to_string head))
                           (fun uu___1 ->
                              (fun uu___1 ->
                                 Obj.magic
                                   (FStar_Tactics_Effect.tac_bind
                                      (FStar_Range.mk_range
                                         "Pulse.Syntax.Printer.fst"
                                         (Prims.of_int (168))
                                         (Prims.of_int (6))
                                         (Prims.of_int (171))
                                         (Prims.of_int (32)))
                                      (FStar_Range.mk_range
                                         "Pulse.Syntax.Printer.fst"
                                         (Prims.of_int (168))
                                         (Prims.of_int (6))
                                         (Prims.of_int (171))
                                         (Prims.of_int (32)))
                                      (Obj.magic
                                         (FStar_Tactics_Effect.tac_bind
                                            (FStar_Range.mk_range
                                               "Pulse.Syntax.Printer.fst"
                                               (Prims.of_int (169))
                                               (Prims.of_int (8))
                                               (Prims.of_int (169))
                                               (Prims.of_int (33)))
                                            (FStar_Range.mk_range
                                               "FStar.Printf.fst"
                                               (Prims.of_int (121))
                                               (Prims.of_int (8))
                                               (Prims.of_int (123))
                                               (Prims.of_int (44)))
                                            (Obj.magic
                                               (binder_to_string binder))
                                            (fun uu___2 ->
                                               FStar_Tactics_Effect.lift_div_tac
                                                 (fun uu___3 ->
                                                    fun x ->
                                                      fun x1 ->
                                                        Prims.strcat
                                                          (Prims.strcat
                                                             (Prims.strcat
                                                                "bind "
                                                                (Prims.strcat
                                                                   uu___2
                                                                   " = "))
                                                             (Prims.strcat x
                                                                " in "))
                                                          (Prims.strcat x1 "")))))
                                      (fun uu___2 ->
                                         FStar_Tactics_Effect.lift_div_tac
                                           (fun uu___3 -> uu___2 uu___1))))
                                uu___1)))
                     (fun uu___1 ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___2 -> uu___1 uu___)))) uu___)
    | Pulse_Syntax.Tm_TotBind
        { Pulse_Syntax.head2 = head; Pulse_Syntax.body2 = body;_} ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (176)) (Prims.of_int (8)) (Prims.of_int (176))
             (Prims.of_int (32)))
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (174)) (Prims.of_int (6)) (Prims.of_int (176))
             (Prims.of_int (32))) (Obj.magic (st_term_to_string body))
          (fun uu___ ->
             (fun uu___ ->
                Obj.magic
                  (FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (174)) (Prims.of_int (6))
                        (Prims.of_int (176)) (Prims.of_int (32)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (174)) (Prims.of_int (6))
                        (Prims.of_int (176)) (Prims.of_int (32)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (175)) (Prims.of_int (8))
                              (Prims.of_int (175)) (Prims.of_int (29)))
                           (FStar_Range.mk_range "FStar.Printf.fst"
                              (Prims.of_int (121)) (Prims.of_int (8))
                              (Prims.of_int (123)) (Prims.of_int (44)))
                           (Obj.magic (term_to_string head))
                           (fun uu___1 ->
                              FStar_Tactics_Effect.lift_div_tac
                                (fun uu___2 ->
                                   fun x ->
                                     Prims.strcat
                                       (Prims.strcat "totbind _ = "
                                          (Prims.strcat uu___1 " in "))
                                       (Prims.strcat x "")))))
                     (fun uu___1 ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___2 -> uu___1 uu___)))) uu___)
    | Pulse_Syntax.Tm_Abs
        { Pulse_Syntax.b = b; Pulse_Syntax.q = q; Pulse_Syntax.pre1 = pre;
          Pulse_Syntax.body = body; Pulse_Syntax.post1 = post;_}
        ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (184)) (Prims.of_int (14)) (Prims.of_int (184))
             (Prims.of_int (38)))
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (179)) (Prims.of_int (6)) (Prims.of_int (184))
             (Prims.of_int (38))) (Obj.magic (st_term_to_string body))
          (fun uu___ ->
             (fun uu___ ->
                Obj.magic
                  (FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (179)) (Prims.of_int (6))
                        (Prims.of_int (184)) (Prims.of_int (38)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (179)) (Prims.of_int (6))
                        (Prims.of_int (184)) (Prims.of_int (38)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (183)) (Prims.of_int (14))
                              (Prims.of_int (183)) (Prims.of_int (39)))
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (179)) (Prims.of_int (6))
                              (Prims.of_int (184)) (Prims.of_int (38)))
                           (Obj.magic (term_opt_to_string post))
                           (fun uu___1 ->
                              (fun uu___1 ->
                                 Obj.magic
                                   (FStar_Tactics_Effect.tac_bind
                                      (FStar_Range.mk_range
                                         "Pulse.Syntax.Printer.fst"
                                         (Prims.of_int (179))
                                         (Prims.of_int (6))
                                         (Prims.of_int (184))
                                         (Prims.of_int (38)))
                                      (FStar_Range.mk_range
                                         "Pulse.Syntax.Printer.fst"
                                         (Prims.of_int (179))
                                         (Prims.of_int (6))
                                         (Prims.of_int (184))
                                         (Prims.of_int (38)))
                                      (Obj.magic
                                         (FStar_Tactics_Effect.tac_bind
                                            (FStar_Range.mk_range
                                               "Pulse.Syntax.Printer.fst"
                                               (Prims.of_int (182))
                                               (Prims.of_int (14))
                                               (Prims.of_int (182))
                                               (Prims.of_int (38)))
                                            (FStar_Range.mk_range
                                               "Pulse.Syntax.Printer.fst"
                                               (Prims.of_int (179))
                                               (Prims.of_int (6))
                                               (Prims.of_int (184))
                                               (Prims.of_int (38)))
                                            (Obj.magic
                                               (term_opt_to_string pre))
                                            (fun uu___2 ->
                                               (fun uu___2 ->
                                                  Obj.magic
                                                    (FStar_Tactics_Effect.tac_bind
                                                       (FStar_Range.mk_range
                                                          "Pulse.Syntax.Printer.fst"
                                                          (Prims.of_int (179))
                                                          (Prims.of_int (6))
                                                          (Prims.of_int (184))
                                                          (Prims.of_int (38)))
                                                       (FStar_Range.mk_range
                                                          "Pulse.Syntax.Printer.fst"
                                                          (Prims.of_int (179))
                                                          (Prims.of_int (6))
                                                          (Prims.of_int (184))
                                                          (Prims.of_int (38)))
                                                       (Obj.magic
                                                          (FStar_Tactics_Effect.tac_bind
                                                             (FStar_Range.mk_range
                                                                "Pulse.Syntax.Printer.fst"
                                                                (Prims.of_int (181))
                                                                (Prims.of_int (14))
                                                                (Prims.of_int (181))
                                                                (Prims.of_int (34)))
                                                             (FStar_Range.mk_range
                                                                "FStar.Printf.fst"
                                                                (Prims.of_int (121))
                                                                (Prims.of_int (8))
                                                                (Prims.of_int (123))
                                                                (Prims.of_int (44)))
                                                             (Obj.magic
                                                                (binder_to_string
                                                                   b))
                                                             (fun uu___3 ->
                                                                FStar_Tactics_Effect.lift_div_tac
                                                                  (fun uu___4
                                                                    ->
                                                                    fun x ->
                                                                    fun x1 ->
                                                                    fun x2 ->
                                                                    Prims.strcat
                                                                    (Prims.strcat
                                                                    (Prims.strcat
                                                                    (Prims.strcat
                                                                    (Prims.strcat
                                                                    "(fun ("
                                                                    (Prims.strcat
                                                                    (qual_to_string
                                                                    q) ""))
                                                                    (Prims.strcat
                                                                    uu___3
                                                                    ") {"))
                                                                    (Prims.strcat
                                                                    x "} {_."))
                                                                    (Prims.strcat
                                                                    x1
                                                                    "} -> "))
                                                                    (Prims.strcat
                                                                    x2 ")")))))
                                                       (fun uu___3 ->
                                                          FStar_Tactics_Effect.lift_div_tac
                                                            (fun uu___4 ->
                                                               uu___3 uu___2))))
                                                 uu___2)))
                                      (fun uu___2 ->
                                         FStar_Tactics_Effect.lift_div_tac
                                           (fun uu___3 -> uu___2 uu___1))))
                                uu___1)))
                     (fun uu___1 ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___2 -> uu___1 uu___)))) uu___)
    | Pulse_Syntax.Tm_If
        { Pulse_Syntax.b1 = b; Pulse_Syntax.then_ = then_;
          Pulse_Syntax.else_ = else_; Pulse_Syntax.post2 = uu___;_}
        ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (190)) (Prims.of_int (8)) (Prims.of_int (190))
             (Prims.of_int (33)))
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (187)) (Prims.of_int (6)) (Prims.of_int (190))
             (Prims.of_int (33))) (Obj.magic (st_term_to_string else_))
          (fun uu___1 ->
             (fun uu___1 ->
                Obj.magic
                  (FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (187)) (Prims.of_int (6))
                        (Prims.of_int (190)) (Prims.of_int (33)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (187)) (Prims.of_int (6))
                        (Prims.of_int (190)) (Prims.of_int (33)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (189)) (Prims.of_int (8))
                              (Prims.of_int (189)) (Prims.of_int (33)))
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (187)) (Prims.of_int (6))
                              (Prims.of_int (190)) (Prims.of_int (33)))
                           (Obj.magic (st_term_to_string then_))
                           (fun uu___2 ->
                              (fun uu___2 ->
                                 Obj.magic
                                   (FStar_Tactics_Effect.tac_bind
                                      (FStar_Range.mk_range
                                         "Pulse.Syntax.Printer.fst"
                                         (Prims.of_int (187))
                                         (Prims.of_int (6))
                                         (Prims.of_int (190))
                                         (Prims.of_int (33)))
                                      (FStar_Range.mk_range
                                         "Pulse.Syntax.Printer.fst"
                                         (Prims.of_int (187))
                                         (Prims.of_int (6))
                                         (Prims.of_int (190))
                                         (Prims.of_int (33)))
                                      (Obj.magic
                                         (FStar_Tactics_Effect.tac_bind
                                            (FStar_Range.mk_range
                                               "Pulse.Syntax.Printer.fst"
                                               (Prims.of_int (188))
                                               (Prims.of_int (8))
                                               (Prims.of_int (188))
                                               (Prims.of_int (26)))
                                            (FStar_Range.mk_range
                                               "FStar.Printf.fst"
                                               (Prims.of_int (121))
                                               (Prims.of_int (8))
                                               (Prims.of_int (123))
                                               (Prims.of_int (44)))
                                            (Obj.magic (term_to_string b))
                                            (fun uu___3 ->
                                               FStar_Tactics_Effect.lift_div_tac
                                                 (fun uu___4 ->
                                                    fun x ->
                                                      fun x1 ->
                                                        Prims.strcat
                                                          (Prims.strcat
                                                             (Prims.strcat
                                                                "(if "
                                                                (Prims.strcat
                                                                   uu___3
                                                                   " then "))
                                                             (Prims.strcat x
                                                                " else "))
                                                          (Prims.strcat x1
                                                             ")")))))
                                      (fun uu___3 ->
                                         FStar_Tactics_Effect.lift_div_tac
                                           (fun uu___4 -> uu___3 uu___2))))
                                uu___2)))
                     (fun uu___2 ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___3 -> uu___2 uu___1)))) uu___1)
    | Pulse_Syntax.Tm_ElimExists { Pulse_Syntax.p = p;_} ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (194)) (Prims.of_int (8)) (Prims.of_int (194))
             (Prims.of_int (26)))
          (FStar_Range.mk_range "prims.fst" (Prims.of_int (590))
             (Prims.of_int (19)) (Prims.of_int (590)) (Prims.of_int (31)))
          (Obj.magic (term_to_string p))
          (fun uu___ ->
             FStar_Tactics_Effect.lift_div_tac
               (fun uu___1 ->
                  Prims.strcat "elim_exists " (Prims.strcat uu___ "")))
    | Pulse_Syntax.Tm_IntroExists
        { Pulse_Syntax.erased = false; Pulse_Syntax.p1 = p;
          Pulse_Syntax.witnesses = witnesses;_}
        ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (199)) (Prims.of_int (8)) (Prims.of_int (199))
             (Prims.of_int (43)))
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (197)) (Prims.of_int (6)) (Prims.of_int (199))
             (Prims.of_int (43)))
          (Obj.magic (term_list_to_string " " witnesses))
          (fun uu___ ->
             (fun uu___ ->
                Obj.magic
                  (FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (197)) (Prims.of_int (6))
                        (Prims.of_int (199)) (Prims.of_int (43)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (197)) (Prims.of_int (6))
                        (Prims.of_int (199)) (Prims.of_int (43)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (198)) (Prims.of_int (8))
                              (Prims.of_int (198)) (Prims.of_int (26)))
                           (FStar_Range.mk_range "FStar.Printf.fst"
                              (Prims.of_int (121)) (Prims.of_int (8))
                              (Prims.of_int (123)) (Prims.of_int (44)))
                           (Obj.magic (term_to_string p))
                           (fun uu___1 ->
                              FStar_Tactics_Effect.lift_div_tac
                                (fun uu___2 ->
                                   fun x ->
                                     Prims.strcat
                                       (Prims.strcat "intro_exists "
                                          (Prims.strcat uu___1 " "))
                                       (Prims.strcat x "")))))
                     (fun uu___1 ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___2 -> uu___1 uu___)))) uu___)
    | Pulse_Syntax.Tm_IntroExists
        { Pulse_Syntax.erased = true; Pulse_Syntax.p1 = p;
          Pulse_Syntax.witnesses = witnesses;_}
        ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (204)) (Prims.of_int (8)) (Prims.of_int (204))
             (Prims.of_int (43)))
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (202)) (Prims.of_int (6)) (Prims.of_int (204))
             (Prims.of_int (43)))
          (Obj.magic (term_list_to_string " " witnesses))
          (fun uu___ ->
             (fun uu___ ->
                Obj.magic
                  (FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (202)) (Prims.of_int (6))
                        (Prims.of_int (204)) (Prims.of_int (43)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (202)) (Prims.of_int (6))
                        (Prims.of_int (204)) (Prims.of_int (43)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (203)) (Prims.of_int (8))
                              (Prims.of_int (203)) (Prims.of_int (26)))
                           (FStar_Range.mk_range "FStar.Printf.fst"
                              (Prims.of_int (121)) (Prims.of_int (8))
                              (Prims.of_int (123)) (Prims.of_int (44)))
                           (Obj.magic (term_to_string p))
                           (fun uu___1 ->
                              FStar_Tactics_Effect.lift_div_tac
                                (fun uu___2 ->
                                   fun x ->
                                     Prims.strcat
                                       (Prims.strcat "intro_exists_erased "
                                          (Prims.strcat uu___1 " "))
                                       (Prims.strcat x "")))))
                     (fun uu___1 ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___2 -> uu___1 uu___)))) uu___)
    | Pulse_Syntax.Tm_While
        { Pulse_Syntax.invariant = invariant;
          Pulse_Syntax.condition = condition; Pulse_Syntax.body3 = body;_}
        ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (210)) (Prims.of_int (8)) (Prims.of_int (210))
             (Prims.of_int (32)))
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (207)) (Prims.of_int (6)) (Prims.of_int (210))
             (Prims.of_int (32))) (Obj.magic (st_term_to_string body))
          (fun uu___ ->
             (fun uu___ ->
                Obj.magic
                  (FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (207)) (Prims.of_int (6))
                        (Prims.of_int (210)) (Prims.of_int (32)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (207)) (Prims.of_int (6))
                        (Prims.of_int (210)) (Prims.of_int (32)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (209)) (Prims.of_int (8))
                              (Prims.of_int (209)) (Prims.of_int (37)))
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (207)) (Prims.of_int (6))
                              (Prims.of_int (210)) (Prims.of_int (32)))
                           (Obj.magic (st_term_to_string condition))
                           (fun uu___1 ->
                              (fun uu___1 ->
                                 Obj.magic
                                   (FStar_Tactics_Effect.tac_bind
                                      (FStar_Range.mk_range
                                         "Pulse.Syntax.Printer.fst"
                                         (Prims.of_int (207))
                                         (Prims.of_int (6))
                                         (Prims.of_int (210))
                                         (Prims.of_int (32)))
                                      (FStar_Range.mk_range
                                         "Pulse.Syntax.Printer.fst"
                                         (Prims.of_int (207))
                                         (Prims.of_int (6))
                                         (Prims.of_int (210))
                                         (Prims.of_int (32)))
                                      (Obj.magic
                                         (FStar_Tactics_Effect.tac_bind
                                            (FStar_Range.mk_range
                                               "Pulse.Syntax.Printer.fst"
                                               (Prims.of_int (208))
                                               (Prims.of_int (8))
                                               (Prims.of_int (208))
                                               (Prims.of_int (34)))
                                            (FStar_Range.mk_range
                                               "FStar.Printf.fst"
                                               (Prims.of_int (121))
                                               (Prims.of_int (8))
                                               (Prims.of_int (123))
                                               (Prims.of_int (44)))
                                            (Obj.magic
                                               (term_to_string invariant))
                                            (fun uu___2 ->
                                               FStar_Tactics_Effect.lift_div_tac
                                                 (fun uu___3 ->
                                                    fun x ->
                                                      fun x1 ->
                                                        Prims.strcat
                                                          (Prims.strcat
                                                             (Prims.strcat
                                                                "while<"
                                                                (Prims.strcat
                                                                   uu___2
                                                                   "> ("))
                                                             (Prims.strcat x
                                                                ") {"))
                                                          (Prims.strcat x1
                                                             "}")))))
                                      (fun uu___2 ->
                                         FStar_Tactics_Effect.lift_div_tac
                                           (fun uu___3 -> uu___2 uu___1))))
                                uu___1)))
                     (fun uu___1 ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___2 -> uu___1 uu___)))) uu___)
    | Pulse_Syntax.Tm_Par
        { Pulse_Syntax.pre11 = pre1; Pulse_Syntax.body11 = body1;
          Pulse_Syntax.post11 = post1; Pulse_Syntax.pre2 = pre2;
          Pulse_Syntax.body21 = body2; Pulse_Syntax.post21 = post2;_}
        ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (219)) (Prims.of_int (8)) (Prims.of_int (219))
             (Prims.of_int (30)))
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (213)) (Prims.of_int (6)) (Prims.of_int (219))
             (Prims.of_int (30))) (Obj.magic (term_to_string post2))
          (fun uu___ ->
             (fun uu___ ->
                Obj.magic
                  (FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (213)) (Prims.of_int (6))
                        (Prims.of_int (219)) (Prims.of_int (30)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (213)) (Prims.of_int (6))
                        (Prims.of_int (219)) (Prims.of_int (30)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (218)) (Prims.of_int (8))
                              (Prims.of_int (218)) (Prims.of_int (33)))
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (213)) (Prims.of_int (6))
                              (Prims.of_int (219)) (Prims.of_int (30)))
                           (Obj.magic (st_term_to_string body2))
                           (fun uu___1 ->
                              (fun uu___1 ->
                                 Obj.magic
                                   (FStar_Tactics_Effect.tac_bind
                                      (FStar_Range.mk_range
                                         "Pulse.Syntax.Printer.fst"
                                         (Prims.of_int (213))
                                         (Prims.of_int (6))
                                         (Prims.of_int (219))
                                         (Prims.of_int (30)))
                                      (FStar_Range.mk_range
                                         "Pulse.Syntax.Printer.fst"
                                         (Prims.of_int (213))
                                         (Prims.of_int (6))
                                         (Prims.of_int (219))
                                         (Prims.of_int (30)))
                                      (Obj.magic
                                         (FStar_Tactics_Effect.tac_bind
                                            (FStar_Range.mk_range
                                               "Pulse.Syntax.Printer.fst"
                                               (Prims.of_int (217))
                                               (Prims.of_int (8))
                                               (Prims.of_int (217))
                                               (Prims.of_int (29)))
                                            (FStar_Range.mk_range
                                               "Pulse.Syntax.Printer.fst"
                                               (Prims.of_int (213))
                                               (Prims.of_int (6))
                                               (Prims.of_int (219))
                                               (Prims.of_int (30)))
                                            (Obj.magic (term_to_string pre2))
                                            (fun uu___2 ->
                                               (fun uu___2 ->
                                                  Obj.magic
                                                    (FStar_Tactics_Effect.tac_bind
                                                       (FStar_Range.mk_range
                                                          "Pulse.Syntax.Printer.fst"
                                                          (Prims.of_int (213))
                                                          (Prims.of_int (6))
                                                          (Prims.of_int (219))
                                                          (Prims.of_int (30)))
                                                       (FStar_Range.mk_range
                                                          "Pulse.Syntax.Printer.fst"
                                                          (Prims.of_int (213))
                                                          (Prims.of_int (6))
                                                          (Prims.of_int (219))
                                                          (Prims.of_int (30)))
                                                       (Obj.magic
                                                          (FStar_Tactics_Effect.tac_bind
                                                             (FStar_Range.mk_range
                                                                "Pulse.Syntax.Printer.fst"
                                                                (Prims.of_int (216))
                                                                (Prims.of_int (8))
                                                                (Prims.of_int (216))
                                                                (Prims.of_int (30)))
                                                             (FStar_Range.mk_range
                                                                "Pulse.Syntax.Printer.fst"
                                                                (Prims.of_int (213))
                                                                (Prims.of_int (6))
                                                                (Prims.of_int (219))
                                                                (Prims.of_int (30)))
                                                             (Obj.magic
                                                                (term_to_string
                                                                   post1))
                                                             (fun uu___3 ->
                                                                (fun uu___3
                                                                   ->
                                                                   Obj.magic
                                                                    (FStar_Tactics_Effect.tac_bind
                                                                    (FStar_Range.mk_range
                                                                    "Pulse.Syntax.Printer.fst"
                                                                    (Prims.of_int (213))
                                                                    (Prims.of_int (6))
                                                                    (Prims.of_int (219))
                                                                    (Prims.of_int (30)))
                                                                    (FStar_Range.mk_range
                                                                    "Pulse.Syntax.Printer.fst"
                                                                    (Prims.of_int (213))
                                                                    (Prims.of_int (6))
                                                                    (Prims.of_int (219))
                                                                    (Prims.of_int (30)))
                                                                    (Obj.magic
                                                                    (FStar_Tactics_Effect.tac_bind
                                                                    (FStar_Range.mk_range
                                                                    "Pulse.Syntax.Printer.fst"
                                                                    (Prims.of_int (215))
                                                                    (Prims.of_int (8))
                                                                    (Prims.of_int (215))
                                                                    (Prims.of_int (33)))
                                                                    (FStar_Range.mk_range
                                                                    "Pulse.Syntax.Printer.fst"
                                                                    (Prims.of_int (213))
                                                                    (Prims.of_int (6))
                                                                    (Prims.of_int (219))
                                                                    (Prims.of_int (30)))
                                                                    (Obj.magic
                                                                    (st_term_to_string
                                                                    body1))
                                                                    (fun
                                                                    uu___4 ->
                                                                    (fun
                                                                    uu___4 ->
                                                                    Obj.magic
                                                                    (FStar_Tactics_Effect.tac_bind
                                                                    (FStar_Range.mk_range
                                                                    "Pulse.Syntax.Printer.fst"
                                                                    (Prims.of_int (213))
                                                                    (Prims.of_int (6))
                                                                    (Prims.of_int (219))
                                                                    (Prims.of_int (30)))
                                                                    (FStar_Range.mk_range
                                                                    "Pulse.Syntax.Printer.fst"
                                                                    (Prims.of_int (213))
                                                                    (Prims.of_int (6))
                                                                    (Prims.of_int (219))
                                                                    (Prims.of_int (30)))
                                                                    (Obj.magic
                                                                    (FStar_Tactics_Effect.tac_bind
                                                                    (FStar_Range.mk_range
                                                                    "Pulse.Syntax.Printer.fst"
                                                                    (Prims.of_int (214))
                                                                    (Prims.of_int (8))
                                                                    (Prims.of_int (214))
                                                                    (Prims.of_int (29)))
                                                                    (FStar_Range.mk_range
                                                                    "FStar.Printf.fst"
                                                                    (Prims.of_int (121))
                                                                    (Prims.of_int (8))
                                                                    (Prims.of_int (123))
                                                                    (Prims.of_int (44)))
                                                                    (Obj.magic
                                                                    (term_to_string
                                                                    pre1))
                                                                    (fun
                                                                    uu___5 ->
                                                                    FStar_Tactics_Effect.lift_div_tac
                                                                    (fun
                                                                    uu___6 ->
                                                                    fun x ->
                                                                    fun x1 ->
                                                                    fun x2 ->
                                                                    fun x3 ->
                                                                    fun x4 ->
                                                                    Prims.strcat
                                                                    (Prims.strcat
                                                                    (Prims.strcat
                                                                    (Prims.strcat
                                                                    (Prims.strcat
                                                                    (Prims.strcat
                                                                    "par (<"
                                                                    (Prims.strcat
                                                                    uu___5
                                                                    "> ("))
                                                                    (Prims.strcat
                                                                    x ") <"))
                                                                    (Prims.strcat
                                                                    x1 ") (<"))
                                                                    (Prims.strcat
                                                                    x2 "> ("))
                                                                    (Prims.strcat
                                                                    x3 ") <"))
                                                                    (Prims.strcat
                                                                    x4 ")")))))
                                                                    (fun
                                                                    uu___5 ->
                                                                    FStar_Tactics_Effect.lift_div_tac
                                                                    (fun
                                                                    uu___6 ->
                                                                    uu___5
                                                                    uu___4))))
                                                                    uu___4)))
                                                                    (fun
                                                                    uu___4 ->
                                                                    FStar_Tactics_Effect.lift_div_tac
                                                                    (fun
                                                                    uu___5 ->
                                                                    uu___4
                                                                    uu___3))))
                                                                  uu___3)))
                                                       (fun uu___3 ->
                                                          FStar_Tactics_Effect.lift_div_tac
                                                            (fun uu___4 ->
                                                               uu___3 uu___2))))
                                                 uu___2)))
                                      (fun uu___2 ->
                                         FStar_Tactics_Effect.lift_div_tac
                                           (fun uu___3 -> uu___2 uu___1))))
                                uu___1)))
                     (fun uu___1 ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___2 -> uu___1 uu___)))) uu___)
    | Pulse_Syntax.Tm_Rewrite { Pulse_Syntax.t1 = t1; Pulse_Syntax.t2 = t2;_}
        ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (224)) (Prims.of_int (14)) (Prims.of_int (224))
             (Prims.of_int (33)))
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (222)) (Prims.of_int (6)) (Prims.of_int (224))
             (Prims.of_int (33))) (Obj.magic (term_to_string t2))
          (fun uu___ ->
             (fun uu___ ->
                Obj.magic
                  (FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (222)) (Prims.of_int (6))
                        (Prims.of_int (224)) (Prims.of_int (33)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (222)) (Prims.of_int (6))
                        (Prims.of_int (224)) (Prims.of_int (33)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (223)) (Prims.of_int (8))
                              (Prims.of_int (223)) (Prims.of_int (27)))
                           (FStar_Range.mk_range "FStar.Printf.fst"
                              (Prims.of_int (121)) (Prims.of_int (8))
                              (Prims.of_int (123)) (Prims.of_int (44)))
                           (Obj.magic (term_to_string t1))
                           (fun uu___1 ->
                              FStar_Tactics_Effect.lift_div_tac
                                (fun uu___2 ->
                                   fun x ->
                                     Prims.strcat
                                       (Prims.strcat "rewrite "
                                          (Prims.strcat uu___1 " "))
                                       (Prims.strcat x "")))))
                     (fun uu___1 ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___2 -> uu___1 uu___)))) uu___)
    | Pulse_Syntax.Tm_WithLocal
        { Pulse_Syntax.initializer1 = initializer1;
          Pulse_Syntax.body4 = body;_}
        ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (229)) (Prims.of_int (8)) (Prims.of_int (229))
             (Prims.of_int (32)))
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (227)) (Prims.of_int (6)) (Prims.of_int (229))
             (Prims.of_int (32))) (Obj.magic (st_term_to_string body))
          (fun uu___ ->
             (fun uu___ ->
                Obj.magic
                  (FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (227)) (Prims.of_int (6))
                        (Prims.of_int (229)) (Prims.of_int (32)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (227)) (Prims.of_int (6))
                        (Prims.of_int (229)) (Prims.of_int (32)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (228)) (Prims.of_int (8))
                              (Prims.of_int (228)) (Prims.of_int (36)))
                           (FStar_Range.mk_range "FStar.Printf.fst"
                              (Prims.of_int (121)) (Prims.of_int (8))
                              (Prims.of_int (123)) (Prims.of_int (44)))
                           (Obj.magic (term_to_string initializer1))
                           (fun uu___1 ->
                              FStar_Tactics_Effect.lift_div_tac
                                (fun uu___2 ->
                                   fun x ->
                                     Prims.strcat
                                       (Prims.strcat "let mut _ = "
                                          (Prims.strcat uu___1 " in "))
                                       (Prims.strcat x "")))))
                     (fun uu___1 ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___2 -> uu___1 uu___)))) uu___)
    | Pulse_Syntax.Tm_Admit
        { Pulse_Syntax.ctag1 = ctag; Pulse_Syntax.u1 = u;
          Pulse_Syntax.typ = typ; Pulse_Syntax.post3 = post;_}
        ->
        FStar_Tactics_Effect.tac_bind
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (239)) (Prims.of_int (8)) (Prims.of_int (241))
             (Prims.of_int (60)))
          (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
             (Prims.of_int (232)) (Prims.of_int (6)) (Prims.of_int (241))
             (Prims.of_int (60)))
          (match post with
           | FStar_Pervasives_Native.None ->
               Obj.magic
                 (Obj.repr
                    (FStar_Tactics_Effect.lift_div_tac (fun uu___ -> "")))
           | FStar_Pervasives_Native.Some post1 ->
               Obj.magic
                 (Obj.repr
                    (FStar_Tactics_Effect.tac_bind
                       (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                          (Prims.of_int (241)) (Prims.of_int (38))
                          (Prims.of_int (241)) (Prims.of_int (59)))
                       (FStar_Range.mk_range "prims.fst" (Prims.of_int (590))
                          (Prims.of_int (19)) (Prims.of_int (590))
                          (Prims.of_int (31)))
                       (Obj.magic (term_to_string post1))
                       (fun uu___ ->
                          FStar_Tactics_Effect.lift_div_tac
                            (fun uu___1 ->
                               Prims.strcat " " (Prims.strcat uu___ ""))))))
          (fun uu___ ->
             (fun uu___ ->
                Obj.magic
                  (FStar_Tactics_Effect.tac_bind
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (232)) (Prims.of_int (6))
                        (Prims.of_int (241)) (Prims.of_int (60)))
                     (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                        (Prims.of_int (232)) (Prims.of_int (6))
                        (Prims.of_int (241)) (Prims.of_int (60)))
                     (Obj.magic
                        (FStar_Tactics_Effect.tac_bind
                           (FStar_Range.mk_range "Pulse.Syntax.Printer.fst"
                              (Prims.of_int (238)) (Prims.of_int (8))
                              (Prims.of_int (238)) (Prims.of_int (28)))
                           (FStar_Range.mk_range "FStar.Printf.fst"
                              (Prims.of_int (121)) (Prims.of_int (8))
                              (Prims.of_int (123)) (Prims.of_int (44)))
                           (Obj.magic (term_to_string typ))
                           (fun uu___1 ->
                              FStar_Tactics_Effect.lift_div_tac
                                (fun uu___2 ->
                                   fun x ->
                                     Prims.strcat
                                       (Prims.strcat
                                          (Prims.strcat
                                             (Prims.strcat ""
                                                (Prims.strcat
                                                   (match ctag with
                                                    | Pulse_Syntax.STT ->
                                                        "stt_admit"
                                                    | Pulse_Syntax.STT_Atomic
                                                        -> "stt_atomic_admit"
                                                    | Pulse_Syntax.STT_Ghost
                                                        -> "stt_ghost_admit")
                                                   "<"))
                                             (Prims.strcat
                                                (universe_to_string
                                                   Prims.int_zero u) "> "))
                                          (Prims.strcat uu___1 ""))
                                       (Prims.strcat x "")))))
                     (fun uu___1 ->
                        FStar_Tactics_Effect.lift_div_tac
                          (fun uu___2 -> uu___1 uu___)))) uu___)
    | Pulse_Syntax.Tm_Protect { Pulse_Syntax.t = t1;_} ->
        st_term_to_string t1