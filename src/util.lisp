(in-package :sephirothic)

;;;;;
;;;;; Utility
;;;;;
(defun is-keyword (value)
  (when (or (null value)
            (not (keywordp value)))
    (error "~A is not keyword" value))
  value)
