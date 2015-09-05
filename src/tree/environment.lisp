(in-package :sephirothic)

;;;;;
;;;;; Environment
;;;;;
(defun environment-at (&key (code *environment*) (graph *tree*))
  (node-at graph 'environment :code code))

(defun tx-make-environment (graph code &key (name ""))
  (when (environment-at :code code :graph graph)
    (error "Aledy exist. code=~code" code))
  (tx-make-vertex graph 'environment
                  `((code ,code) (name ,name))))

(defun make-environment (code &key (name "") (graph *tree*))
  (unless graph (setf graph (start)))
  (up:execute-transaction
   (tx-make-environment graph code :name name)))
