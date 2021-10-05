#lang racket

(provide polyfill)

(require "const.rkt")
(require "env.rkt")


(define (polyfill env)
    (ext-env
        'or
        (Closure
            '(lambda (x y) 
                (if x x y))
            env)
        env))