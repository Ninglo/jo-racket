#lang racket

(require "r2.rkt")


(define test-list
    (list
        (cons 1  '(- 3 2))
        (cons #t '(not #f))
        (cons #t '(or #t #f))
        (cons #f '(and #t #f))
        (cons 1  '(if #t 1 2))
        (cons 14 '(* 2 (+ 3 4)))
        (cons 1  '(car (cons 1 2)))
        (cons 2  '(cdr (cons 1 2)))
        (cons 21 '(* (+ 1 2) (+ 3 4)))
        (cons 6  '((lambda (x) (* 2 x)) 3))
        (cons 6 
            '(let ([f (lambda (x y) (* x y))])
                (f 2 3)))
        (cons 7
            '(let ([z 3] [f (lambda (a b) (* a b))])
                (let ([f (lambda (x y) (* x y))])
                    (+ 4 z))))
        (cons 2
            '(let (
                [mkfib (lambda (self) (lambda (n)
                    (if (or (= n 1) (= n 2))
                        1
                        (+  ((self self) (- n 1)) 
                            ((self self) (- n 2))))))])
                ((mkfib mkfib) 3)))
        (cons 5 
            '(let (
                [fib (lambda (n)
                    (if (= n 1)
                        1
                        (if (= n 2)
                            1
                            (+  (fib (- n 1)) 
                                (fib (- n 2))))))])
                (fib 5)))
        (cons 55
            '(let (
                [fib-tail (lambda (n prev curt)
                    (if (or (= n 1) (= n 2))
                        curt
                        (fib-tail (- n 1) curt (+ prev curt))))])
                (fib-tail 10 1 1)))))

(for-each (lambda (p)
    (let ([ans (car p)]
          [res (r2 (cdr p))])
        (if (equal? ans res)
            #t
            (printf "error, ~a and ~a are not equal!" ans (cdr p)))))
    test-list)

(printf "test finished.\n")
