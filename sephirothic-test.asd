#|
  This file is a part of sephirothic project.
  Copyright (c) 2015 Satoshi Iwasaki (yanqirenshi@gmail.com)
|#

(in-package :cl-user)
(defpackage sephirothic-test-asd
  (:use :cl :asdf))
(in-package :sephirothic-test-asd)

(defsystem sephirothic-test
  :author "Satoshi Iwasaki"
  :license "LLGPL"
  :depends-on (:sephirothic
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "sephirothic"))))
  :description "Test system for sephirothic"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
