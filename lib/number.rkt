#lang racket

(provide number-lib)

(require "../const.rkt")


(define number-lib
    (list
        (cons 'to-normal
            '(lambda (n)
                (n (lambda (x) (+ 1 x)) 0)))
        (cons 'zero
            '(lambda (f x)
                x))
        (cons 'one
            '(lambda (f x)
                (f x)))
        (cons 'two
            '(lambda (f x)
                (f (f x))))
        (cons 'add1
            '(lambda (n)
                (lambda (f x)
                    (f (n f x)))))
        (cons 'add
            '(lambda (n m)
                (m add1 n)))
        (cons 'is-zero
            '(lambda (n)
                (n (lambda (_) false) true)))
        (cons 'wrap
            '(lambda (f)
                (lambda (p) 
                    (cons
                        false
                        (if (car p)
                            (cdr p)
                            (f (cdr p)))))))
        (cons 'sub1
            '(lambda (n)
                (lambda (f x)
                    (n (wrap f) (cons true x)))))
        (cons 'sub
            '(lambda (n m)
                (m add1 n)))
        (cons 'mult
            '(lambda (n m)
                (m (add n zero) zero)))))
