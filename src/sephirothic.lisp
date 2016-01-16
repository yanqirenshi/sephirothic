(in-package :sephirothic)

;;;;;
;;;;; Initialize message
;;;;;
(w2w:add-messages *message-list*)


;;;;;
;;;;; Core
;;;;;
(defun fruit* (tree application environment query
               &key (auto-create nil) (not-found-rise-error nil))
  (let* ((appl (application-at tree :code application))
         (env (environment-at tree :code environment :application appl)))
    (assert env)
    (let ((fruit (find-fruit tree env query
                             :auto-create auto-create
                             :not-found-rise-error not-found-rise-error)))
      (when fruit
        (value fruit)))))

(defun (setf fruit*) (value tree application environment query
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


;;;;;
;;;;; Common
;;;;;
(defvar *tree* nil)
(defvar *tree-stor*
  (merge-pathnames (make-pathname :directory '(:relative ".sephirothic" "tree"))
                   ;; TODO: or (first (uiop:user-configuration-directories))
                   (user-homedir-pathname)))
(defvar *auto-create* t)
(defvar *not-found-rise-error* nil)

(defun get-internal-tree ()
  (unless *tree* (setf *tree* (make-tree *tree-stor*)))
  *tree*)

(defun get-sephirothic-context (&key
                                  (tree (get-internal-tree))
                                  application-code
                                  environment-code)
  (let* ((appl-code (or application-code (intern (package-name *package*) :keyword)))
         (env-code (or environment-code :anonymous))
         (appl (application-at tree :code appl-code :ensure t)))
    (values tree
            appl
            (environment-at tree :code env-code :application appl :ensure t)
            appl-code
            env-code)))

(defun fruit (&rest query)
  (multiple-value-bind (tree appl env)
      (get-sephirothic-context)
    (fruit* tree (code appl) (code env) query
            :auto-create *auto-create*
            :not-found-rise-error *not-found-rise-error*)))

(defun (setf fruit) (value &rest query)
  (multiple-value-bind (tree appl env)
      (get-sephirothic-context)
    (setf (fruit* tree (code appl) (code env) query
                  :auto-create *auto-create*
                  :not-found-rise-error *not-found-rise-error*)
          value)))
