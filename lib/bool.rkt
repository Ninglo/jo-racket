#lang racket

(provide bool-lib)

(require "../const.rkt")


(define bool-lib
    (list
        (cons 'or
            '(lambda (x y)
                (if x x y)))
        (cons 'and
            '(lambda (x y)
                (if x y x)))
        (cons 'not
            '(lambda (x)
                (if x #f #t)))))
