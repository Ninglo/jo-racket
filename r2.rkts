#lang racket

(struct Closure (f env))

(define env0 '())

(define (ext-env x v env)
    (cons `(,x . ,v) env))

(define (lookup x env)
    (let ([p (assq x env)])
        (cond
            [(not p) (error "no v!" x)]
            [else (cdr p)])))

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

(define polifill
    (ext-env
        'or
        (Closure
            '(lambda (x y) 
                (if x x y))
            env0)
        env0))

(define (r2 expr)
    (interp expr polifill))


; (r2 '(- 3 2))
; ;; => 1

; (r2 '(* 2 3))
; ;; => 6

; (r2 '(* 2 (+ 3 4)))
; ;; => 14

; (r2 '(* (+ 1 2) (+ 3 4)))
; ;; => 21

; (r2 '((lambda (x) (* 2 x)) 3))
; ;; => 6

; (r2
; '(let ([z 3] [f (lambda (a b) (* a b))])
;    (let ([f (lambda (x y) (* x y))])
;     (+ 4 z))))
; ; => 7

; (r2
; '(if #t
;     1
;     2))
; ;; => 1

; (r2
; '(let ([f (lambda (x y) (* x y))])
;     (f 2 3)))
; ;; => 6

(r2
'(let (
    [mkfib (lambda (self) (lambda (n)
        (if (or (= n 1) (= n 2))
            1
            (+  ((self self) (- n 1)) 
                ((self self) (- n 2))))))])
    ((mkfib mkfib) 3)))
;; => 2

(r2
'(let (
    [fib (lambda (n)
        (if (= n 1)
            1
            (if (= n 2)
                1
                (+  (fib (- n 1)) 
                    (fib (- n 2))))))])
    (fib 5)))
;; => 5

(r2
'(let (
    [fib-tail (lambda (n prev curt)
        (if (or (= n 1) (= n 2))
            curt
            (fib-tail (- n 1) curt (+ prev curt))))])
    (fib-tail 10 1 1)))
;; => 55
