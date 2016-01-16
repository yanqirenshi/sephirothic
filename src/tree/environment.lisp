(in-package :sephirothic)

;;;;;
;;;;; Environment
;;;;;
(defun %environment-at (tree code application)
  (cond ((and code application)
         (getf (find-if #'(lambda (node)
                            (eq (code (getf node :vertex)) env-code))
                        (find-r tree 'relationship :from application))
               :vertex))
        (code
         (node-at tree 'environment :code code))
        (t nil)))

(defun environment-at (tree &key code application ensure)
  (assert tree)
  (let ((env (%environment-at tree code application)))
    (or env
        (when (and code ensure)
          (add-environment tree application code)))))

(defun tx-make-environment (tree code &key (name ""))
  (assert tree)
  (tx-make-vertex tree 'environment
                  `((code ,code) (name ,name))))
