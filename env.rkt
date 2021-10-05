#lang racket

(provide lookup)
(provide ext-env)

(require "const.rkt")


(define (ext-env x v env)
    (cons `(,x . ,v) env))

(define (lookup x env)
    (let ([p (assq x env)])
        (cond
            [(not p) (error (string-append 
                "var " (~a x) " is undefined!"))]
            [else (cdr p)])))
