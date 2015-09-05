(in-package :cl-user)
(defpackage sephirothic
  (:nicknames :seph)
  (:use :cl)
  (:import-from #:upanishad
                #:find-object-with-slot)
  (:import-from #:shinrabanshou
                #:tx-make-vertex
                #:tx-make-edge)
  (:export #:*tree-stor*
           #:*tree*
           ;; appl
           #:application-at
           #:make-application
           ;; env
           #:environment-at
           #:make-environment
           ;; fruit
           #:fruit))
(in-package :sephirothic)

(defvar *tree-stor* nil)
(defvar *tree* nil)
