(in-package :sephirothic)

;;;;;
;;;;; Key Value
;;;;;
(defun key-value-at (key &key (graph *tree*))
  (assert graph)
  (is-keyword key)
  (find-object-with-slot graph 'key-value 'key key))

(defun tx-make-key-value (graph key value)
  (assert graph)
  (is-keyword key)
  (tx-make-vertex graph 'key-value
                  `((key ,key)
                    (value ,value))))

(defun tx-make-relationship (graph from to)
  (assert (and from to))
  (tx-make-edge graph 'relationship from to :r))

(defun get-children (parent &key (graph *tree*))
  (shinra:find-r graph 'relationship :from parent))

(defun get-child (parent key &key (graph *tree*) (auto-create nil))
  (assert graph)
  (assert parent)
  (is-keyword key)
  (let ((child (find-if #'(lambda (data)
                            (eq (key (getf data :vertex)) key))
                        (get-children parent :graph graph))))
    (or child
        (when auto-create
          (list :vertex  (add-key-value graph parent key nil)
                :edge nil))))) ;; TODO: U...n


(defun tx-add-key-value (graph parent key value)
  (assert (and graph parent))
  (is-keyword key)
  (when (get-child parent key :graph graph)
    (error "Aledy exist. parent=~a, key=~a" parent key))
  (let ((key-value (tx-make-key-value graph key value)))
    (values key-value
            (tx-make-relationship graph parent key-value))))

(defun tx-update-key-value (graph key-value &key value)
  (up:tx-change-object-slots graph 'key-value (up:id key-value) `((value ,value)))
  key-value)

(defun update-key-value (graph key-value &key value)
  (up:execute-transaction
   (tx-update-key-value graph key-value :value value)))

(defgeneric add-key-value (graph parent key value)
  (:method (graph (parent symbol) key value)
    (add-key-value graph (key-value-at key) key value))

  (:method (graph (parent key-value) key value)
    (up:execute-transaction
     (tx-add-key-value graph parent key value)))

  (:method (graph (parent environment) key value)
    (up:execute-transaction
     (tx-add-key-value graph parent key value))))

(defun find-key-value (parent query &key (graph *tree*) (auto-create nil))
  (assert parent)
  (when query
    (let* ((key (car query))
           (next-query (cdr query))
           (childe (get-child parent key :auto-create auto-create)))
      (when childe
        (if (null next-query)
            (getf childe :vertex)
            (find-key-value (getf childe :vertex)
                            next-query
                            :graph graph
                            :auto-create auto-create))))))
