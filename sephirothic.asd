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
                 (:file "util" :depends-on ("package"))
                 (:file "class" :depends-on ("util"))
                 (:file "tree" :depends-on ("class"))
                 (:file "application" :depends-on ("tree"))
                 (:file "environment" :depends-on ("application"))
                 (:file "fruit" :depends-on ("environment"))
                 (:file "sephirothic" :depends-on ("key-value")))))
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
