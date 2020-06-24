#lang racket/base
(require "tokenizer.rkt"
         "parser.rkt"
         racket/contract)

(define (read-syntax path port)
  (define parse-tree (parse path (make-tokenizer port)))
  (define module-datum `(module yamm-mod yamm/expander
                          ,parse-tree))
  (datum->syntax #f module-datum))
(provide (contract-out
          [read-syntax (any/c port? . -> . syntax?)]))
