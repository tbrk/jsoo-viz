(* Taken from Ke Wang's (https://github.com/aik9508)
   pull request (https://github.com/ocsigen/js_of_ocaml/pull/609) *)

open Js_of_ocaml
open Promise

val to_lwt : 'a promise Js.t -> 'a Lwt.t
val of_lwt : (unit -> 'a Lwt.t) -> 'a promise Js.t

