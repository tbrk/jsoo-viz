
all: main.js

main.js: main.byte
	js_of_ocaml $<

main.byte: main.ml promise.cmi promise.cmo graphviz.cmi graphviz.cmo
	ocamlfind ocamlc \
	    -package js_of_ocaml \
	    -package js_of_ocaml-ppx \
	    -linkpkg -o $@ \
	    promise.cmo graphviz.cmo main.ml

graphviz.cmi: graphviz.mli
	ocamlfind ocamlc \
	    -package js_of_ocaml \
	    $<

graphviz.cmo: graphviz.ml graphviz.cmi
	ocamlfind ocamlc -c \
	    -package js_of_ocaml \
	    -package js_of_ocaml-ppx \
	    $<

promise.cmi: promise.mli
	ocamlfind ocamlc -package js_of_ocaml $<

promise.cmo: promise.ml
	ocamlfind ocamlc -c -package js_of_ocaml -package js_of_ocaml-ppx $<

lwt_promise.cmi: lwt_promise.mli promise.cmi
	ocamlfind ocamlc -package js_of_ocaml -package js_of_ocaml-lwt $<

lwt_promise.cmo: lwt_promise.ml promise.cmi
	ocamlfind ocamlc -c \
	    -package js_of_ocaml \
	    -package js_of_ocaml-ppx \
	    -package js_of_ocaml-lwt \
	    $<

clean:
	-@rm -rf main.byte main.js main.cmo main.cmi
	-@rm -rf promise.cmi promise.cmo
	-@rm -rf graphviz.cmi graphviz.cmo
	-@rm -rf lwt_promise.cmi lwt_promise.cmo

