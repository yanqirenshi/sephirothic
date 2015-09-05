(in-package :cl-user)
(defpackage sephirothic
  (:nicknames :seph)
  (:use :cl)
  (:import-from :upanishad
   :find-object-with-slot)
  (:import-from :shinrabanshou
                :tx-make-vertex
                :tx-make-edge)
  (:export :*tree-stor*
           :*application-root*
           :*static-directory*
           :init
           ;; env
           :environment-at
           :make-environment
           ;; fruit
           :fruit-at
           :get-children
           :get-child
           :update-fruit
           :add-fruit
           :find-fruit
           ;; sephirothic
           :conf*
           :conf))
(in-package :sephirothic)

(defparameter *environment* nil "keyword symbol")
(defparameter *tree-stor* nil)
(defvar *tree* nil)

(defun init (environment data-stor)
  (values (setf *environment* environment)
          (setf *tree-stor* data-stor)))
