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

(defun tx-add-environment (tree application code &key (name ""))
  (assert (and tree application))
  (is-keyword code)
  (when (environment-at tree :application application :code code)
    (error "Aledy exist."))
  (let ((environment (tx-make-environment tree code :name name)))
    (values environment
            (tx-make-relationship tree application environment))))

(defun add-environment (tree application code &key (name ""))
  (assert tree)
  (up:execute-transaction
   (tx-add-environment tree application code :name name)))
