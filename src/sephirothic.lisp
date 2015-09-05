(in-package :sephirothic)

(defun conf* (environment &rest query)
  (let ((env (environment-at :code environment)))
    (assert env)
    (unless *tree* (start))
    (let ((fruit (find-fruit env query)))
      (when fruit
        (value fruit)))))

(defun (setf conf*) (value environment &rest query)
  (let ((env (environment-at :code environment)))
    (assert env)
    (let ((graph *tree*)
          (fruit (find-fruit env query :auto-create t)))
      (unless graph (start))
      (assert fruit)
      (assert graph)
      (update-fruit graph fruit :value value))))

(defun conf (&rest query)
  (assert *environment*)
  (apply #'conf* *environment* query))

(defun (setf conf) (value &rest query)
  (assert *environment*)
  (apply #'(setf conf*) value *environment* query))

