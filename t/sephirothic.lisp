(in-package :cl-user)
(defpackage sephirothic-test
  (:use #:cl
        #:sephirothic
        #:prove))
(in-package :sephirothic-test)

(plan 2)

(defvar *data-stor*
  ;; TODO: Bad code
  (concatenate 'string (princ-to-string (asdf:system-source-directory :sephirothic)) "t/data/"))

(defun cleanup-transaction-file (data-stor)
  (let ((file (probe-file (concatenate 'string data-stor "transaction-log.xml"))))
    (when file (delete-file file))))

(subtest "basic1"
  (unwind-protect
       (let ((tree nil)
             (appl-code :sephirothic-tree)
             (env-code :production)
             (query '(:http :server :port))
             (appl nil)
             (env  nil))
         (cleanup-transaction-file *data-stor*)
         (setf tree (make-tree *data-stor*))
         (ok tree "Start tree")

         (make-application tree appl-code :name "生命の木")
         (setf appl (application-at tree :code appl-code))
         (is (seph:code appl) appl-code "Create application")

         (seph::add-environment tree appl env-code :name "本番環境")
         (setf env (environment-at tree :code env-code :application appl))
         (is (seph:code env) env-code "Create environment")

         (is (fruit* tree :sephirothic-tree :production query) nil "can return nil")
         (is-error (fruit* tree :sephirothic-tree :production query :not-found-rise-error t)
                   'simple-error "rise error. not found")

         (ok (setf (fruit* tree :sephirothic-tree :production query) 999))
         (is (fruit* tree :sephirothic-tree :production query) 999)

         (is (close-tree tree) nil "Stop tree"))
    (close-tree tree)))

(subtest "basic2"
  (unwind-protect
       (let ((tree nil)
             (appl-code :sephirothic-tree)
             (env-code :production)
             (query '(:http :server :port))
             (appl nil)
             (env  nil))
         (cleanup-transaction-file *data-stor*)

         (setf tree (make-tree *data-stor*))
         (ok tree "Start tree")
         (setf appl (application-at tree :code appl-code :ensure t))
         (is (seph:code appl) appl-code "Create application")

         (setf env (environment-at tree :code env-code :application appl :ensure t))
         (is (seph:code env) env-code "Create environment")

         (is (fruit* tree :sephirothic-tree :production query) nil "can return nil")
         (is-error (fruit* tree :sephirothic-tree :production query :not-found-rise-error t)
                   'simple-error "rise error. not found")

         (ok (setf (fruit* tree :sephirothic-tree :production query) 999))
         (is (fruit* tree :sephirothic-tree :production query) 999)

         (is (close-tree tree) nil "Stop tree"))
    (close-tree tree))))

(finalize)
