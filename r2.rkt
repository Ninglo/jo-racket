#lang racket

(provide r2)

(require "const.rkt")
(require "env.rkt")
(require "polyfill.rkt")
(require "interp.rkt")


(define (r2 expr)
    (interp expr (polyfill env0)))
