(in-package :cl-user)
(defpackage sephirothic-test
  (:use :cl
   :sephirothic
        :prove))
(in-package :sephirothic-test)

(plan 9)

(let ((tree nil)
      (data-stor (concatenate 'string (princ-to-string (asdf:system-source-directory :sephirothic)) "t/data/")) ;; TODO: Bad code
      (appl-code :sephirothic-tree)
      (env-code :production)
      (query '(:http :server :port))
      (appl nil)
      (env  nil))

  (let ((file (probe-file (concatenate 'string data-stor "transaction-log.xml"))))
    (when file (delete-file file))) ;; TODO: get file list

  (setf tree (stree::start :tree-stor data-stor))
  (ok tree "Start tree")
  (ok (make-application tree appl-code :name "生命の木"))

  (setf appl (application-at tree :code appl-code))
  (is (stree::code appl) appl-code "Create application")

  (stree::add-environment tree appl env-code :name "本番環境")
  (setf env (environment-at tree :code env-code :application appl))
  (is (stree::code env) env-code "Create environment")

  (is (fruit tree :sephirothic-tree :production query) nil "can return nil")
  (is-error (fruit tree :sephirothic-tree :production query :not-found-rise-error t)
            'simple-error "rise error. not found")

  (ok (setf (fruit tree :sephirothic-tree :production query) 999))
  (is (fruit tree :sephirothic-tree :production query) 999)

  (is (stree::stop tree) nil "Stop tree"))

(finalize)
