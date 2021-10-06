#lang racket

(provide poly-env)
(provide polyfill)

(require "const.rkt")
(require "env.rkt")
(require "./lib/index.rkt")


(define (polyfill env)
    (foldl
        (lambda (p prev-env)
            (ext-env
                (car p)
                (Closure
                    (cdr p)
                    prev-env)
                prev-env))
        env
        lib-list))

(define poly-env (polyfill env0))
