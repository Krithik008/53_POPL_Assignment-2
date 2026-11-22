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

; make-inserter returns a function that inserts x into lists passing len-ok?.
(define (make-inserter x len-ok?)
  (letrec ((insert
            (lambda (lst)
              (let ((processed
                     (my-map
                      (lambda (element)
                        (if (or (pair? element) (null? element))
                            (insert element)
                            element))
                      lst)))
                (if (len-ok? (my-length lst))
                    (cons x processed)
                    processed)))))
    insert))

; insert-if-short inserts x into every list shorter than n at every depth.
(define (insert-if-short x lst n)
  ((make-inserter x (lambda (len) (< len n))) lst))
