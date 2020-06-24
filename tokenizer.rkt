#lang racket/base
(require brag/support
         racket/contract)

(module+ test
  (require rackunit))

(define (yamm-token? x)
  (or (eof-object? x) (token-struct? x)))

(module+ test
  (check-true (yamm-token? eof))
  (check-true (yamm-token? (token 'TOK-STRUCT "test")))
  (check-false (yamm-token? 420)))

(define (make-tokenizer port)
  (define (next-token)
    (define yamm-lexer
      (lexer
       [(from/to "$e" "e$")
        (token 'SEXP-TOK (trim-ends "$e" lexeme "e$"))]
       [any-char (token 'YAML-CHAR-TOK lexeme))])
      (yamm-lexer port))
    next-token)

(provide
 (contract-out
  [make-tokenizer (input-port? . -> . (-> yamm-token?))]))
