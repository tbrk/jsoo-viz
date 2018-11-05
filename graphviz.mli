(***********************************************************************)
(*                                                                     *)
(*    Low-level js_of_ocaml interface to Mike Daines' Graphviz hack    *)
(*                                                                     *)
(*                   Timothy Bourke (Inria/ENS)                        *)
(*                                                                     *)
(*  Copyright 2018 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under an MIT License, refer to the file LICENSE.                   *)
(*                                                                     *)
(***********************************************************************)

(**
   Low-level interface to the {{:https://github.com/mdaines/viz.js}{vis.js}}
   Javascript library.

   The interface and notes are based on the
   {{:https://github.com/mdaines/viz.js/wiki/API}{original documentation}}.

   @version v2.0.0
   @author Timothy Bourke (Inria/ENS)
 *)

(** Class for passing images. *)
class type image = object
  method path : Js.js_string Js.t Js.prop
  method width  : Js.js_string Js.t Js.optdef_prop
  method height : Js.js_string Js.t Js.optdef_prop
end

(** Class for passing files. *)
class type file = object
  method path : Js.js_string Js.t Js.optdef_prop
  method data : Js.js_string Js.t Js.optdef_prop
end

(** Class for passing options. *)
class type options = object
  method engine : Js.js_string Js.t Js.optdef_prop
  method format : Js.js_string Js.t Js.optdef_prop
  method yInvert : bool Js.t Js.prop
  method images : image Js.t Js.js_array Js.prop
  method files : file Js.t Js.js_array Js.prop

  (* Extra options for renderImageElement (which ignores format) *)
  method scale : float Js.optdef_prop
  method mimeType : Js.js_string Js.t Js.optdef_prop
  method quality : float Js.optdef_prop
end

(** The main graphing class. *)
class type t = object

  method renderString
    : Js.js_string Js.t
      -> Js.js_string Js.t Promise.promise Js.t Js.meth

  method renderString_withOptions
    : Js.js_string Js.t
      -> options Js.t
      -> Js.js_string Js.t Promise.promise Js.t Js.meth

  method renderSVGElement
    : Js.js_string Js.t
      -> Dom_svg.svgElement Js.t Promise.promise Js.t Js.meth

  method renderSVGElement_withOptions
    : Js.js_string Js.t
      -> options Js.t
      -> Dom_svg.svgElement Js.t Promise.promise Js.t Js.meth

  method renderImageElement
    : Js.js_string Js.t
      -> Dom_html.imageElement Js.t Promise.promise Js.t Js.meth

  method renderImageElement_withOptions
    : Js.js_string Js.t
      -> options Js.t
      -> Dom_html.imageElement Js.t Promise.promise Js.t Js.meth

  method renderJSONObject
    : Js.js_string Js.t
      -> < .. > Js.t Promise.promise Js.t Js.meth

  method renderJSONObject_withOptions
    : Js.js_string Js.t
      -> options Js.t
      -> < .. > Js.t Promise.promise Js.t Js.meth
end

(** Create an image object. *)
val image : ?width:Js.js_string Js.t
            -> ?height:Js.js_string Js.t
            -> Js.js_string Js.t
            -> image Js.t

(** Create a file object. *)
val file : path: Js.js_string Js.t
          -> data: Js.js_string Js.t
          -> file Js.t

(** Create an options object. *)
val options : ?engine: Js.js_string Js.t
              -> ?format: Js.js_string Js.t
              -> ?yInvert: bool
              -> ?images: image Js.js_array Js.t
              -> ?files: file Js.js_array Js.t
              -> ?scale: float
              -> ?mimeType : Js.js_string Js.t
              -> ?quality: float
              -> unit
              -> options Js.t

(** Create a Graphviz object. *)
val viz : t Js.t Js.constr

