#lang racket/base
(require syntax/parse/define
         racket/string
         (for-syntax racket/base))
(require yaml)
(provide #%top-interaction #%datum #%top #%app)

(define-simple-macro (yamm-mb parse-tree:expr)
  (#%module-begin
   (define result-string parse-tree)
   (define validated-yaml (string->yaml result-string))
   (display result-string)))
(provide (rename-out [yamm-mb #%module-begin]))

(define-simple-macro (yamm-program sexp-or-yaml-str:expr ...)
  (string-trim (string-append sexp-or-yaml-str ...)))
(provide yamm-program)

(define-simple-macro (yaml-char char-tok-value:expr)
  char-tok-value)
(provide yaml-char)

(define-syntax (sexp stx)
  (syntax-parse stx
    [(sexp sexp-str:expr)
     (with-syntax ([sexp-datum (read
                                (open-input-string
                                 (syntax->datum #'sexp-str)))])
       #'(yaml->string sexp-datum #:style 'block))]))
(provide sexp)
