(in-package :cl-user)
(defpackage sephirothic
  (:nicknames :seph)
  (:use :cl)
  (:import-from #:world2world
                #:error*)
  (:import-from #:upanishad
                #:find-objects
                #:tx-change-object-slots
                #:%id
                #:execute-transaction
                #:close-open-streams)
  (:import-from #:shinrabanshou
                #:tx-make-vertex
                #:tx-make-edge
                #:make-banshou
                #:banshou
                #:find-r
                #:shin
                #:ra)
  (:export #:fruit*
           #:fruit
           #:*tree-stor*
           #:*tree*
           #:code
           #:applications
           #:application-at
           #:environments
           #:environment-at
           ;; tree
           #:make-tree
           #:close-tree
           #:snapshot
           #:restore
           ;; context
           #:get-sephirothic-context))
(in-package :sephirothic)
