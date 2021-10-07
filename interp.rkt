#lang racket

(provide interp)

(require "const.rkt")
(require "env.rkt")


(define (concat-env env)
    (lambda (expr prev)
        (let (
            [x (car expr)]
            [v (interp (car (cdr expr)) env)])
            (ext-env x v prev))))

(define (call ef vargs env)
    (let ([f (interp ef env)])
        (match f
            [(Closure `(lambda (,nargs ...) ,e) env-save)
            (interp
                e
                (ext-env 
                    ef
                    f
                    (foldl
                        (lambda (e v prev)
                            (ext-env e v prev))
                        env-save
                        nargs
                        vargs)))])))

(define (interp expr env)
    (match expr
        [(? boolean? x) x]
        [(? number? x) x]
        [(? symbol? x) (lookup x env)]
        [`(lambda (,args ...) ,e)
            (Closure expr env)]
        [`(let (,total ...) ,e2)
            (interp
                e2
                (foldl
                    (concat-env env)
                    env
                    total))]
        [`(if ,e1 ,e2 ,e3)
            (let ([v1 (interp e1 env)])
                (if v1
                    (interp e2 env)
                    (interp e3 env)))]
        [`(,ef ,eargs ...)
            (let ([vargs (map (lambda (earg) (interp earg env)) eargs)])
                (match ef
                    ['+ (apply + vargs)]
                    ['- (apply - vargs)]
                    ['* (apply * vargs)]
                    ['/ (apply / vargs)]
                    ['= (= (car vargs) (car (cdr vargs)))]
                    [else (call ef vargs env)]))]))
