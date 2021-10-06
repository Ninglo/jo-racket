#lang racket

(require "r2.rkt")


(printf "input file name: ")

(let ([in (open-input-file (read-line (current-input-port) 'any))])
    (let ([expr (read in)])
        (r2 expr)))
