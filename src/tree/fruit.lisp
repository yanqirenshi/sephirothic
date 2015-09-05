(in-package :sephirothic)

;;;;;
;;;;; Key Value
;;;;;
(defun fruit-at (tree &key code)
  (assert tree)
  (is-keyword code)
  (find-object-with-slot tree 'fruit 'code code))

(defun tx-make-fruit (tree code value)
  (assert tree)
  (is-keyword code)
  (tx-make-vertex tree 'fruit
                  `((code ,code)
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

(defun tx-add-fruit (tree parent code value)
  (assert (and tree parent))
  (is-keyword code)
  (when (get-child tree parent code)
    (error "Aledy exist. parent=~a, code=~a" parent code))
  (let ((fruit (tx-make-fruit tree code value)))
    (values fruit
            (tx-make-relationship tree parent fruit))))

(defun tx-update-fruit (tree fruit &key value)
  (up:tx-change-object-slots tree 'fruit (up:id fruit) `((value ,value)))
  fruit)

(defun update-fruit (tree fruit &key value)
  (up:execute-transaction
   (tx-update-fruit tree fruit :value value)))

(defgeneric add-fruit (tree parent code value)
  (:method (tree (parent symbol) code value)
    (add-fruit tree (fruit-at code) code value))

  (:method (tree (parent fruit) code value)
    (up:execute-transaction
     (tx-add-fruit tree parent code value)))

  (:method (tree (parent environment) code value)
    (up:execute-transaction
     (tx-add-fruit tree parent code value))))

(defun find-fruit (tree parent query &key (auto-create nil) (not-found-rise-error nil))
  (assert parent)
  (when query
    (let* ((code (car query))
           (next-query (cdr query))
           (childe (get-child tree parent code :auto-create auto-create)))
      (if (null childe)
          (when not-found-rise-error (error "not found fruit."))
          (if (null next-query)
              (getf childe :vertex)
              (find-fruit tree
                          (getf childe :vertex)
                          next-query
                          :auto-create auto-create
                          :not-found-rise-error not-found-rise-error))))))
