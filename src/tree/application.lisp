(in-package :sephirothic)

;;;;;
;;;;; Application
;;;;;
(defun applications (tree)
  (find-objects tree 'application))

(defun application-at (tree &key code (ensure nil))
  (assert tree)
  (let ((appl (node-at tree 'application :code code)))
    (or appl
        (when (and code ensure)
          (make-application tree code)))))

(defun tx-make-application (tree code &key (name ""))
  (assert tree)
  (when (application-at tree :code code)
    (error* :alredy-exist 'application code))
  (tx-make-vertex tree 'application
                  `((code ,code) (name ,name))))

(defun make-application (tree code &key (name ""))
  (assert tree)
  (execute-transaction
   (tx-make-application tree code :name name)))

(defun tx-add-environment (tree application code &key (name ""))
  (assert (and tree application))
  (is-keyword code)
  (when (environment-at tree :application application :code code)
    (error* :alredy-exist-env-at-appl 'environment code application))
  (let ((environment (tx-make-environment tree code :name name)))
    (values environment
            (tx-make-relationship tree application environment))))

(defun add-environment (tree application code &key (name ""))
  (assert tree)
  (execute-transaction
   (tx-add-environment tree application code :name name)))
