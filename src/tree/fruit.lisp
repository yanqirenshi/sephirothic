(in-package :sephirothic)

;;;;;
;;;;; Key Value
;;;;;
(defun fruit-at (key &key (graph *tree*))
  (assert graph)
  (is-keyword key)
  (find-object-with-slot graph 'fruit 'key key))

(defun tx-make-fruit (graph key value)
  (assert graph)
  (is-keyword key)
  (tx-make-vertex graph 'fruit
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
          (list :vertex  (add-fruit graph parent key nil)
                :edge nil))))) ;; TODO: U...n


(defun tx-add-fruit (graph parent key value)
  (assert (and graph parent))
  (is-keyword key)
  (when (get-child parent key :graph graph)
    (error "Aledy exist. parent=~a, key=~a" parent key))
  (let ((fruit (tx-make-fruit graph key value)))
    (values fruit
            (tx-make-relationship graph parent fruit))))

(defun tx-update-fruit (graph fruit &key value)
  (up:tx-change-object-slots graph 'fruit (up:id fruit) `((value ,value)))
  fruit)

(defun update-fruit (graph fruit &key value)
  (up:execute-transaction
   (tx-update-fruit graph fruit :value value)))

(defgeneric add-fruit (graph parent key value)
  (:method (graph (parent symbol) key value)
    (add-fruit graph (fruit-at key) key value))

  (:method (graph (parent fruit) key value)
    (up:execute-transaction
     (tx-add-fruit graph parent key value)))

  (:method (graph (parent environment) key value)
    (up:execute-transaction
     (tx-add-fruit graph parent key value))))

(defun find-fruit (parent query &key (graph *tree*) (auto-create nil))
  (assert parent)
  (when query
    (let* ((key (car query))
           (next-query (cdr query))
           (childe (get-child parent key :auto-create auto-create)))
      (when childe
        (if (null next-query)
            (getf childe :vertex)
            (find-fruit
             (getf childe :vertex)
             next-query
             :graph graph
             :auto-create auto-create))))))
