#lang racket

(provide cons-lib)

(require "../const.rkt")


(define cons-lib
    (list
        (cons 'car
            '(lambda (p)
                (p (lambda (x y)
                    x))))
        (cons 'cdr
            '(lambda (p)
                (p (lambda (x y)
                    y))))
        (cons 'cons
            '(lambda (x y)
                (lambda (m) (m x y))))))
