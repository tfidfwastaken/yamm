#lang racket/base

(require rackunit
         yamm/parser
         yamm/tokenizer
         brag/support)

(check-equal?
 (parse-to-datum (apply-tokenizer-maker make-tokenizer ""))
 '(yamm-program))

(check-equal?
 (parse-to-datum (apply-tokenizer-maker make-tokenizer "$e (- 2 2) e$"))
 '(yamm-program
   (sexp "(- 2 2)")))

(check-equal?
 (parse-to-datum (apply-tokenizer-maker make-tokenizer "hi"))
 '(yamm-program
   (yaml-char "h")
   (yaml-char "i")))

(check-equal?
 (parse-to-datum (apply-tokenizer-maker make-tokenizer #<<TEST
--- # what's the yams
- list
- $e (+ 4 3) e$

$e #hash(("one" . 1) ("two" . 2) ("etc" . 420)) e$
TEST
                                        ))
 '(yamm-program
   (yaml-char "-")
   (yaml-char "-")
   (yaml-char "-")
   (yaml-char " ")
   (yaml-char "#")
   (yaml-char " ")
   (yaml-char "w")
   (yaml-char "h")
   (yaml-char "a")
   (yaml-char "t")
   (yaml-char "'")
   (yaml-char "s")
   (yaml-char " ")
   (yaml-char "t")
   (yaml-char "h")
   (yaml-char "e")
   (yaml-char " ")
   (yaml-char "y")
   (yaml-char "a")
   (yaml-char "m")
   (yaml-char "s")
   (yaml-char "\n")
   (yaml-char "-")
   (yaml-char " ")
   (yaml-char "l")
   (yaml-char "i")
   (yaml-char "s")
   (yaml-char "t")
   (yaml-char "\n")
   (yaml-char "-")
   (yaml-char " ")
   (sexp "(+ 4 3)")
   (yaml-char "\n")
   (yaml-char "\n")
   (sexp "#hash((\"one\" . 1) (\"two\" . 2) (\"etc\" . 420))")))
