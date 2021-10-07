#lang racket

(provide λ)

(require "const.rkt")
(require "env.rkt")
(require "polyfill.rkt")
(require "interp.rkt")


(define (λ expr)
    (interp expr poly-env))
