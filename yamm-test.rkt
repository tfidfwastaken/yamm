#lang yamm

--- # The yamms are the powers that be
  processed: $e (equal? 5 5.0) e$
  $e (for/hash ([i (in-range 5)]
                [j '("bunch" "of" "values" "here")])
      (values i j)) e$

$e (list "this" "is" "a" "list") e$
