#lang racket

(provide cons-lib)

(require "../const.rkt")


(define cons-lib
    (list
        (cons 'null
            '(lambda (m) (m null null true)))
        (cons 'is-null
            '(lambda (p)
                (p (lambda (x y null-flag) null-flag))))
        (cons 'car
            '(lambda (p)
                (p (lambda (x y _)
                    x))))
        (cons 'cdr
            '(lambda (p)
                (p (lambda (x y _)
                    y))))
        (cons 'cons
            '(lambda (x y)
                (lambda (m) (m x y false))))))
