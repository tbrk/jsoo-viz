class type image = object
  method path   : Js.js_string Js.t Js.prop
  method width  : Js.js_string Js.t Js.optdef_prop
  method height : Js.js_string Js.t Js.optdef_prop
end

class type file = object
  method path : Js.js_string Js.t Js.optdef_prop
  method data : Js.js_string Js.t Js.optdef_prop
end

class type options = object
  method engine : Js.js_string Js.t Js.optdef_prop
  method format : Js.js_string Js.t Js.optdef_prop
  method yInvert : bool Js.t Js.prop
  method images : image Js.t Js.js_array Js.prop
  method files : file Js.t Js.js_array Js.prop

  method scale : float Js.optdef_prop
  method mimeType : Js.js_string Js.t Js.optdef_prop
  method quality : float Js.optdef_prop
end

class type t = object

  method renderString
    : Js.js_string Js.t -> Js.js_string Js.t Promise.promise Js.t Js.meth

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

let image ?width ?height path =
  let r = Js.(Unsafe.(obj [|
              ("path", inject path);
          |]))
  in
  (match width with None -> () | Some v -> r##.width := v);
  (match height with None -> () | Some v -> r##.height := v);
  r

let file ~path ~data =
  Js.(Unsafe.(obj [|
      ("path", inject path);
      ("data", inject data);
  |]))

let options ?engine
            ?format
            ?(yInvert=false)
            ?(images=new%js Js.array_empty)
            ?(files=new%js Js.array_empty)
            ?scale
            ?mimeType
            ?quality
            () =
  let r = Js.(Unsafe.(obj [|
      ("yInvert", inject (bool yInvert));
      ("images",  inject images);
      ("files",   inject files);
  |])) in
  (match engine with None -> ()   | Some v -> r##.engine := v);
  (match format with None -> ()   | Some v -> r##.format := v);
  (match scale with None -> ()    | Some v -> r##.scale := v);
  (match mimeType with None -> () | Some v -> r##.mimeType := v);
  (match quality with None -> ()  | Some v -> r##.quality := v);
  r

let viz = Js.Unsafe.global##._Viz

