(in-package :sephirothic)

;;;;;
;;;;; Node
;;;;;
(defun node-at (graph class-symbol &key code)
  (is-keyword code)
  (first (find-objects graph class-symbol :slot 'code :value code)))
