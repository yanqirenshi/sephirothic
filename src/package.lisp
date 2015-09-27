(in-package :cl-user)
(defpackage sephirothic
  (:nicknames :seph)
  (:use :cl)
  (:import-from #:world2world
                #:error*)
  (:import-from #:upanishad
                #:find-object-with-slot)
  (:import-from #:shinrabanshou
                #:tx-make-vertex
                #:tx-make-edge)
  (:export #:fruit*
           #:fruit
           #:*tree-stor*
           #:*tree*
           ;; appl
           #:application-at
           #:make-application
           ;; env
           #:environment-at
           #:make-environment
           ;; tree
           #:make-tree
           #:close-tree
           #:snapshot
           #:restore))
(in-package :sephirothic)
