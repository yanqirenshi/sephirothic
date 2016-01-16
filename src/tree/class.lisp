(in-package :sephirothic)

(defclass node (shin)
  ((code :accessor code
         :initarg :code
         :initform nil)
   (name :accessor name
         :initarg :name
         :initform nil)
   (description :accessor description
                :initarg :description
                :initform nil))
  (:documentation ""))

(defclass application (node)
  ()
  (:documentation ""))

(defclass environment (node)
  ()
  (:documentation ""))

(defclass fruit (node)
  ((value :accessor value
          :initarg :value
          :initform nil))
  (:documentation ""))

(defclass relationship (ra)
  ()
  (:documentation ""))
