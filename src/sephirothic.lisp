(in-package :sephirothic)

(defun fruit (tree application environment &rest query)
  (let* ((appl (application-at tree :code application))
         (env (environment-at tree :code environment :application application)))
    (assert env)
    (let ((fruit (find-fruit tree env query)))
      (when fruit
        (value fruit)))))

(defun (setf fruit) (value tree application environment &rest query)
  (assert tree)
  (let* ((appl (application-at tree :code application))
         (env (environment-at tree :code environment :application appl)))
    (assert env)
    (let ((fruit (find-fruit tree env query :auto-create t)))
      (assert fruit)
      (assert tree)
      (update-fruit tree fruit :value value))))

