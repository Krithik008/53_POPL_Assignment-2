#lang racket/base

; my-length returns the number of top-level elements in lst.
(define (my-length lst)
  (let loop ((remaining lst) (count 0))
    (if (null? remaining)
        count
        (loop (cdr remaining) (+ count 1)))))

; my-reverse reverses lst with a tail-recursive accumulator.
(define (my-reverse lst)
  (let loop ((remaining lst) (result '()))
    (if (null? remaining)
        result
        (loop (cdr remaining) (cons (car remaining) result)))))

; my-map applies function to each top-level element of lst.
(define (my-map function lst)
  (let loop ((remaining lst) (result '()))
    (if (null? remaining)
        (my-reverse result)
        (loop (cdr remaining)
              (cons (function (car remaining)) result)))))

; insert-if-short inserts x into each original list shorter than n.
(define (insert-if-short x lst n)
  (if (< (my-length lst) n)
      (cons x
            (my-map
             (lambda (element)
               (if (or (pair? element) (null? element))
                   (insert-if-short x element n)
                   element))
             lst))
      (my-map
       (lambda (element)
         (if (or (pair? element) (null? element))
             (insert-if-short x element n)
             element))
       lst)))
