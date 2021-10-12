#lang racket

(provide basic-lib)

(require "../const.rkt")


(define basic-lib
    (list
        (cons 'echo
            '(lambda (x)
                x))))
 1