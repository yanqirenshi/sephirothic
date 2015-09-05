(in-package :sephirothic)

;;;;;
;;;;; Application
;;;;;
(defun application-at (&key (code *application*) (graph *tree*))
  (node-at graph 'application :code code))

(defun tx-make-application (graph code &key (name ""))
  (when (application-at :code code :graph graph)
    (error "Aledy exist. code=~code" code))
  (tx-make-vertex graph 'application
                  `((code ,code) (name ,name))))

(defun make-application (code &key (name "") (graph *tree*))
  (unless graph (setf graph (start)))
  (up:execute-transaction
   (tx-make-application graph code :name name)))
