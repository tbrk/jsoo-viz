(* Basic test to turn Graphviz into svg. *)

open Js_of_ocaml

module Html = Dom_html
let js = Js.string
let document = Html.window##.document

let by_id s = Dom_html.getElementById s

let startWithOptions _ =
  let main = document##.body in
  Printf.printf "Calling Graphviz...\n";
  let viz = new%js Graphviz.viz in
  let options = Graphviz.options ~engine:(js "neato") () in

  let p_svg = viz##renderSVGElement_withOptions
                (js "digraph { a -> b }") options in
  ignore (Promise._then p_svg
            (fun svg ->
              Printf.printf "Graphviz value resolved (%s).\n"
                (Js.to_string svg##.tagName)
              ;
              Printf.printf "scale=%e.\n" svg##.currentScale;
              svg##.currentScale := 0.5;
              Promise.resolve_value (Dom.appendChild main svg)));
  Printf.printf "Graphviz done.\n";
  Js._false

let _ =
  Dom_html.window##.onload := Dom_html.handler startWithOptions

