#lang racket/base

(require racket/port)

; inorder returns the inorder values of tree followed by acc.
(define (inorder tree acc)
  (if (null? tree)
      acc
      (inorder (cadr tree)
               (cons (car tree) (inorder (caddr tree) acc)))))

; preorder returns the preorder values of tree followed by acc.
(define (preorder tree acc)
  (if (null? tree)
      acc
      (cons (car tree)
            (preorder (cadr tree)
                      (preorder (caddr tree) acc)))))

; postorder returns the postorder values of tree followed by acc.
(define (postorder tree acc)
  (if (null? tree)
      acc
      (postorder (cadr tree)
                 (postorder (caddr tree) (cons (car tree) acc)))))

; print-inorder displays the inorder traversal of tree on one line.
(define (print-inorder tree)
  (display (inorder tree '()))
  (newline))

; print-all-traversals displays the inorder, preorder, and postorder traversals.
(define (print-all-traversals tree)
  (display (inorder tree '()))
  (newline)
  (display (preorder tree '()))
  (newline)
  (display (postorder tree '()))
  (newline))

; tree-height returns the number of nodes on the longest root-to-leaf path.
(define (tree-height tree)
  (if (null? tree)
      0
      (+ 1 (max (tree-height (cadr tree))
                (tree-height (caddr tree))))))

; count-leaves returns the number of leaves in tree.
(define (count-leaves tree)
  (if (null? tree)
      0
      (if (and (null? (cadr tree)) (null? (caddr tree)))
          1
          (+ (count-leaves (cadr tree))
             (count-leaves (caddr tree))))))

; print-height-and-leaves displays the height and leaf count of tree.
(define (print-height-and-leaves tree)
  (display (list (tree-height tree) (count-leaves tree)))
  (newline))

(define t1 '(4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ()))))
(define t2 '(1 () (2 () (3 () ()))))
(define t3 '(a (b () ()) (c () ())))
(define empty-tree '())

(define (check-output description expected thunk)
  (if (equal? (with-output-to-string thunk) expected)
      (begin (display "PASS: ") (display description) (newline))
      (begin (display "FAIL: ") (display description) (newline))))

(define (run-tests)
  (check-output "t1 inorder" "(1 2 3 4 5 6 7)\n"
                (lambda () (print-inorder t1)))
  (check-output "t1 all traversals"
                "(1 2 3 4 5 6 7)\n(4 2 1 3 6 5 7)\n(1 3 2 5 7 6 4)\n"
                (lambda () (print-all-traversals t1)))
  (check-output "t1 height and leaves" "(3 4)\n"
                (lambda () (print-height-and-leaves t1)))
  (check-output "t2 all traversals"
                "(1 2 3)\n(1 2 3)\n(3 2 1)\n"
                (lambda () (print-all-traversals t2)))
  (check-output "t2 height and leaves" "(3 1)\n"
                (lambda () (print-height-and-leaves t2)))
  (check-output "t3 all traversals"
                "(b a c)\n(a b c)\n(b c a)\n"
                (lambda () (print-all-traversals t3)))
  (check-output "t3 height and leaves" "(2 2)\n"
                (lambda () (print-height-and-leaves t3)))
  (check-output "empty inorder" "()\n"
                (lambda () (print-inorder empty-tree)))
  (check-output "empty all traversals" "()\n()\n()\n"
                (lambda () (print-all-traversals empty-tree)))
  (check-output "empty height and leaves" "(0 0)\n"
                (lambda () (print-height-and-leaves empty-tree))))

(run-tests)
