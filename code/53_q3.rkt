#lang racket/base

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
