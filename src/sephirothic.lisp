(in-package :sephirothic)

(defun fruit (tree application environment query
              &key (auto-create nil) (not-found-rise-error nil))
  (let* ((appl (application-at tree :code application))
         (env (environment-at tree :code environment :application appl)))
    (assert env)
    (let ((fruit (find-fruit tree env query
                             :auto-create auto-create
                             :not-found-rise-error not-found-rise-error)))
      (when fruit
        (value fruit)))))

(defun (setf fruit) (value tree application environment query
                     &key (auto-create t) (not-found-rise-error nil))
  (assert tree)
  (let* ((appl (application-at tree :code application))
         (env (environment-at tree :code environment :application appl)))
    (assert env)
    (let ((fruit (find-fruit tree env query
                             :auto-create auto-create
                             :not-found-rise-error not-found-rise-error)))
      (assert fruit)
      (assert tree)
      (update-fruit tree fruit :value value))))

