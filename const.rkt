#lang racket

(provide Closure)
(provide env0)


(struct Closure (f env))

(define env0 '())
