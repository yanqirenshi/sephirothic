(in-package :sephirothic)

(defclass node (shinra:shin)
  ((code :accessor code
         :initarg :code
         :initform nil)
   (name :accessor name
         :initarg :name
         :initform nil)
   (description :accessor description
                :initarg :description
                :initform nil)))

(defclass application (node) ())

(defclass environment (node) ())

(defclass fruit (node)
  ((value :accessor value
          :initarg :value
          :initform nil)))

(defclass relationship (shinra:ra) ())
