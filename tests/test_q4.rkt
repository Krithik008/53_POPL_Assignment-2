#lang racket/base

(require racket/port)

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

; print-insert-result reads x, lst, and n, then displays the transformed list.
(define (print-insert-result)
  (let* ((x (read))
         (lst (read))
         (n (read)))
    (display (insert-if-short x lst n))
    (newline)))

(define (check-equal description expected actual)
  (if (equal? actual expected)
      (begin (display "PASS: ") (display description) (newline))
      (begin (display "FAIL: ") (display description) (newline))))

(define (run-tests)
  (check-equal "insert example 1"
               '((42 1 2) (3 4 5) (42 6) (42))
               (insert-if-short 42 '((1 2) (3 4 5) (6) ()) 3))
  (check-equal "insert example 2"
               '((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))
               (insert-if-short 0 '(((1) 2) (3) ((4 5 6) ())) 3))
  (check-equal "insert empty list with positive limit" '(7)
               (insert-if-short 7 '() 3))
  (check-equal "empty list with zero limit stays empty" '()
               (insert-if-short 7 '() 0))
  (check-equal "my-length of empty list" 0 (my-length '()))
  (check-equal "my-length of flat list" 3 (my-length '(1 2 3)))
  (check-equal "my-length counts only top-level elements" 3
               (my-length '(1 (2 3) 4)))
  (check-equal "make-inserter accepts custom length predicate"
               '((9 1 2) (3) ())
               ((make-inserter 9 (lambda (len) (= len 2)))
                '((1 2) (3) ())))
  (check-equal "nested list reaches depth five"
               '(0 (0 (0 (0 (0 1)))))
               (insert-if-short 0 '(((((1))))) 2))
  (let ((deep-input
         (let loop ((count 100) (result '(1)))
           (if (= count 0) result (loop (- count 1) (list result)))))
        (deep-expected
         (let loop ((count 100) (result '(1)))
           (if (= count 0) result
               (loop (- count 1) (list 0 result))))))
    (check-equal "nested list reaches depth 100" deep-expected
                 (insert-if-short 0 deep-input 2)))
  (check-equal "flat list of 20 elements"
               '(99 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
               (insert-if-short 99 '(1 2 3 4 5 6 7 8 9 10
                                      11 12 13 14 15 16 17 18 19 20) 21))
  (check-equal "print-insert-result reads three values and prints one line"
               "((42 1 2) (3 4 5) (42 6) (42))\n"
               (with-output-to-string
                (lambda ()
                  (with-input-from-string
                   "42 ((1 2) (3 4 5) (6) ()) 3"
                   print-insert-result)))))

(run-tests)
