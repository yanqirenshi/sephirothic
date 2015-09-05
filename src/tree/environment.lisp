(in-package :sephirothic)

;;;;;
;;;;; Environment
;;;;;
(defun environment-at (tree &key code application)
  (assert tree)
  (cond ((and code application) nil)
        (code (node-at tree 'environment :code code))
        (t nil)))

(defun tx-make-environment (tree code &key (name ""))
  (assert tree)
  (when (environment-at tree :code code)
    (error "Aledy exist. code=~code" code))
  (tx-make-vertex tree 'environment
                  `((code ,code) (name ,name))))

(defun make-environment (tree code &key (name ""))
  (assert tree)
  (up:execute-transaction
   (tx-make-environment tree code :name name)))
