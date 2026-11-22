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

