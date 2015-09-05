(in-package :sephirothic)

;;;;;
;;;;; Key Value
;;;;;
(defun fruit-at (tree &key key)
  (assert tree)
  (is-keyword key)
  (find-object-with-slot tree 'fruit 'key key))

(defun tx-make-fruit (tree key value)
  (assert tree)
  (is-keyword key)
  (tx-make-vertex tree 'fruit
                  `((key ,key)
                    (value ,value))))

(defun tx-make-relationship (tree from to)
  (assert (and from to))
  (tx-make-edge tree 'relationship from to :r))

(defun get-children (tree parent)
  (shinra:find-r tree 'relationship :from parent))

(defun get-child (tree parent code &key (auto-create nil))
  (assert tree)
  (assert parent)
  (is-keyword code)
  (let ((child (find-if #'(lambda (data)
                            (eq (code (getf data :vertex)) code))
                        (get-children tree parent))))
    (or child
        (when auto-create
          (list :vertex  (add-fruit tree parent code nil)
                :edge nil))))) ;; TODO: U...n

(defun tx-add-fruit (tree parent key value)
  (assert (and tree parent))
  (is-keyword key)
  (when (get-child tree parent key)
    (error "Aledy exist. parent=~a, key=~a" parent key))
  (let ((fruit (tx-make-fruit tree key value)))
    (values fruit
            (tx-make-relationship tree parent fruit))))

(defun tx-update-fruit (tree fruit &key value)
  (up:tx-change-object-slots tree 'fruit (up:id fruit) `((value ,value)))
  fruit)

(defun update-fruit (tree fruit &key value)
  (up:execute-transaction
   (tx-update-fruit tree fruit :value value)))

(defgeneric add-fruit (tree parent key value)
  (:method (tree (parent symbol) key value)
    (add-fruit tree (fruit-at key) key value))

  (:method (tree (parent fruit) key value)
    (up:execute-transaction
     (tx-add-fruit tree parent key value)))

  (:method (tree (parent environment) key value)
    (up:execute-transaction
     (tx-add-fruit tree parent key value))))

(defun find-fruit (tree parent query &key (auto-create nil) (not-found-rise-error nil))
  (assert parent)
  (when query
    (let* ((key (car query))
           (next-query (cdr query))
           (childe (get-child tree parent key :auto-create auto-create)))
      (if (null childe)
          (when not-found-rise-error (error "not found fruit."))
          (if (null next-query)
              (getf childe :vertex)
              (find-fruit tree
                          (getf childe :vertex)
                          next-query
                          :auto-create auto-create
                          :not-found-rise-error not-found-rise-error))))))
