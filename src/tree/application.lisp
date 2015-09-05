(in-package :sephirothic)

;;;;;
;;;;; Application
;;;;;
(defun application-at (tree &key code)
  (assert tree)
  (node-at tree 'application :code code))

(defun tx-make-application (tree code &key (name ""))
  (assert tree)
  (when (application-at tree :code code)
    (error "Aledy exist. code=~code" code))
  (tx-make-vertex tree 'application
                  `((code ,code) (name ,name))))

(defun make-application (tree code &key (name ""))
  (assert tree)
  (up:execute-transaction
   (tx-make-application tree code :name name)))
