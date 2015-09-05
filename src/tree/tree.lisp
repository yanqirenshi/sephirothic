(in-package :sephirothic)

(defun start (&key (tree-stor *tree-stor*))
  (unless tree-stor (error "tree-stor is empty."))
  (let ((data-stor tree-stor))
    (shinra:make-banshou 'shinra:banshou data-stor)))

(defun stop (tree &key (auto-commit nil))
  (unless tree
    (error "まだ初まってもいません。"))
  (when auto-commit
    (up:snapshot tree))
  (up:close-open-streams tree)
  (setf tree nil))

(defun commit (graph) (up:snapshot graph))

(defun restore (graph) (up:restore graph))
