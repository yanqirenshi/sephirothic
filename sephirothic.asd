#|
This file is a part of sephirothic project.
Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

#|
Author: Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

(in-package :cl-user)
(defpackage sephirothic-asd
  (:use :cl :asdf))
(in-package :sephirothic-asd)

(defsystem sephirothic
  :version "0.1"
  :author "Satoshi Iwasaki"
  :license "LLGPL"
  :depends-on (:upanishad
               :shinrabanshou)
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "message" :depends-on ("package"))
                 (:file "util" :depends-on ("package"))
                 (:module "tree"
                  :components ((:file "class")
                               (:file "tree" :depends-on ("class"))
                               (:file "node" :depends-on ("tree"))
                               (:file "application" :depends-on ("node"))
                               (:file "environment" :depends-on ("application"))
                               (:file "fruit" :depends-on ("environment")))
                  :depends-on ("util"))
                 (:file "sephirothic" :depends-on ("tree")))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op sephirothic-test))))
