(in-package :sephirothic)

(defun start ()
  (when *tree* (error "aledy started graph."))
  (unless *tree-stor* (error "*tree-stor* is empty."))
  (let ((data-stor *tree-stor*))
    (setf *tree*
          (shinra:make-banshou 'shinra:banshou data-stor))))

(defun stop (&key (auto-commit nil))
  (unless *tree*
    (error "まだ初まってもいません。"))
  (when auto-commit
    (up:snapshot *tree*))
  (up:close-open-streams *tree*)
  (setf *tree* nil))

(defun commit (&key (graph *tree*))
  (up:snapshot graph))

(defun restore (&key (graph *tree*))
  (up:restore graph))
