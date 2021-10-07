#lang racket

(require "lambda.rkt")


(printf "input file name: ")

(let ([in (open-input-file (read-line (current-input-port) 'any))])
    (let ([expr (read in)])
        (λ expr)))
