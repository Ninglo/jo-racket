#lang racket

(provide lib-list)

(require "bool.rkt")
(require "cons.rkt")


(define lib-list
    (append
        bool-lib
        cons-lib))
