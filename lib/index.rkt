#lang racket

(provide lib-list)

(require "basic.rkt")
(require "bool.rkt")
(require "cons.rkt")
; (require "number.rkt")


(define lib-list
    (append
        basic-lib
        bool-lib
        cons-lib))
