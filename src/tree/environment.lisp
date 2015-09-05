(in-package :sephirothic)

;;;;;
;;;;; Environment
;;;;;
(defun environment-at (tree &key code application)
  (assert tree)
  (cond ((and code application)
         (getf (find-if #'(lambda (node)
                            (eq (code (getf node :vertex)) code))
                        (shinra:find-r tree 'relationship :from application))
               :vertex))
        (code (node-at tree 'environment :code code))
        (t nil)))

(defun tx-make-environment (tree code &key (name ""))
  (assert tree)
  (when (environment-at tree :code code)
    (error "Aledy exist. code=~code" code))
  (tx-make-vertex tree 'environment
                  `((code ,code) (name ,name))))
