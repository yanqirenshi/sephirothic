(in-package :sephirothic)

(defun conf* (environment &rest query)
  (let ((env (environment-at :code environment)))
    (assert env)
    (unless *tree* (start))
    (let ((key-value (find-key-value env query)))
      (when key-value
        (value key-value)))))

(defun (setf conf*) (value environment &rest query)
  (let ((env (environment-at :code environment)))
    (assert env)
    (let ((graph *tree*)
          (key-value (find-key-value env query :auto-create t)))
      (unless graph (start))
      (assert key-value)
      (assert graph)
      (update-key-value graph key-value :value value))))

(defun conf (&rest query)
  (assert *environment*)
  (apply #'conf* *environment* query))

(defun (setf conf) (value &rest query)
  (assert *environment*)
  (apply #'(setf conf*) value *environment* query))

