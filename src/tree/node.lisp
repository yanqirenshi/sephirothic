(in-package :sephirothic)

;;;;;
;;;;; Node
;;;;;
(defun node-at (graph class-symbol &key code)
  (is-keyword code)
  (first (find-object-with-slot graph class-symbol 'code code)))
